# manifests/defines.pp

define tomcat::vhost(
    $domain,
    $domainaliases = ''
){
    $webappname = $name
    concatenated_file_part{"tomcat_vhost_${name}":
        dir => "${TOMCAT_VHOSTSDIR}",
        content => template('tomcat/vhosts/vhost.erb'),
        owner => root, group => 0, mode => 0600;
    }
}
