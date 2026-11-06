#!/bin/bash
set -e

#get vault password
umask 077
echo "${INPUT_VAULT_PASSWORD}" > /tmp/vault_pw.txt
umask 022

#setup SSH
mkdir -p ~/.ssh
cd "${INPUT_ANSIBLE_DIR:-ansible}"

#install the collections pinned by the repo into ./collections, where its
#ansible.cfg (collections_path = collections) looks for them
if [ -f requirements.yml ]; then
  for attempt in 1 2 3; do
    ansible-galaxy collection install -r requirements.yml -p collections && break
    [ "$attempt" = 3 ] && exit 1
    echo "ansible-galaxy failed (attempt $attempt), retrying in 10s"; sleep 10
  done
fi

ansible-vault decrypt --vault-password-file /tmp/vault_pw.txt ${INPUT_ENCRYPTED_SSH_KEY:-id_rsa_deploy_encrypted} --output=~/.ssh/id_rsa
chmod 0600 ~/.ssh/id_rsa

#run playbook
set -x
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${INPUT_INVENTORY} -u ${INPUT_SSH_USER} --private-key ~/.ssh/id_rsa --extra-vars "${INPUT_EXTRA_VARS}" --vault-password-file /tmp/vault_pw.txt "${INPUT_PLAYBOOK}"
set +x
