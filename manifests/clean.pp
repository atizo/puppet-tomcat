# manifests/clean.pp

class tomcat::clean {
    file{ [ '/var/lib/tomcat5/webapps/jsp-examples',
            '/var/lib/tomcat5/webapps/servlets-examples' ]:
        ensure => absent,
        purge => true,
        force => true,
        require => Package['tomcat5'],
        notify => Service['tomcat5'],
    }
}
