pipeline {
    agent any
    parameters {
        choice(name: 'BranchName', choices:['main','branch01','branch02'], description: 'to refresh the list, go to configure, disable "this build has parameters", launch build (without parameters)to reload the list and stop it, then launch it again (with parameters)')
   }
    stages {
       stage("Run Tests") {
         steps {
             sh "echo SUCCESS on ${BranchName}"
         }
      }
        stage('SCM Checkout') {
            steps {
                git branch: ${BranchName}, credentialsId: '0f902933-219b-40f5-ba89-504c8081218d', url: 'https://github.com/Arunkumar1120/Test_Jenkins.git'
            }
        }
        stage('Docker Container Clean'){
            steps {
                sh 'docker system prune -a --volumes -f'
            }
        }
        stage('Docker Container'){
            steps {
                sh 'docker compose up -d'
            }
        }
        stage('File Deployment'){
            steps{
                sh 'docker cp staticwebsite.html samplecont:/usr/share/nginx/html/index.html'
                sh 'echo "SUCCESS"'
            }
        }
    }
}
