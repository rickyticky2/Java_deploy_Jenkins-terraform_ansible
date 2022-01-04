pipeline{
    agent any
    tools{
        terraform 'terraform'
    }
    stages{
        stage('Git checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/rickyticky2/Java_deploy_Jenkins-terraform_ansible.git'
            }
        }
        stage('Create Instances with terraform'){
            steps{
                    sh 'sudo terraform init'
                    sh 'sudo terraform apply -auto-approve'
                    script{
                        IP1 = sh (
                        script: 'terraform output first_ip',
                        returnStdout: true
                        ).trim()
                        IP2 = sh (
                        script: 'terraform output second_ip',
                        returnStdout: true
                        ).trim()
                    }
              }
        }
        stage ('Run ansible playbook'){
            steps{
                    withCredentials([usernamePassword(credentialsId: 'ae38ffdc-c52c-4c52-9dc7-90ae44610111', passwordVariable: 'DPWD', usernameVariable: 'DUSER')]) {

                    ansiblePlaybook disableHostKeyChecking: true, installation: 'ansible', playbook: 'awsplay.yml', become: true, extras: "-e'IP1=${IP1}' -e'IP2=${IP2}' -e'USER=${DUSER}' -e'PWD=${DPWD}' --key-file /root/.ssh/aws"
                    }
              }
         }
    }
}
