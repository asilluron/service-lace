# ServiceLace

![Image of a colorful lace](http://i.imgur.com/AS7ggCi.png?raw=true )

Load balancing setup on Alpine with s6, consul and more. Many thanks to smebberson/alpine-nginx for the base setup of alpine+nginx.

Currently the very first version only supports load balancing between multiple nodes of a service named "web". This is a temporary config freeze. 

In order to setup a custom template, you can edit `etc/consul-template/nginx.conf`

## Setup
Setup registrator and consul.

```
docker run -d --name consul --publish 8300:8300 --publish 8600:53/udp --publish 8500:8500 --publish 8400:8400  gliderlabs/consul-server:0.6 -bootstrap -advertise 127.0.0.1 -client 0.0.0.0
```

```
docker run -d --name registrator --link consul --volume /var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator:latest -internal consul://consul:8500

```

Finally kick off the load balancer.
```
docker run -d --name load-balancer --publish 80:80 --publish 443:443 --link consul --link registrator load-balancer
```

## Development

```
docker build -t nginx-consul .
```

