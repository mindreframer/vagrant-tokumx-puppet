class tokumx{
  class{"tokumx::params": }
    -> class{"tokumx::users":}
    -> class{"tokumx::download":}
    -> class{"tokumx::packages":}
    -> class{"tokumx::configs":}
    -> class{"tokumx::service":}
}

class tokumx::users{
  user { 'mongodb':
    ensure => 'present',
    uid    => $tokumx::params::user_id,
  }
  -> group { "mongodb":
    ensure  => "present",
    gid     => $tokumx::params::user_id,
  }
}

class tokumx::download{
  $filepath = $tokumx::params::download_file
  $fullpath = $tokumx::params::fullpath

  exec{"mkdir -p /vagrant/binaries":
    unless => "test -e /vagrant/binaries"
  }
  -> exec{"download tokumx":
    command => "curl $tokumx::params::download_url > /vagrant/binaries/$filepath",
    unless  =>  "test -e /vagrant/binaries/$filepath"
  }
  -> exec{"decompress tokumx":
    command => "tar xvfz /vagrant/binaries/$filepath",
    cwd     => "/usr/local",
    unless  => "test -e $tokumx::params::base_dir"
  }
  -> file{$tokumx::params::base_dir:
    ensure  => link,
    target  => "/usr/local/$fullpath",
    owner   => 'mongodb', group   => 'mongodb'
  }
  -> exec{"adjust filerights tokumxlink":
    command => "chown -R mongodb:mongodb $tokumx::params::base_dir",
    unless  => "stat $tokumx::params::base_dir|grep Access|grep mongodb"
  }
  -> exec{"adjust filerights tokumx":
    command => "chown -R mongodb:mongodb /usr/local/$fullpath",
    unless  => "stat /usr/local/$fullpath|grep Access|grep mongodb"
  }

  -> exec{"binary:symlinks":
    # list | split | use 'file' as variable and create symlinks
    command => "ls  /usr/local/tokumx/bin |xargs -0 |xargs -I file ln -s /usr/local/tokumx/bin/file /usr/local/bin/file",
    # unless symlink exists and points to right target
    unless => "test -e /usr/local/bin/mongo && readlink /usr/local/bin/mongo|grep /usr/local/tokumx/bin/mongo"
  }
}

class tokumx::packages{
  package{$tokumx::params::packagenames: ensure => installed}
}

class tokumx::configs{
  file{"/etc/init/mongodb.conf":
    content => template("tokumx/upstart.conf.erb"),
    mode    => 0755,
  }

  file{"/etc/mongodb.conf":
    content => template("tokumx/mongodb.conf.erb"),
    mode    => 0644,
  }

  file{["/var/log/mongodb/", $tokumx::params::data_dir]:
    ensure => directory,
    owner => 'mongodb', group => 'mongodb'
  }
}

class tokumx::service{
  service{"mongodb":
    provider  => upstart,
    ensure    => running,
    subscribe => Class["tokumx::configs"]
  }
}