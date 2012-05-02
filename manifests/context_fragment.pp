define tomcat::context_fragment(
  $host = 'localhost'
) {
  file{"/etc/tomcat${lsbmajdistrelease}/conf/Catalina/$host":
    ensure => directory,
    require => Package['tomcat'],
  }
  file{"/etc/tomcat${lsbmajdistrelease}/conf/Catalina/$host/$name":
    ensure => directory,
    source => [
      "puppet://$server/modules/site-tomcat/context_fragments/$fqdn/$name",
      "puppet://$server/modules/site-tomcat/context_fragments/$name",
    ],
    require => File["/etc/tomcat${lsbmajdistrelease}/conf/Catalina/$host"],
    notify => Service['tomcat'],
    owner => root, group => 0, mode => 0644;
  }
}
