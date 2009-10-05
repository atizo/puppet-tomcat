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

class tomcat {
    case $operatingsystem {
        centos: { include tomcat::centos }
        default: { include tomcat::base }
    }
}
