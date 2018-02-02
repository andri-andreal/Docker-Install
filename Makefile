os ?= $(shell lsb_release -cs)	
install-docker:;: '$(os)'
	@apt-get update
	@apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
	@curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	@apt-key fingerprint 0EBFCD88
	@add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(os) stable"
	@apt-get update
	@apt-get install docker-ce -y
	@apt-cache madison docker-ce
	@docker run hello-world
	@echo "============Docker has been Installed==============="
	
port-portainer ?= 9000:9000
install-portainer:;: '$(port-portainer)'
	@docker volume create vol-portainer
	@docker run -d --name Portainer --restart=always -p $(port-portainer) -v /var/run/docker.sock:/var/run/docker.sock -v vol-portainer:/data portainer/portainer
	@echo "============Portainer has been Installed==============="