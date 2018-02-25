# kerub-centos

[Kerub](https://github.com/kerubistan/kerub) packaging for [openSuse](https://opensuse.org) 42.3 with [tomcat 8](https://tomcat.apache.org/)

## Notes

 * builds on tomcat since there is absolutely no jetty packaged in openSuse
 * but at least there is tomcat 8 with some support for static compression

## Installation notes

* recommended pre-installation:
  * if you run kerub in a virtual machine, please add a RNG device to the VM

* recommended post-installation steps:
  * configure clustering
  * change the controller key
  * setup security
  * modify motd
  * set tomcat autostart ```systemctl enable tomcat```
  * modify virtual machine memory parameters if needed
