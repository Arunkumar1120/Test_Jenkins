pipeline {
    agent any
    parameters {
        choice(name: 'branchName', choices:['main','branch01','branch02'], description: 'to refresh the list, go to configure, disable "this build has parameters", launch build (without parameters)to reload the list and stop it, then launch it again (with parameters)')
   }
    stages {
       stage("Run Tests") {
         steps {
             sh "echo SUCCESS on ${branchName}"
         }
      }
        stage('SCM Checkout') {
            steps {
                git branch: '${branchName}', credentialsId: '0f902933-219b-40f5-ba89-504c8081218d', url: 'https://github.com/Arunkumar1120/Test_Jenkins.git'
            }
        }
        stage('Docker Container Clean'){
            steps {
                sh 'docker rm -f samplecont'
                sh 'docker rmi -f nginx:alpine'
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
            }
        }
  post {
    success {
      slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")

      hipchatSend (color: 'GREEN', notify: true,
          message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})"
        )

      emailext (
          subject: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
          body: """<p>SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
            <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
          recipientProviders: [[$class: 'DevelopersRecipientProvider']]
        )
    }

    failure {
      slackSend (color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")

      hipchatSend (color: 'RED', notify: true,
          message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})"
        )

      emailext (
          subject: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
          body: """<p>FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
            <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
          recipientProviders: [[$class: 'DevelopersRecipientProvider']]
        )
    }
  }
}
}
