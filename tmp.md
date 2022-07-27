# Testing
## Curl app

In host:
```
curl -v http://localhost:9990/posts
curl -v -X POST http://localhost:9990/posts
```

# Nginx config
## API Server
```
upstream app {
    # Path to Puma SOCK file, as defined previously
    server unix:/home/root/growing-relic/shared/sockets/puma.sock fail_timeout=0;
}

server {
    listen 9980;
    server_name localhost;

    root /srv/api.growing-relic.arpa.net/public;

    try_files $uri/index.html $uri @app;

    location @app {
        proxy_pass http://app;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_redirect off;
    }

    error_page 500 502 503 504 /500.html;
    client_max_body_size 4G;
    keepalive_timeout 10;
}
```

## Frontend Server

```
server {
    server_name fe.growing-relic.home.arpa;

    listen 9990;

    root /srv/fe.growing-relic.arpa.net/public;

    location /td_users {
        proxy_pass http://api.growing-relic.arpa.net:9980;
   }
}
```


# Ports

- API: ports 9980-9989
- Frontend: ports 9990-9999
- Puma: Unix socket
