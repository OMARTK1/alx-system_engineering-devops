# Puppet manifest to install Flask version 2.1.0

# Ensure the package is installed
package { 'flask':
  ensure => '2.1.0',
  provider => 'pip3',
}
