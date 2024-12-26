# DevOps Coder v2 Helper
Coder related items for constructing your workspace. Houses the docker files, templates, and scripts for automatically downloading or installing items.

## Folder Structure and Meaning
### Templates
These are the templates that are used in Coder. Coder converts terraform files into workspaces for using. Each template will be organized based on name. This name is what will appear in Coder as well. The templates are organized by target. Currently, we support templates for kubernetes and docker. 

_Note:_ Docker templates are rather old and out dated. The primary target we use is Kubernetes and as such they are more up to date. If you want to update the docker templates (or any template for that matter) then follow the normal procedure outlined below.

_Helper:_ If you want to push the template, you want to change directory into the folder under "templates" and push it using the coder-cli. Here is an example for the template 'One Ring To Rule Them All'. `cd templates/kubernetes/one-ring-to-rule-them-all && coder templates push --name v1.2.3` where it pushes the version v1.2.3 to your coder instance. You  may need to login first so  keep that in mind and use the coder-cli to help guide you through that process.

### Scripts
The files under scripts are scripts used in the template to do all sorts of dynamic means. Where things that never change should be in the template itself, such as an image name or where the pvc is mounted, scripts are meant for things that need to change or may not always be required. For example, VSCode server needs to be updated frequently so there is a script that will update it. The templates reference the script directly from the web, which means changing the script will not require a new template pushed.

The point of the scripts are so you don't need to change the template version each time you update a tool. You just need to update the version the script updates and it will automatically update the tool. 

_Note:_ The scripts should be written with others in mind. This means there can be a "latest" version but should be able to be overwritten. For example, if you rely on a particular version of a tool, the script should allow for overriding the default version by passing in the version. That way, you can specify the version you need in the template but if not specified, it will "update" automatically on each workspace start.

_Note:_ Not all tools are in a script and the line is ambigous so don't question why k9s is a script but helm is baked into the container itself. This will hopefully change over time.

### Dockerfiles
As the folder name suggests, it houses all the workspace container docker files. They are built using a workflow with specific variables and pushed to our [Solo Laboratories Dockerhub](https://hub.docker.com/u/sololaboratories).

This files don't really focus on small sizes as the workspaces are more like "lite" OS environments. This may change in time but right now, we install what we need and push the container as a particular version. These images are used in the templates as a "snapshot" of the tools used in the workspace.

## Development
### Templates
If you see a feature you want to be part of the template, make a PR with the changes but keep in mind that others may use the template so don't try to make them too specialized. If you do want a specialized template that you feel others will want, make a new folder with the 'main.tf' and a 'README.md' for others to use.

_Checklists:_
- [ ] Everything used must be reachable from anyone using the template
- [ ] No specialized to you items (i.e. container with your name as the user, etc)
- [ ] Updates must try to keep backwards compatibility if possible but isn't bad if you cannot achieve this

### Scripts
Scripts need to allow for flexibility such as a default version vs specifying a version. Don't update the version of a script if there is no way to specify it. Since the templates use these scripts (pointed to the remote git repository), updating the version  may affect anyone using the script.

### Dockerfiles
The folder structure should explain what the container is. Meaning, '.../cpp/clang/Dockerfile' should be clear that the docker file installs tools around Clang. Include logical argument variables in the file that can help make the dockerfile more dynamic. Continuing the above example, mayb

### Workflow
The workflow will ask for the dockerfile location in reference to the root, the name of the container, tag, and any build arguments. Each docker file should have a corresponding workflow file that will be triggered manually. That way we can update the container at anypoint we like.
