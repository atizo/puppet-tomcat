#
# Helper definition which helps allocate more/less resources to the 
# tomcat user, using PAM. See limits.conf(5) and pam_limits(8) for more details.
# 
# Parameters:
# 
#   name: the name of the limit to change (instance name).
#   value: the value to set for this limit.
#
# Example usage:
#
#   tomcat::ulimit{'nofile':
#     value => 16384,
#   }
#

define tomcat::ulimit($value) {
  augeas{"set_tomcat_${name}_ulimit":
    context => "/files/etc/security/limits.conf",
    changes => [
      "set domain[last()+1] tomcat",
      "set domain[.='tomcat']/type -",
      "set domain[.='tomcat']/item $name",
      "set domain[.='tomcat']/value $value",
    ],
    onlyif => "match domain[.='tomcat'][type='-'][item='$name'][value='$value'] size == 0",
  }
}
