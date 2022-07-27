# About
_What is it?_

Experiments with Rails and nginx.

_Does the project name mean anything?_

No. It comes from `xkcd-pass -n 2`.
See [xkcd-pass](https://github.com/redacted/XKCD-password-generator).

# Prerequisites

- Docker
- GNU Make

# Running
1. Build docker image:
```
make build-docker
```
2. Run docker container:
```
make run
```

3. Copy work files:
```
build/copy-to-docker
```

# Resources
## Rails
- [Ruby on Rails Guides](https://guides.rubyonrails.org/index.html)
- [2.2 CRUD, Verbs, and Actions](https://guides.rubyonrails.org/routing.html#crud-verbs-and-actions)
- [How To Install Ruby on Rails with rbenv on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-20-04)
- [Beginner’s Guide to Building a Rails API](https://medium.com/swlh/beginners-guide-to-building-a-rails-api-7b22aa7ec2fb)

## Puma
- [Puma: A Ruby Web Server Built For Parallelism](https://github.com/puma/puma)
- [Puma: Nginx configuration example file](https://github.com/puma/puma/blob/master/docs/nginx.md)

## S6
- [An overview of s6](https://www.skarnet.org/software/s6/overview.html)
- [s6 overlay](https://github.com/just-containers/s6-overlay)

## HTTP
- [Wikipedia: Chunked Transfer Endcoding](https://en.wikipedia.org/wiki/Chunked_transfer_encoding).
- [RFC 2616: Hypertext Transfer Protocol -- HTTP/1.1](https://www.rfc-editor.org/rfc/rfc2616)
- [RFC 1945: Hypertext Transfer Protocol -- HTTP/1.0](https://www.rfc-editor.org/rfc/rfc1945)

## Nginx
- [nginx documentation](https://nginx.org/en/docs/)

