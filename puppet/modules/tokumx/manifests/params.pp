class tokumx::params{
  $fullpath      = "tokumx-1.0.1-linux-x86_64"
  $download_file = "$fullpath.tgz"
  $packagenames  = [] #["libaio1", "mysql-client-core-5.5"] # ubuntu 12.04
  # a tmp location
  $download_url  = "http://master.dl.sourceforge.net/project/tokumxdownload/#{download_file}"
  # also group_id, for consistency
  $user_id       = 928
  $base_dir      = '/usr/local/tokumx'
  $data_dir      = '/data/db'
}