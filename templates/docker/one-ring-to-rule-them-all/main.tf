terraform {
  required_providers {
    coder = {
      source = "coder/coder"
    }
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

data "coder_parameter" "image" {
  name        = "Container Image"
  type        = "string"
  description = "What container image do you want?"
  mutable     = true
  default     = "sololaboratories/base:debian"
  icon        = "/icon/container.svg"
  order       = 1

  option {
    name = "Debian Base"
    value = "sololaboratories/base:debian"
  }  
  option {
    name = "C++ Base (No Compiler)"
    value = "sololaboratories/cpp:base"
  }  
  option {
    name = "Clang 18"
    value = "sololaboratories/cpp:clang18"
  }
  option {
    name = "K8s Jumpbox"
    value = "sololaboratories/k8s:jumpbox"
  }
  option {
    name = "Golang 1.23.2"
    value = "sololaboratories/golang:1.23.2"
  }
  option {
    name = "Zig 2-10-2024"
    value = "sololaboratories/zig:2-10-2024"
  }
  option {
    name = "C# (Debian 12) Dotnet 8"
    value = "sololaboratories/c-sharp:8"
  }
}

data "coder_provisioner" "me" {
}

provider "docker" {
}

data "coder_workspace" "me" {
}

resource "coder_agent" "main" {
  arch           = data.coder_provisioner.me.arch
  os             = "linux"
  startup_script = <<-EOT
    set -e

    # Prepare user home with default files on first start.
    if [ ! -f ~/.init_done ]; then
      cp -rT /etc/skel ~
      touch ~/.init_done
    fi

    # Executes Bashrc check script
    curl -fsSL https://raw.githubusercontent.com/Solo-Laboratories/devops-coder/main/scripts/bashrc.sh | sh -

    # IFF true; Execute Install for k9s
    if ${data.coder_parameter.k9s.value}; then
      echo "K9s Addon selected..."
      curl -fsSL https://raw.githubusercontent.com/Solo-Laboratories/devops-coder/main/scripts/k9s.sh | sh -
    fi

    # IFF true; Execute Install for Kompose
    if ${data.coder_parameter.kompose.value}; then
      echo "Kompose Addon selected..."
      curl -fsSL https://raw.githubusercontent.com/Solo-Laboratories/devops-coder/main/scripts/kompose.sh | sh -s -- 1.34.0
    fi

    # IFF true; Execute Install for Coder CLI
    if ${data.coder_parameter.coder.value}; then
      echo "Coder CLI Addon selected..."
      export CODER_USER_TOKEN=${data.coder_workspace_owner.me.session_token}
      export CODER_DEPLOYMENT_URL=${data.coder_workspace.me.access_url}
      curl -fsSL https://raw.githubusercontent.com/Solo-Laboratories/devops-coder/main/scripts/coder.sh | sh -
    fi

    # Executes Standard Configuration changes
    curl -fsSL https://raw.githubusercontent.com/Solo-Laboratories/devops-coder/main/scripts/config-setup.sh | sh -

    # Executes Coder server startup
    curl -fsSL https://raw.githubusercontent.com/Solo-Laboratories/devops-coder/main/scripts/code-server.sh | sh -
  EOT

  # These environment variables allow you to make Git commits right away after creating a
  # workspace. Note that they take precedence over configuration defined in ~/.gitconfig!
  # You can remove this block if you'd prefer to configure Git manually or using
  # dotfiles. (see docs/dotfiles.md)
  env = {
    GIT_AUTHOR_NAME     = coalesce(data.coder_workspace.me.owner_name, data.coder_workspace.me.owner)
    GIT_AUTHOR_EMAIL    = "${data.coder_workspace.me.owner_email}"
    GIT_COMMITTER_NAME  = coalesce(data.coder_workspace.me.owner_name, data.coder_workspace.me.owner)
    GIT_COMMITTER_EMAIL = "${data.coder_workspace.me.owner_email}"
  }

  # The following metadata blocks are optional. They are used to display
  # information about your workspace in the dashboard. You can remove them
  # if you don't want to display any information.
  # For basic resources, you can use the `coder stat` command.
  # If you need more control, you can write your own script.
  metadata {
    display_name = "CPU Usage"
    key          = "0_cpu_usage"
    script       = "coder stat cpu"
    interval     = 10
    timeout      = 1
  }

  metadata {
    display_name = "RAM Usage"
    key          = "1_ram_usage"
    script       = "coder stat mem"
    interval     = 10
    timeout      = 1
  }

  metadata {
    display_name = "Home Disk"
    key          = "3_home_disk"
    script       = "coder stat disk --path $${HOME}"
    interval     = 60
    timeout      = 1
  }

  metadata {
    display_name = "CPU Usage (Host)"
    key          = "4_cpu_usage_host"
    script       = "coder stat cpu --host"
    interval     = 10
    timeout      = 1
  }

  metadata {
    display_name = "Memory Usage (Host)"
    key          = "5_mem_usage_host"
    script       = "coder stat mem --host"
    interval     = 10
    timeout      = 1
  }

  metadata {
    display_name = "Load Average (Host)"
    key          = "6_load_host"
    # get load avg scaled by number of cores
    script   = <<EOT
      echo "`cat /proc/loadavg | awk '{ print $1 }'` `nproc`" | awk '{ printf "%0.2f", $1/$2 }'
    EOT
    interval = 60
    timeout  = 1
  }

  metadata {
    display_name = "Swap Usage (Host)"
    key          = "7_swap_host"
    script       = <<EOT
      free -b | awk '/^Swap/ { printf("%.1f/%.1f", $3/1024.0/1024.0/1024.0, $2/1024.0/1024.0/1024.0) }'
    EOT
    interval     = 10
    timeout      = 1
  }
}

resource "coder_app" "code-server" {
  agent_id     = coder_agent.main.id
  slug         = "code-server"
  display_name = "code-server"
  url          = "http://localhost:13337/?folder=/home/coder"
  icon         = "/icon/code.svg"
  subdomain    = false
  share        = "owner"

  healthcheck {
    url       = "http://localhost:13337/healthz"
    interval  = 5
    threshold = 6
  }
}

resource "docker_volume" "home_volume" {
  name = "coder-${data.coder_workspace.me.id}-home"
  # Protect the volume from being deleted due to changes in attributes.
  lifecycle {
    ignore_changes = all
  }
  # Add labels in Docker to keep track of orphan resources.
  labels {
    label = "coder.owner"
    value = data.coder_workspace.me.owner
  }
  labels {
    label = "coder.owner_id"
    value = data.coder_workspace.me.owner_id
  }
  labels {
    label = "coder.workspace_id"
    value = data.coder_workspace.me.id
  }
  # This field becomes outdated if the workspace is renamed but can
  # be useful for debugging or cleaning out dangling volumes.
  labels {
    label = "coder.workspace_name_at_creation"
    value = data.coder_workspace.me.name
  }
}

resource "docker_container" "workspace" {
  count = data.coder_workspace.me.start_count
  image = "docker.io/${data.coder_parameter.image.value}"
  # Uses lower() to avoid Docker restriction on container names.
  name = "coder-${data.coder_workspace.me.owner}-${lower(data.coder_workspace.me.name)}"
  # Hostname makes the shell more user friendly: coder@my-workspace:~$
  hostname = data.coder_workspace.me.name
  # Use the docker gateway if the access URL is 127.0.0.1
  entrypoint = ["sh", "-c", replace(coder_agent.main.init_script, "/localhost|127\\.0\\.0\\.1/", "host.docker.internal")]
  env        = ["CODER_AGENT_TOKEN=${coder_agent.main.token}"]
  host {
    host = "host.docker.internal"
    ip   = "host-gateway"
  }
  volumes {
    container_path = "/home/coder"
    volume_name    = docker_volume.home_volume.name
    read_only      = false
  }

  # Add labels in Docker to keep track of orphan resources.
  labels {
    label = "coder.owner"
    value = data.coder_workspace.me.owner
  }
  labels {
    label = "coder.owner_id"
    value = data.coder_workspace.me.owner_id
  }
  labels {
    label = "coder.workspace_id"
    value = data.coder_workspace.me.id
  }
  labels {
    label = "coder.workspace_name"
    value = data.coder_workspace.me.name
  }
}
