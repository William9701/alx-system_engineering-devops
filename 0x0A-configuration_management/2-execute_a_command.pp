# This Puppet manifest kills a process named "killmenow" using pkill

exec { 'killmenow':
  command     => 'pkill -f killmenow',
  path        => ['/usr/bin', '/usr/sbin'],
  refreshonly => true,
}

