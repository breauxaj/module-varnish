# Class: varnish
#
# This class installs Varnish
#
# Parameters:
#
#  ensure: (default latest)
#    Determine which version to install
#
# Actions:
#   - Install Varnish
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
  case $::osfamily {
    'RedHat', 'Debian': {
      package { $::varnish::params::varnish_package:
        ensure  => $ensure,
      }

      service { $::varnish::params::varnish_service:
        ensure  => running,
        enable  => true,
        require => Package[$::varnish::params::varnish_package]
      }

      service { $::varnish::params::varnishlog_service:
        ensure    => running,
        enable    => true,
        require   => Package[$::varnish::params::varnish_package],
        subscribe => Service[$::varnish::params::varnish_service]
      }

      service { $::varnish::params::varnishncsa_service:
        ensure    => running,
        enable    => true,
        require   => Package[$::varnish::params::varnish_package],
        subscribe => Service[$::varnish::params::varnish_service]
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
