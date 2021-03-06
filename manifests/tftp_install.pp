#
define himlar_bootstrap::tftp_install (
  $ensure           = 'present',
  $domain           = 'localdomain',
  $certname         = "${name}.${domain}",
  $hostname         = "${name}.${domain}",
  $macaddress       = 'default',
  $kernel_opts      = "network net.ifnames=0",
  $dhcp_interface   = 'eth1',
  $dhcp_range_start = '10.0.0.10',
  $dhcp_range_end   = '10.0.0.10',
  $dhcp_gateway     = '10.0.0.1',
  $use_dhcp         = true
) {
  require himlar_bootstrap::tftp_setup

  $dhcp_interface_ip = inline_template("<%= scope.lookupvar('::ipaddress_${dhcp_interface}') %>")
  $ks_url = "http://${dhcp_interface_ip}:8000/${name}.cfg"

  if $macaddress == 'default' {
    file { "/var/lib/tftpboot/pxelinux.cfg/default":
      ensure  => $ensure,
      content => template("${module_name}/pxelinux.erb"),
    }
  } else {
    $pxelinux_i = regsubst($macaddress,':','-','G')
    $pxelinux_file = downcase($pxelinux_i)

    file { "/var/lib/tftpboot/pxelinux.cfg/01-${pxelinux_file}":
      ensure  => $ensure,
      content => template("${module_name}/pxelinux.erb"),
    }
  }

  file { "/var/www/html/${name}.cfg":
    ensure  => $ensure,
    content => template("${module_name}/kickstart.erb"),
  }

  file { "/usr/local/sbin/bootstrap-${name}.sh":
    ensure  => $ensure,
    content => template("${module_name}/bootstrap-tftp.sh.erb"),
    mode    => '0755',
  }

}
