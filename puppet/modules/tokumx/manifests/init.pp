class tokumx{
  class{"tokumx::params": }
    -> class{"tokumx::users":}
    -> class{"tokumx::download":}
    -> class{"tokumx::packages":}
    -> class{"tokumx::configs":}
    -> class{"tokumx::initialize":}
    -> class{"tokumx::service":}
}

class tokumx::users{
  user { 'mongodb':
    ensure => 'present',
    uid    => $tokumx::params::user_id,
  }
  -> group { "mongnodb":
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
}

class tokumx::packages{
  package{$tokumx::params::packagenames: ensure => installed}
}

class tokumx::configs{
  # file{"/etc/init.d/mysql":
  #   content => template("tokumx/mysql.server.erb"),
  #   mode    => 0755,
  # }

  file{"/data":
    ensure => directory
  }
  # -> file{"/etc/mysql/my.cnf":
  #   content => template("tokumx/my.cnf.erb"),
  # }
  -> file{$tokumx::params::data_dir:
    ensure => directory,
    owner => 'mongodb', group => 'mongodb'
  }
}

class tokumx::initialize{
  # $check_file = "$tokumx::params::base_dir/.installed"
  # exec{"init mysql":
  #   command => "echo 1 && cd $tokumx::params::base_dir && ./scripts/mysql_install_db --user=mysql && touch $check_file",
  #   unless  => "test -e $check_file"
  # }
}

class tokumx::service{
  # service{"mysql":
  #   ensure    => running,
  #   subscribe => Class["tokudb::configs"]
  # }
}