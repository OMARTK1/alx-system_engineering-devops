# Define class for custom HTTP header configuration
class custom_http_response_header {
    package { 'nginx':
        ensure => installed,
    }

    file { '/etc/nginx/sites-available/default':
        ensure  => file,
        content => "server {
                        listen 80 default_server;
                        listen [::]:80 default_server;
                        root /var/www/html;
                        index index.html index.htm index.nginx-debian.html;
                        server_name _;
                        add_header X-Served-By $hostname;
                        location / {
                                try_files $uri $uri/ =404;
                        }
                }",
        notify  => Service['nginx'],
    }

    service { 'nginx':
        ensure => running,
        enable => true,
    }
}

# Apply class
include custom_http_response_header

