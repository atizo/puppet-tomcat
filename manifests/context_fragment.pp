define tomcat::context_fragment(
  $host = 'localhost'
) {
  file{"/etc/tomcat5/conf/Catalina/$host":
    ensure => directory,
    require => Package['tomcat5'],
  }
  file{"/etc/tomcat5/conf/Catalina/$host/$name":
    ensure => directory,
    source => [
      "puppet://$server/modules/site-tomcat/context_fragments/$fqdn/$name",
      "puppet://$server/modules/site-tomcat/context_fragments/$name",
    ],
    require => File["/etc/tomcat5/conf/Catalina/$host"],
    notify => Service['tomcat5'],
    owner => root, group => 0, mode => 0644;
  }
}
