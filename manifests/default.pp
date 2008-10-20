# manifests/default.pp

class tomcat::default {
    include tomcat
    include tomcat::webapps
    include tomcat::clean
    include java::ensure
}
