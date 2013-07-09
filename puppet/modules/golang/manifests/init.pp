class golang{
  class{"golang::params":}
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

class golang::environment{
  # /etc/bash.bashrc
  exec{"golang:binpath":
    command => "echo 'export PATH=\$PATH:/usr/local/go/bin' >> /etc/bash.bashrc",
    unless  => "cat /etc/bash.bashrc|grep 'local/go/bin'"
  }
}