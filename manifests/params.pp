# Class: varnish::params
#
# This class sets parameters used in this module
#
# Actions:
#   - Defines numerous parameters used by other classes
#
class varnish::params {
  $varnish_package_ensure = 'latest'

  case $::osfamily {
    'Debian', 'RedHat': {
      case $::operatingsystem {
        default: {
          case $::operatingsystemmajrelease {
            default: {
              $varnish_package     = 'varnish'
              $varnish_service     = 'varnish'
              $varnishlog_service  = 'varnishlog'
              $varnishncsa_service = 'varnishncsa'
            }
          }
        }
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

}
