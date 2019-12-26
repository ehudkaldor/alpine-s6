# Alpine Linux base image, with S6-overlay and confd

This is a base docker image, using Alpine Linux as base, with S6-overlay as process manager and conf.d for configuration management.

Current versions:
Alpine Linux: 3.11
S6-overlay: 1.22.1.0
Socklog-overlay: 3.1.0-2

confd is installed from repository.

if you are not familiar with S6, head over to [S6 overlay repo](https://github.com/just-containers/s6-overlay), and there you will find explanations and links to S6 itself.

confd is configured to use env variable, but this can be changed in the confd config file under `rootfs/etc/confd/confd.toml`

Also note that there are two main branches: master and rpi. rpi is meant for ARM-based devices. And though Alpine can now be pulled generically for all architectures, S6-overlay is still architecture-specific. Currently that is the only difference between the branches.
