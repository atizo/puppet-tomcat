# manifests/webapps.pp

class tomcat::webapps {
    package{'tomcat5-webapps':
        ensure => present,
        require => Package['tomcat5'],
    }
}
