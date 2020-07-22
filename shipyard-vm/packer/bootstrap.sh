#!/bin/bash
set -e

NOMAD_VERSION=0.12.0
CONSUL_VERSION=1.8.0
VAULT_VERSION=1.5.0
TERRAFORM_VERSION=0.12.28

export DEBIAN_FRONTEND=noninteractive

echo "waiting 180 seconds for cloud-init to update /etc/apt/sources.list"
timeout 180 /bin/bash -c \
  'until stat /var/lib/cloud/instance/boot-finished 2>/dev/null; do echo waiting ...; sleep 1; done'

apt-get update && apt-get -y upgrade
apt-get install -y \
    git curl wget \
    gnupg-agent \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    sudo \
    jq \
    vim \
    nano \
    unzip

# Install Docker
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"

apt-get update && apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io

# Install Nomad
curl -fsSL -o /tmp/nomad.zip https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip
unzip -o -d /usr/local/bin/ /tmp/nomad.zip

# Install Consul
curl -fsSL -o /tmp/consul.zip https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip
unzip -o -d /usr/local/bin/ /tmp/consul.zip

# Install Terraform
curl -fsSL -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip -o -d /usr/local/bin/ /tmp/terraform.zip

# Install Vault
curl -fsSL -o /tmp/vault.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip
unzip -o -d /usr/local/bin/ /tmp/vault.zip

# Copy google startup scripts service
cp /tmp/resources/google-startup-scripts.service /etc/systemd/system/multi-user.target.wants/google-startup-scripts.service

# Install golang
add-apt-repository ppa:longsleep/golang-backports
apt update && apt install -y \
  golang-go

# Install shipyard
git clone https://github.com/shipyard-run/shipyard.git
pushd shipyard
make install_local
popd
mv $(which yard-dev) /usr/local/bin/shipyard

cat <<EOH > /usr/local/bin/kd
#!/bin/bash
docker rm -f $(docker ps -aq)
docker volume rm $(docker volume list -q)
docker network rm $(docker network ls -q)
EOH
chmod +x /usr/local/bin/kd