class tomcat::lib::xalan {
  include tomcat
  package{'xalan-j2':
    ensure => installed,
  }
  if $lsbmajdistrelease == 5 {
    file{'/usr/share/tomcat5/shared/lib/xalan-j2.jar':
      ensure => link,
      target => '/usr/share/java/xalan-j2.jar',
      require => Package['tomcat5'],
      notify => Service['tomcat5'],
    }
  }
}
