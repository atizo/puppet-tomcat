class tomcat::clean {
  include tomcat::webapps
  if $lsbmajdistrelease == 5 {
    file{ [ '/var/lib/tomcat5/webapps/jsp-examples',
            '/var/lib/tomcat5/webapps/servlets-examples', ]:
      ensure => absent,
      purge => true,
      force => true,
      require => Package['tomcat-webapps'],
      notify => Service['tomcat'],
    }
  }
}
