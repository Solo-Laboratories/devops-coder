# One Ring to Rule Them All!

This template houses the ability to select what image to use allowing for the user to switch between images. This means one could house all the works in one area and swtich between what tools to use by picking a new image to use.

## Important Notes
Some aspects of this template uses a script to install a tool while other tools are selected by changing the image. This 'choice' is sort of abstract right now. Basically, if the tool does not have an "apt" install OR needs to be updated quickly, then make a script and install it. Otherwise, change the dockerfile to include the installation in the base.