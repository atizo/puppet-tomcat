class tomcat::webapps {
  include tomcat 
  package{'tomcat5-webapps':
    ensure => present,
    require => Package['tomcat5'],
  }
}
