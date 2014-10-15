import 'freeswitch.pp'

node /fs/ {
  freeswitch::install { 'freeswitch': }
  freeswitch::setup { 'freeswitch':
    freeswitch_conf_path => "/etc/freeswitch",
    require => Freeswitch::Install['freeswitch']
  }

  service { "freeswitch":
    ensure => "running",
    require => [ Freeswitch::Setup['freeswitch'] ]
  }

  package { "curl":
    ensure => installed
  }
  
  user {'vagrant':
    groups => ['staff']
  }

  host { 'adhearsion-demo':
    name => 'adhearsion-demo',
    ip => $ipaddress_eth1,
    ensure => present
  }
}

