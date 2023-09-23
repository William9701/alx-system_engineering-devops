# This Puppet manifest kills a process named "killmenow" using pkill

exec { 'killmenow_process':
  command     => 'pkill -f killmenow',  # Use pkill to kill the process named "killmenow"
  refreshonly => true,                  # Execute only when notified (avoid redundant executions)
  logoutput   => true,                  # Log the command output
}

