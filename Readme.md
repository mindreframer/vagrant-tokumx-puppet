# TokuMX v. 1.0 is Open Source and available for download

    http://www.tokutek.com/2013/06/announcing-tokumx-v1-0-tokumongo-you-can-have-it-all-2/



# Requirements:

      - Vagrant (http://www.vagrantup.com/)

### Usage:

    $ git clone git://github.com/mindreframer/vagrant-tokumx-puppet.git
    $ cd vagrant-tokumx-puppet

    # start vagrant
    $ vagrant up

    # ssh into your VM
    $ vagrant ssh

### On fresh Ubuntu 12.04:

    $ apt-get install puppet
    $ cd /tmp
    $ git clone git://github.com/mindreframer/vagrant-tokumx-puppet.git
    $ puppet apply -vv  --modulepath=/tmp/vagrant-tokumx-puppet/puppet/modules/ /tmp/vagrant-tokumx-puppet/puppet/manifests/base.pp


See a screencast here:

  [Playing with TokuMX](http://mindreframer.github.io/posts/2013/07-08-play-with-tokumx-now.html)



#### runpuppet (run  puppet), run under `vagrant`-user:
    $ runpuppet


#### download TokuMX (you'll need to register)

    http://www.tokutek.com/products/downloads/tokumx-ce-downloads/

  The Puppet module  works with `tokumx-1.0.2-linux-x86_64`.
