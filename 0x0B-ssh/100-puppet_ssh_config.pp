# Include the stdlib module
include stdlib

# Configure SSH client to use the private key and disable password authentication
file_line { 'Turn off password authentication':
  path   => '/etc/ssh/ssh_config',
  line   => 'PasswordAuthentication no',
}

file_line { 'Declare identity file':
  path   => '/etc/ssh/ssh_config',
  line   => 'IdentityFile ~/.ssh/school',
}
