[kafka]
%{ for node in kafka_nodes ~}
${node.name} ansible_host=${node.ip}
%{ endfor ~}

[database]
${db_node.name} ansible_host=${db_node.ip}

[web]
${web_node.name} ansible_host=${web_node.ip}

[servers:children]
kafka
database
web

[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/id_rsa
ansible_python_interpreter=/usr/bin/python3 