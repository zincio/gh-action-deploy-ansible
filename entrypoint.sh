#!/bin/bash
set -e

#get vault password
echo "${INPUT_VAULT_PASSWORD}" > /tmp/vault_pw.txt

#setup SSH
mkdir ~/.ssh
cd "${INPUT_ANSIBLE_DIR:-ansible}"
ansible-vault decrypt --vault-password-file /tmp/vault_pw.txt ${INPUT_ENCRYPTED_SSH_KEY:-id_rsa_deploy_encrypted} --output=~/.ssh/id_rsa
chmod 0600 ~/.ssh/id_rsa

#run playbook
set -x
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${INPUT_INVENTORY} -u ${INPUT_SSH_USER} --private-key ~/.ssh/id_rsa --extra-vars "${INPUT_EXTRA_VARS}" --vault-password-file /tmp/vault_pw.txt "${INPUT_PLAYBOOK}"
set +x
