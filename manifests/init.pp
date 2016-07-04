#
class himlar_bootstrap(
  $mirror     = $::himlar_bootstrap::params::mirror,
  $timezone   = $::himlar_bootstrap::params::timezone,
  $keyboard   = $::himlar_bootstrap::params::keyboard,
  $rootpw     = $::himlar_bootstrap::params::rootpw,
  $nameserver = $::himlar_bootstrap::params::nameserver,
  $puppetrepo = $::himlar_bootstrap::params::puppetrepo
) inherits himlar_bootstrap::params {

  File {
    owner => 'root',
    group => 'root',
    mode => '0644',
  }

  file { ['/var/www', '/var/www/html']:
    ensure => directory,
  }

}
