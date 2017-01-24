FROM nginx

#Install Curl
RUN apt-get update -qq && apt-get -y install curl wget unzip

#Consul options
ENV CONSUL_TEMPLATE_VERSION=0.16.0

# Consul-template install
RUN mkdir -p /tmp/consul-template && \
  cd /tmp/consul-template && \
  wget https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
  unzip consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
  cp consul-template /usr/local/bin && \
  rm -rf /tmp/consul-template

#Setup Consul Template Files
RUN mkdir /etc/consul-templates
ENV CT_FILE /etc/consul-templates/app-template.conf

#Setup Nginx File
ENV NX_FILE /etc/nginx/conf.d/app.conf

#Default Variables
ENV CONSUL consul:8500
ENV SERVICE consul-8500

COPY startup /usr/local/bin/startup
RUN chmod +x /usr/local/bin/startup

EXPOSE 443
EXPOSE 80
CMD ["/usr/local/bin/startup"]
