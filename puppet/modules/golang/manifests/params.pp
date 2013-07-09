class golang::params{
  # file = "https://go.googlecode.com/files/go1.1.1.linux-amd64.tar.gz"
  $fullpath      = "go1.1.1.linux-amd64"
  $download_file = "$fullpath.tar.gz"
  $download_url  = "https://go.googlecode.com/files/$download_file"
  $base_dir      = '/usr/local/go'
}