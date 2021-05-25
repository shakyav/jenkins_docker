# jenkins_docker

# Install docker on fedora

      sudo dnf -y install dnf-plugins-core

- add repo

      sudo dnf config-manager \
        --add-repo \
        https://download.docker.com/linux/fedora/docker-ce.repo
        
- install docker 
       
       sudo dnf install docker-ce docker-ce-cli containerd.io

- start docker service

       sudo systemctl start docker

- verify installation
       
       docker run hello-world

- run following command if getting permission denied for "docker run hello-world"

       sudo chmod 666 /var/run/docker.sock

# Install docker-compose

- refer this doc https://docs.docker.com/compose/install/

# create docker container with jenkins image 
- create a directory jenkins-data where we will store all the jenkins related files
       
       mkdir jenkins-data

- create docker-comapose.yml file to build up  jenkins container

       #docker compose file to spin a jenkins container only

       version: '3'
       services:
         jenkins:
            container_name: jenkins
            image: jenkins-ansible
            build:
            context: jenkins-ansible
            ports:
            - "8080:8080"
            volumes:
            - $PWD/jenkins_home:/var/jenkins_home
            networks:
            - net
       networks:
         net: 

- execute "docker-compose build" to build the container and "docker-compose up -d" to start the container
- verify docker containers running, "docker ps" command lists all the docker containers running

- login to the container shell , "docker exec -it jenkins bash" command will ley you acces the shell inside the container, type "exit" to come out

- access jenkins UI at http://localhost:8080 , setup the jenkins admin as prompted by the jenkins UI
- install suggested plugins

# create jenkins job to run a shell scripit with parameters

    

    
