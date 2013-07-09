class golang{
  class{"golang::params":}
  -> class{"golang::packages":}
  -> class{"golang::download":}
  -> class{"golang::environment":}
}

class golang::download{
  exec{"download tar for golang":
    command => "curl $golang::params::download_url > /var/tmp/$golang::params::download_file",
    unless  =>  "test -e /var/tmp/$golang::params::download_file"
  }
  -> exec{"decompress golang":
    command => "tar xvfz /var/tmp/$golang::params::download_file",
    cwd     => "/usr/local",
    unless  => "test -e $golang::params::base_dir"
  }
}

class golang::packages{
  package{$golang::params::packagenames: ensure => installed}
}

## /etc/bash.bashrc
class golang::environment{
  exec{"golang:binpath":
    command => "echo 'export PATH=\$PATH:/usr/local/go/bin' >> /etc/bash.bashrc",
    unless  => "cat /etc/bash.bashrc|grep 'local/go/bin'"
  }

  -> exec{"golang:gopath":
    command => "echo 'export GOPATH=/usr/local/gopath' >> /etc/bash.bashrc",
    unless  => "cat /etc/bash.bashrc|grep 'usr/local/gopath'"
  }
  -> file{"/usr/local/gopath":
    ensure => directory,
    owner => root, group => admin,
    mode  => 775,
  }
}