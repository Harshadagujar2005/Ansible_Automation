# DevOps Ansible Project: Nginx Company Website

Scenario: automated deployment of a company website on an Nginx web server.
Ansible handles the Deploy / Operate stage of the DevOps lifecycle.

## Description
Ansible automation for deploying a company website on an Nginx web server. The project has an inventory with hosts, groups and variables, and a reusable playbook that installs packages, renders a Jinja2 template, manages the Nginx service with a handler, and verifies the site. A second run shows no changes (idempotent).

## Demo video
Watch the demo: https://drive.google.com/file/d/1dv-LX6NuNDAZSmJwyhSeY_IUbbPImmDL/view?usp=sharing

The video first explains the key concepts (DevOps lifecycle, architecture, Ansible inventory and playbook), then shows a live demonstration of deploying the Nginx website with Ansible, including the second run that shows no changes. The link and a short description are also in `Demo_video_Link_Ansible.docx`.

## Files
- `inventory.ini`: hosts and groups (`webservers`, `production`) with group variables
- `ansible.cfg`: points Ansible at the inventory
- `site.yml`: the playbook (packages, template, service, handler, verification)
- `templates/index.html.j2`: Jinja2 template for the homepage
- `run.sh`: runs every step in order, for screenshots

## Prerequisites
- Windows with WSL2 + Ubuntu, systemd enabled (`/etc/wsl.conf` containing `[boot]` and `systemd=true`, then `wsl --shutdown`)
- Ansible: `sudo apt install -y ansible`
- Passwordless sudo for the lab user:
  `echo "<user> ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/<user>`

## Run
    cd ~/devops-ansible
    bash run.sh

or step by step:

    ansible all -m ping
    ansible-inventory --graph
    ansible-playbook site.yml --syntax-check
    ansible-playbook site.yml          # first run: changes
    ansible-playbook site.yml          # second run: changed=0 (idempotent)
    ansible-playbook site.yml --check  # dry run
    ansible webservers -m command -a "systemctl status nginx" -b

Then open http://localhost in a browser.
