
# josh5/base-ubuntu

### Based upon [Ubuntu Linux](https://hub.docker.com/_/ubuntu/) and [S6 overlay](https://github.com/just-containers/s6-overlay), this serves as a base template container for all other docker containers created by Josh.5.

![ubuntu](https://logos-download.com/wp-content/uploads/2016/02/Ubuntu_logo.png)

## Features:
|  |  |
| --- | --- |
| Base:  | Ubuntu  |
| Init:  | s6 overlay  |
| Additinal services:  | ca-certificates  |
|   | curl  |
|   | bash-completion  |
|   | coreutils  |
|   | nano  |
|   | openssh-server  |
|   | tar  |
|   | unzip  |

## Configuration:

Configuration is stored in /config/
User's app binaries can be installed to /app
* Default user "docker"
* Hosts file configurable in /config/hosts
* SSH access to root with password 'root'

Additional params to your container:
* `-e PGID` for setting the GroupID of the default user
* `-e PUID` for setting the UserID of the default user
* `-e TZ` for setting timezone information, eg Europe/London


## NOTES:
It is strongly recommended that you change the default root password for ssh login if you intened to use it in production.
Change the password with
```bash
echo "root:something_else" | chpasswd
```
or to disable root access in ssh login all together:
```bash
sed -i s/#PermitRootLogin.*/PermitRootLogin\ no/ /etc/ssh/sshd_config
```