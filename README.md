# devops-coder
Coder related workings

## Templates

As it appears, templates is the Terraform template files used for Coder to make Templates that workspaces are based off. Please note key points. Any "-custom" .tf files are using custom build docker images. Currently these images reside behind closed doors so you will have to build and deploy your own AND change any reference of the image location in the .tf file. Hint: look for anything "sololab.one" domain attached and change it to your image registry.

### Docker

Templates for Coder deployed in or using Docker.

### Kubernetes

Templates for Coder deployed in or using Kubernetes.

## Dockerfiles

The docker files are the custom files for the templates above. Mostly they install the tools I required for each workspace BUT they also changed the user to 'markus'. Make sure to change that OR wrap in dockerfile variable that is passed in during building. Add any tools you need but provide those changes logically to this repository PLZ AND THNKS!

## Notes

If you're using Coder in Kubernetes AND want to use a private registry then I suggest you [follow this guide](https://coder.com/docs/guides/image-pull-secret). I used this to pull from my private ghcr.io registry for all the images.
