class freeswitch() {
}
define freeswitch::install() {
  include apt

  apt::key { 'freeswitch':
    key        => '25E010CF',
    key_source => 'http://files.freeswitch.org/repo/deb/debian/freeswitch_archive_g0.pub',
  }

  apt::source { 'freeswitch':
    location => "http://files.freeswitch.org/repo/deb/debian/",
    # location => "http://192.168.1.108/",
    release => "wheezy",
    repos => "main",
    include_src => false
  }

  [ "freeswitch-meta-vanilla", "freeswitch-mod-rayo" ].each |$p| {
    package { $p:
      ensure => latest,
      require => [Apt::Source['freeswitch']]
    }
  }

  file { "/etc/freeswitch":
    ensure => "directory",
    recurse => true,
    source => "/usr/share/freeswitch/conf/vanilla",
    require => Package['freeswitch-meta-vanilla']
  }

}

define freeswitch::setup(
  $freeswitch_conf_path = "/etc/freeswitch"
) {

  file {'/etc/default/freeswitch':
    path => "/etc/default/freeswitch",
    content => template("freeswitch/default")
  }

  file {'fs/vars.xml':
    path => "${freeswitch_conf_path}/vars.xml",
    content => template("freeswitch/vars.xml.erb")
  }

  # Autoload configs
  file {'fs/autoload_configs/acl.conf.xml':
    path => "${freeswitch_conf_path}/autoload_configs/acl.conf.xml",
    content => template("freeswitch/autoload_configs/acl.conf.xml.erb")
  }

  file {'fs/autoload_configs/conference.conf.xml':
    path => "${freeswitch_conf_path}/autoload_configs/conference.conf.xml",
    content => template("freeswitch/autoload_configs/conference.conf.xml")
  }

  file {'fs/autoload_configs/http_cache.conf.xml':
    path => "${freeswitch_conf_path}/autoload_configs/http_cache.conf.xml",
    content => template("freeswitch/autoload_configs/http_cache.conf.xml.erb")
  }

  file {'fs/autoload_configs/modules.conf.xml':
    path => "${freeswitch_conf_path}/autoload_configs/modules.conf.xml",
    content => template("freeswitch/autoload_configs/modules.conf.xml")
  }

  file {'/fs/autoload_configs/rayo.conf.xml':
    path => "${freeswitch_conf_path}/autoload_configs/rayo.conf.xml",
    content => template("freeswitch/autoload_configs/rayo.conf.xml.erb")
  }

  file {'/fs/autoload_configs/ssml.conf.xml':
    path => "${freeswitch_conf_path}/autoload_configs/ssml.conf.xml",
    content => template("freeswitch/autoload_configs/ssml.conf.xml")
  }

  file {'fs/autoload_configs/switch.conf.xml':
    path => "${freeswitch_conf_path}/autoload_configs/switch.conf.xml",
    content => template("freeswitch/autoload_configs/switch.conf.xml")
  }

  # Dialplan
  file {'fs/dialplan/demo':
    path => "${freeswitch_conf_path}/dialplan/demo",
    ensure => 'directory',
    owner => 'freeswitch',
    group => 'staff',
    mode => "0770",
    recurse => true
  }
  file {'fs/dialplan/demo.xml':
    path => "${freeswitch_conf_path}/dialplan/demo.xml",
    content => template("freeswitch/dialplan/demo.xml")
  }

  file {'fs/dialplan/demo/00_demo.xml':
    path => "${freeswitch_conf_path}/dialplan/demo/00_demo.xml",
    content => template("freeswitch/dialplan/demo/00_demo.xml")
  }

  # Directory
  file {'fs/directory/default/testing.xml':
    path => "${freeswitch_conf_path}/directory/default/testing.xml",
    content => template("freeswitch/directory/default/testing.xml.erb")
  }

  # SIP Profiles
  file {'fs/sip_profiles/internal.xml':
    path => "${freeswitch_conf_path}/sip_profiles/internal.xml",
    content => template("freeswitch/sip_profiles/internal.xml")
  }

  file {'cacert.pem':
    path => "${freeswitch_conf_path}/cacert.pem",
    content => template("freeswitch/cacert.pem")
  }

  file {'/var/lib/freeswitch/storage':
    ensure => 'directory',
    owner => 'freeswitch',
    group => 'staff',
    mode => "0770",
    recurse => true,
  }

  file {'/var/lib/freeswitch/storage/http_cache':
    ensure => 'directory',
    owner => 'freeswitch',
    group => 'staff',
    mode => "0771"
  }

  file {'/var/punchblock':
    ensure => 'directory',
    owner => 'freeswitch',
    group => 'staff',
    mode => "0770",
    recurse => true,
  }

  file {'/var/punchblock/record':
    ensure => 'directory',
    owner => 'freeswitch',
    group => 'staff',
    mode => "0770",
    recurse => true,
  }

  file {'demo-audio':
    path => "/var/lib/freeswitch/storage/1up.wav",
    content => template("freeswitch/storage/1up.wav"),
    owner => 'freeswitch',
    group => 'staff',
    mode => "0664",
  }

  file {'demo-audio-2':
    path => "/var/lib/freeswitch/storage/demo.wav",
    content => template("freeswitch/storage/demo.wav"),
    owner => 'freeswitch',
    group => 'staff',
    mode => "0664",
  }
}
