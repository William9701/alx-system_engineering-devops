# Puppet Manifest to Configure SSH Client

# Define a 'file' resource to manage the SSH client configuration file '/etc/ssh/ssh_config'.
# This file will ensure correct ownership, permissions, and content.

file { '/etc/ssh/ssh_config':
  ensure  => file,        # Ensure the file exists
  owner   => 'root',      # Set the owner to 'root'
  group   => 'root',      # Set the group to 'root'
  mode    => '0644',      # Set permissions to '0644' (readable by owner and group)
  content => "# SSH client configuration\nHost *\n  IdentityFile ~/.ssh/school\n  PasswordAuthentication no\n",
  # The content of the file is the SSH client configuration specifying the private key '~/.ssh/school' and disabling password authentication.
}

