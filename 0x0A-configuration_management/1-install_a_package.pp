# This Puppet manifest installs Flask version 2.1.0 using pip3

package { 'flask':
  ensure   => '2.1.0',    # Specify the desired version of Flask
  provider => 'pip3',     # Use pip3 as the package provider
}

