## Preparing Jenkins Server Via Ansible on Centos7:


### To install jenkins on the server: 
```bash
$ ansible-playbook jenkins_server_preparation.yml --tags=jenkins 

```

#### To install docker on the server:
```bash
$ ansible-playbook jenkins_server_preparation.yml --tags=docker
```

### To install docker-compose on the server:
```bash
$ ansible-playbook jenkins_server_preparation.yml --tags=docker-compose
```


