#
define himlar_bootstrap::virt_install(
  $ensure             = 'present',
  $domain             = 'localdomain',
  $certname           = "${name}.${domain}",
  $hostname           = "${name}.${domain}",
  $ks_url             = "http://${::ipaddress}:8000/${name}.cfg",
  $libvirt_pool       = 'default',
  $libvirt_network    = 'default',
  $install_ip         = undef,
  $install_netmask    = undef,
  $install_gateway    = undef,
  $vm_vcpus           = 2,
  $vm_memory          = 4096,
  $vm_console         = 'ttyS0,115200'
) {
  require himlar_bootstrap::virt_install_setup

  file { "/var/www/html/${name}.cfg":
    ensure  => $ensure,
    content => template("${module_name}/kickstart.erb"),
  }

  file { "/usr/local/sbin/bootstrap-${name}.sh":
    ensure  => $ensure,
    content => template("${module_name}/bootstrap-virt.sh.erb"),
    mode    => '0755',
  }

}
