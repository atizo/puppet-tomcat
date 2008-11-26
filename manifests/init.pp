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

$TOMCAT_MODSDIR='/var/lib/puppet/modules/tomcat'
$TOMCAT_VHOSTSDIR="$TOMCAT_MODSDIR/vhosts"

modules_dir { [ "tomcat", "tomcat/vhosts" ]: }

import "defines.pp"


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

    file{"${TOMCAT_MODSDIR}/server_header.xml":
        source => [ "puppet://$server/files/tomcat/config/${fqdn}/server_header.xml",
                    "puppet://$server/files/tomcat/config/server_header.xml",
                    "puppet://$server/tomcat/config/${operatingsystem}/server_header.xml",
                    "puppet://$server/tomcat/config/server_header.xml" ],
        owner => root, group => 0, mode => 0600;
    }
    file{"${TOMCAT_MODSDIR}/server_footer.xml":
        source => [ "puppet://$server/files/tomcat/config/${fqdn}/server_footer.xml",
                    "puppet://$server/files/tomcat/config/server_footer.xml",
                    "puppet://$server/tomcat/config/${operatingsystem}/server_footer.xml",
                    "puppet://$server/tomcat/config/server_footer.xml" ],
        owner => root, group => 0, mode => 0600;
    }
    concatenated_file{'/etc/tomcat5/server.xml':
        dir => "${TOMCAT_VHOSTSDIR}",
        header => "${TOMCAT_MODSDIR}/server_header.xml",
        footer => "${TOMCAT_MODSDIR}/server_footer.xml",
        require => [ File["${TOMCAT_MODSDIR}/server_header.xml"], File["${TOMCAT_MODSDIR}/server_footer.xml"], Package['tomcat5'] ],
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
