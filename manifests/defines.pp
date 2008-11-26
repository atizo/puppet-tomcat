# manifests/defines.pp

define tomcat::vhost(
    $domain,
    $domainaliases = ''
){
    $webappname = $name
    concatenated_file_part{"tomcat_vhost_${name}":
        dir => '/var/lib/puppet/modules/tomcat/vhosts',
        content => template('tomcat/vhosts/vhost.erb'),
        owner => root, group => 0, mode => 0600;
    }
}
