# shell-environment

A repository to house my public shell environment resources and the template for the private ones.
I mostly created this so I can have the same aliases, functions , variables, and activated options available on any machine I am using if I want them.

The `./install` script will stash away anything that already exists in `~/shell-environment-backup` and put in place this environment for `sh`, `bash`, and `zsh`

Once installed for your shell, you should enter the repository (~/.shell-environment) and run `git update-index --assume-unchanged private_resources/*` so that private datapoints entered do not accidentally get commited and pushed to remote.