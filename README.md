### Table of Contents
***
1. [General Info](#general-info)
2. [Technologies](#technologies)
3. [Installation](#installation)
4. [License](#License)
5. [Ressources](#Ressources)

### General Info
***
Hello World!

My name is Mickaël alias sodbaveka.
I created this repository as a lab to discover git, gitHub, Bash, Python and Ansible.

My project as a learner is to create a bash script which can be used to create a powerful Nagios Plugin in order to check writing in an rsyslog database.

The backup script takes care of :
- Making entry in the system log
- Checking new entry in rsyslog database

A Nagios plugin have to send a return code. This interpreted code is the result of the plugin execution. We call this result “status”.

Save this script in /usr/lib/nagios/plugins/check_rsyslog_db.sh and make it executable :

$ chmod +x /usr/lib/nagios/plugins/check_rsyslog_db.sh

Now you need to define new command in your nagios server command file /etc/nagios/objects/commands.cfg
define command{
command_name check_rsyslog_db
command_line $USER1$/check_rsyslog_db.sh
}

And then you must add a new service check on Nagios Server side.
define service {
use local-service ; Name of service template to use
host_name monitor_host
service_description Rsyslog Database Writing
check_command check_rsyslog_db
check_interval 10
retry_interval 2
max_check_attempts 3
first_notification_delay 0
notification_interval 0
contacts nagiosadmin
}

In order to verify your configuration, run Nagios with the -v command line option like so:

$ /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

The last step is to restart the nagios service using this command

$ service nagios restart


Please feel free to message me if you have any questions.

Bye ;-)

### Technologies
***
A list of technologies used within the project :
* Linux Debian 10.8

### Installation
***
* Download :
```
$  git clone https://github.com/sodbaveka/check_rsyslog_db_nagios_plugin.git
```

* Launch :
```
$ cd ../path/to/the/file
$ ./check_rsyslog_db.sh
```

### License
***
* Copyright: (c) 2021, Mickaël Duchet <sodbaveka@gmail.com>
* GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

### Ressources
***
* https://exchange.nagios.org/
* 'bash for dummies’ :-p 
