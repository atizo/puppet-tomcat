#
# tomcat module
#
# Copyright 2008, Puzzle ITC
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

class tomcat {
    case $operatingsystem {
        centos: { include tomcat::centos }
        default: { include tomcat::base }
    }
}

class tomcat::base {
    include java

    package{'tomcat5':
        ensure => present,
        require => Package['java-1.6.0-sun'],
    }
    service{tomcat5:
        ensure => running,
        enable => true,
        hasstatus => true,
        require => Package['tomcat5'],
    }
}

class tomcat::centos inherits tomcat::base {
    file{'/etc/sysconfig/tomcat5':
        source => [ "puppet://$server/files/tomcat/sysconfig/${fqdn}/tomcat5",
                    "puppet://$server/files/tomcat/sysconfig/tomcat5",
                    "puppet://$server/tomcat/sysconfig/${fqdn}/tomcat5" ],
        require => Package['tomcat5'],
        notify => Service['tomcat5'],
        owner => root, group => 0, mode => 0644;
    }
}
