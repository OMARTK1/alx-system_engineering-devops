# A puppet code to fix Apache 500 Internal Server Error by correcting file extension.

exec { 'Fix WordPress site':
  command  => 'sed -i "s/.phpp/.php/" /var/www/html/wp-settings.php',
  path     => ['/bin', '/usr/bin'],
  provider => shell,
}
