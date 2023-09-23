# This is a simple Puppet manifest to create a file

file { '/tmp/school':
  ensure  => present,          # Ensure the file exists
  content => 'I love Puppet',
  mode    => '0744',          # Set file permissions (e.g., read and write for owner, read for group and others)
  owner   => 'www-data', # Set the owner of the file
  group   => 'www-data',    # Set the group of the file
}

