cd ./provision/
ansible-playbook -u vagrant -e "version=$version" playbook.yml