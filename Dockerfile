FROM smebberson/alpine-base:3.0.0
MAINTAINER Andrew Silluron <asilluron@users.noreply.github.com>

# Install nginx
RUN echo "http://dl-4.alpinelinux.org/alpine/v3.3/main" >> /etc/apk/repositories && \
    apk add --update nginx=1.8.1-r1 && \
    rm -rf /var/cache/apk/* && \
    chown -R nginx:www-data /var/lib/nginx

RUN apk add --update curl

RUN curl -L -o consul-template.zip https://releases.hashicorp.com/consul-template/0.15.0/consul-template_0.15.0_linux_amd64.zip
RUN unzip consul-template.zip -d /usr/local/bin
RUN rm consul-template.zip

# Add the files
ADD root /

# Expose the ports for nginx
EXPOSE 80 443
