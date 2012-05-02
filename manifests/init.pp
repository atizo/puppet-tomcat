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

  # CentOS 5 ships tomcat5 and CentOS tomcat 6
  # this way we can use lsbmajdistrelease

  package{'tomcat':
    name => "tomcat${lsbmajdistrelease}",
    ensure => present,
  }
  service{'tomcat':
    name => "tomcat${lsbmajdistrelease}",
    ensure => running,
    enable => true,
    hasstatus => true,
    require => Package['tomcat'],
  }
  file{'server.xml':
    path => "/etc/tomcat${lsbmajdistrelease}/server.xml",
    source => [
      "puppet://$server/modules/site-tomcat/$fqdn/server${lsbmajdistrelease}.xml",
      "puppet://$server/modules/site-tomcat/server${lsbmajdistrelease}.xml",
      "puppet://$server/modules/tomcat/server${lsbmajdistrelease}.xml",
    ],
    require => Package ['tomcat'],
    notify => Service['tomcat'],
    owner => root, group => 0, mode => 0644;
  }
  file{'sysconfig':
    path => "/etc/sysconfig/tomcat${lsbmajdistrelease}",
    source => [
      "puppet://$server/modules/site-tomcat/$fqdn/sysconfig${lsbmajdistrelease}",
      "puppet://$server/modules/site-tomcat/sysconfig${lsbmajdistrelease}",
      "puppet://$server/modules/tomcat/sysconfig${lsbmajdistrelease}",
    ],
    require => Package['tomcat'],
    notify => Service['tomcat'],
    owner => root, group => 0, mode => 0644;
  }
}
