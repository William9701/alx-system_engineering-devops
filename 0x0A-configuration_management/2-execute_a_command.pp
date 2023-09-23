# This Puppet manifest kills a process named "killmenow" using pkill

exec { 'killmenow_process':
  command     => 'pkill -f "killmenow"',
  provider    => 'shell',
  refreshonly => true,
  logoutput   => true,
}

