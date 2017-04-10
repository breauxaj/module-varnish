node default {
  include ::varnish

  case $::operatingsystem {
    'Amazon': {
        Package { allow_virtual => false }
    }
    default: {}
  }

}