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

# Jenkins integration with Gmail

- install the Mailer Plugin if not already installed, go to Manage Jenkins -> Manage Plugins -> type mailer in search bar under available plugin, if not found then   check in installed plugins

- follow these steps to allow gmail to send emails
   
       1. sing-in to gmail account >> navigate to settings >> privacy and security settings

       2. setup two step verification settings (because without two step verification we cannot generate application specific password)

       3. after setting up two step verification setting in gmail account navigate back to security and privacy settings

       4. click on application specific password >> give the name of the application in the drop down as Jenkins (google by default does not have any specific  application password setting for Jenkins) >> this will generate password note down the password generated

- after installing the plugin go to Manage Jenkins -> configure System -> Email Notification , configure as shown in following screen

![emailintegration](screens/gmailintegration.png)


# Create jenkins job to run a shell scripit with parameters

- after login to jenkins go to , dashboard -> new item -> enter the job name -> freestyle project -> click OK to save
   
   ![login](screens/login.png)  ![newitem](screens/newitem.png)

- now you'll be redirected to the configure screen

   ![configurejob](screens/configurejob.png)

- execute bash scripts with parameters from jenkins
- create bash script in local machine
- copy the script to docker container , container_name:file location wher you want to copy, sample script.sh file is provided in the repository 

       docker cp script.sh jenkins:/tmp/script.sh

- add prameters as shown in the following screen, I selected the choice(list) parameter and string parameter

   ![addparam](screens/addparam.png) 

- choice(list) parameter

   ![choice](screens/choiceparameter.png) 

- string parameter, can set default value for this
   
   ![string](screens/stringparameter.png)

- add the shell script in the build step
  
   ![executeshell](screens/executeshell.png)

Note: if jenkins user doesn't have permissions to execute scripts then grant required permissions using chmod command

- Save the job and go back to the , dashboard -> your job -> click "Build with Parameters" , if you have no parameters setup this button will simply be "build Now"

- click on the job id -> console output , to view results
   
   ![consoleoutput](screens/consoleoutput.png)




    

    
