#!/bin/bash
# Runs every step in order (useful for screenshots).
# Needs passwordless sudo for the current user (see README).
set -e

SRC="$(cd "$(dirname "$0")" && pwd)"
DEST="$HOME/devops-ansible"

if ! command -v ansible >/dev/null 2>&1; then
  echo ">>> Installing Ansible..."
  sudo apt update
  sudo apt install -y ansible
fi

if [ "$SRC" != "$DEST" ]; then
  mkdir -p "$DEST"
  cp -r "$SRC"/. "$DEST"/
fi
cd "$DEST"

echo; echo ">>> ansible --version";              ansible --version
echo; echo ">>> ansible all -m ping";            ansible all -m ping
echo; echo ">>> ansible-inventory --graph";      ansible-inventory --graph
echo; echo ">>> Syntax check";                   ansible-playbook site.yml --syntax-check
echo; echo ">>> First run (makes changes)";      ansible-playbook site.yml
echo; echo ">>> Second run (expect changed=0)";  ansible-playbook site.yml
echo; echo ">>> Dry run (--check)";              ansible-playbook site.yml --check
echo; echo ">>> Nginx status";                   ansible webservers -m command -a "systemctl status nginx" -b

echo; echo "Done. Open http://localhost in your Windows browser."
