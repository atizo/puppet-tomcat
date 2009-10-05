# manifests/centos.pp

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
