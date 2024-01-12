#
class himlar_bootstrap::params {
  $mirror     = 'https://download.iaas.uio.no/nrec/prod/el8/almalinux-base'
  $timezone   = 'Europe/Oslo'
  $keyboard   = 'no'
  $rootpw     = '$1$de0ytuAp$9wuB2AJxYQrEM9Hxa4Ihp/'
  $nameserver = '8.8.8.8'
  $puppetrepo = 'https://github.com/norcams/himlar'
  $yumrepo    = 'https://download.iaas.uio.no/nrec/prod/el8'
}
