# http://master.dl.sourceforge.net/project/tokumxdownload/tokumx-1.0.0-linux-x86_64.tgz
# remove osx files
find binaries|grep .DS |xargs rm
# upload binaries folder
rsync -rv binaries/ -e ssh mindreframer@frs.sourceforge.net:/home/frs/project/tokumxdownload/