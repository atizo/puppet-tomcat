#
# tomcat module
#
# Copyright 2008, Puzzle ITC
# Copyright 2010, Atizo AG
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi simon.josi+puppet(at)atizo.com
#
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

class tomcat {
  require java
  package{'tomcat5']:
    ensure => present,
  }
  service{'tomcat5':
    ensure => running,
    enable => true,
    hasstatus => true,
    require => Package['tomcat5'],
  }
  file{'/etc/tomcat5/server.xml':
    source => [
      "puppet://$server/modules/site-tomcat/$fqdn/server.xml",
      "puppet://$server/modules/site-tomcat/server.xml",
      "puppet://$server/modules/tomcat/server.xml",
    ],
    require => Package ['tomcat5'],
    notify => Service['tomcat5'],
    owner => root, group => 0, mode => 0644;
  }
  file{'/etc/sysconfig/tomcat5':
    source => [
      "puppet://$server/modules/site-tomcat/sysconfig/$fqdn/tomcat5",
      "puppet://$server/modules/site-tomcat/sysconfig/tomcat5",
      "puppet://$server/modules/tomcat/sysconfig/tomcat5",
    ],
    require => Package['tomcat5'],
    notify => Service['tomcat5'],
    owner => root, group => 0, mode => 0644;
  }
}
