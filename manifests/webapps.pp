class tomcat::webapps {
  include tomcat 
  package{'tomcat-webapps':
    name => "tomcat${lsbmajdistrelease}-webapps",
    ensure => present,
    require => Package['tomcat'],
  }
}
