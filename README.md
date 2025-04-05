# `ansible-pull` demo

## Local Development

Setting up the local development environment to work with Ansible.

You'll need `virtualenv`:

```sh
sudo apt-get install python3-virtualenv -y
```

Start the environment:

```sh
python3 -m venv .venv
virtualenv .venv
source .venv/bin/activate
```

Install the dependencies:

```sh
python3 -m pip install --upgrade pip
python3 -m pip install -r requirements.txt
```

## Control Node

Depending on yor preference, two node provisioning options are available in this repository.

### VirtualBox

Prepare the directory with Vagrant:

```sh
mkdir -p vagrant-pull-node/ansible
cd vagrant-pull-node/ansible
vagrant init "ubuntu/jammy64"
```

Set additional parameters as in the [virtualbox/Vagrantfile](virtualbox/Vagrantfile). This will add the necessary packages.

Create and connect to the VM:

```sh
vagrant up
vagrant ssh
```

### Docker

For lightweight docker environment, set it up:

```sh
docker compose build
docker compose up -d
docker compose exec workstation /bin/bash
```

## `ansible-pull`

This section is executed from within the control node.

### Simple Pull Command

> [!TIP]
> A fork will be required to create tokens in the account

Connect to the GitHub account and generate a [new token](https://github.com/settings/personal-access-tokens). Prefer a fine-grained token, where only `read-only` permissions to the `Contents` to the repository is required.

> [!NOTE]
> Preferring the `https` URL option to use GitHub tokens

The next `ansible-pull` command was adapted from [this page](https://medium.com/planetarynetworks/ansible-pull-with-private-github-repository-d147fdf6f60b).

For development purposes, create a `/opt/ansible/pull.sh` script:

> [!TIP]
> Create link for `ln -s /opt/ansible/pull.sh /home/vagrant/pull.sh`

```sh
#!/bin/bash
token=1234
url="https://$token:x-oauth-basic@github.com/epomatti/ansible-pull-demo.git"
ansible-pull -U $url -d /opt/epomatti/ansible-pull-demo
```

Execute the Ansible pull script:

```sh
bash pull.sh
```

### Crontab

The [local.yml](local.yml) file will create a cron job to pull new configuration every minute. The package [flock](https://manpages.ubuntu.com/manpages/jammy/man1/flock.1.html) will be used to prevent cron job overlap.

Check the crontab logs:

```sh
sudo tail -f /var/log/syslog
```

The script output will be redirected to this file:

```sh
sudo tail -f /var/log/ansible-pull.log
```

To make ad-hoc adjustments to the local configuration:

```sh
sudo systemctl stop cron
```

## Reference Content

- [Using Ansible "Pull" Mode to Dynamically Automate Server/Workstation Builds](https://youtu.be/sn1HQq_GFNE)
- [Getting started with Ansible 01 - Introduction](https://youtu.be/3RiVKs8GHYQ?list=PLT98CRl2KxKEUHie1m24-wkyHpEsa4Y70)
- [Using Ansible to automate your Laptop and Desktop configs!](https://youtu.be/gIDywsGBqf4)
- [Encrypting Files with Ansible Vault](https://youtu.be/xeBnAbmt3Wk)
