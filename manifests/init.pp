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

# modules_dir { \"tomcat\": }

class tomcat {
    include tomcat::base
}

class tomcat::base {
    include java

    package{ [ 'tomcat5', 'tomcat5-webapps' ]:
        ensure => present,
    }
    service{tomcat5:
        ensure => running,
        enable => true,
        hasstatus => true,
        require => [ Package['tomcat5'], Package['tomcat5-webapps'], Package['java-1.6.0-sun'] ],
    }
}
