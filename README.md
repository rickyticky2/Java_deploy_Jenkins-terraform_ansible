# Java_deploy_Jenkins-terraform_ansible

When you run the pipeline from jenkinsfile, 2 servers will be created in AWS (t2-micro), with OS - Ubuntu 20.04 using Terraform. (file - aws.tf)
Jenkins will launch the Ansible playbook (awsplay.yml)
On one server, a JAVA application (Maven) will be built and packaged into a Docker container.
On the second server, the container with the application is launched. (Tomcat)


You will need:
- install Jenkins and run the following commands to set up the user. (can replace root with ubuntu or jenkins):
     sudo visudo
     ## Add to the file:
     jenkins ALL = (ALL) NOPASSWD: ALL
    
     service jenkins restart
     sudo nano / etc / default / jenkins
     $ JENKINS_USER = "root"

     sudo chown -R root: root / var / lib / jenkins
     sudo chown -R root: root / var / cache / jenkins
     sudo chown -R root: root / var / log / jenkins
     service jenkins restart

- add jenkins credentials with data from your docker hub and replace in jenkinsfile - credentialsId in the "Run ansible playbook" stage

- SSH key private key from AWS must be in /root/.ssh/aws. (remember path if running Jenkins from another user stage "Run ansible playbook")

##-----------------------------------##


При запуске pipeline из jenkinsfile - будут созданы 2 сервера в AWS (t2-micro), c OS - Ubuntu 20.04 средствами Terraform. (файл - aws.tf)
Jenkins запустит Ansible playbook (awsplay.yml)
На одном сервере произойдет сборка JAVA приложения (Maven) и упаковка его в Docker контейнер. 
На втором сервере - запуск контейнера с приложением. (Tomcat)

Вам понадобится: 
- установить Jenkins и выполнить следующие команды для настройки пользователя. (можно заменить root на ubuntu или jenkins) : 
    sudo visudo
    ## Add to the file :
    jenkins ALL=(ALL) NOPASSWD: ALL
    
    service jenkins restart
    sudo nano /etc/default/jenkins
    $JENKINS_USER="root"

    sudo chown -R root:root /var/lib/jenkins
    sudo chown -R root:root /var/cache/jenkins
    sudo chown -R root:root /var/log/jenkins
    service jenkins restart 

- добавить jenkins credentials с данными от вашего docker hub и заменить в jenkinsfile - credentialsId в stage "Run ansible playbook"

- SSH ключ приватный ключ от AWS должен находиться в /root/.ssh/aws . (помнять путь, если запуск Jenkins от другого пользователя stage "Run ansible playbook" )