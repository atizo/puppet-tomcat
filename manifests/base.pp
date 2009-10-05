# manifests/base.pp

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
    file{"/var/lib/puppet/modules/tomcat/server_header.xml":
        source => [ "puppet://$server/files/tomcat/config/${fqdn}/server_header.xml",
                    "puppet://$server/files/tomcat/config/server_header.xml",
                    "puppet://$server/tomcat/config/${operatingsystem}/server_header.xml",
                    "puppet://$server/tomcat/config/server_header.xml" ],
        owner => root, group => 0, mode => 0600;
    }
    file{"/var/lib/puppet/modules/tomcat/server_footer.xml":
        source => [ "puppet://$server/files/tomcat/config/${fqdn}/server_footer.xml",
                    "puppet://$server/files/tomcat/config/server_footer.xml",
                    "puppet://$server/tomcat/config/${operatingsystem}/server_footer.xml",
                    "puppet://$server/tomcat/config/server_footer.xml" ],
        owner => root, group => 0, mode => 0600;
    }
    concatenated_file{'/etc/tomcat5/server.xml':
        dir => "/var/lib/puppet/modules/tomcat/vhosts",
        header => "/var/lib/puppet/modules/tomcat/server_header.xml",
        footer => "/var/lib/puppet/modules/tomcat/server_footer.xml",
        require => [ File["/var/lib/puppet/modules/tomcat/server_header.xml"], 
                     File["/var/lib/puppet/modules/tomcat/server_footer.xml"], 
                     Package['tomcat5'] ],
    }
}
