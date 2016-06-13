# Class: varnish
#
# This class installs Varnish 4
#
# Parameters:
#
#  ensure: (default latest)
#    Determine which version to install
#
# Actions:
#   - Install Varnish 4
#
# Sample Usage:
#
#  For a standard installation, use:
#
#    class { 'varnish': }
#
class varnish (
  $ensure = $::varnish::params::varnish_package_ensure
) inherits ::varnish::params {
  case $::operatingsystem {
    'Amazon', 'CentOS', 'OracleLinux', 'RedHat': {
      package { $::varnish::params::varnish_package:
        ensure  => $ensure,
        require => [
          Yumrepo['varnish'],
          User['varnish'],
          Group['varnish']
        ]
      }

      service { $::varnish::params::varnish_service:
        ensure  => running,
        enable  => true,
        require => Package[$::varnish::params::varnish_package]
      }
    }
    'Debian': {
      case $::operatingsystemmajrelease {
        '8': {
          package { $::varnish::params::varnish_package:
            ensure  => $ensure,
            require => [
              User['varnish'],
              Group['varnish']
            ]
          }
          
          service { $::varnish::params::varnish_service:
            ensure  => running,
            enable  => true,
            require => Package[$::varnish::params::varnish_package]
          }
        }
        default: {
          fail("The ${module_name} module is not supported on an ${::operatingsystem} ${::operatingsystemmajrelease} distribution.")
        }
      } 
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
