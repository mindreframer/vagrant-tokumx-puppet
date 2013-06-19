class tokudb::params{
  $fullpath      = "tokumx-1.0.0-linux-x86_64"
  $download_file = "$fullpath.tgz"
  $packagenames  = [] #["libaio1", "mysql-client-core-5.5"] # ubuntu 12.04
  # a tmp location
  $download_url  = "http://master.dl.sourceforge.net/project/tokumxdownload/#{download_file}"
  # also group_id, for consistency
  $user_id       = 927
  $base_dir      = '/usr/local/mysql'
  $data_dir      = '/var/lib/mysql'
}