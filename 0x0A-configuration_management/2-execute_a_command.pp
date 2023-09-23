# This Puppet manifest kills a process named "killmenow" using pkill

exec { 'killmenow':
  command     => 'pkill -f "killmenow"',
  provider    => 'shell',
  refreshonly => true,
  logoutput   => true,
}

