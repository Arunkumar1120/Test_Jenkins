pipeline {
    agent any
    stages {
        stage('git') {
            steps {
                git branch: 'main', credentialsId: '0f902933-219b-40f5-ba89-504c8081218d', url: 'https://github.com/Arunkumar1120/Test_Jenkins.git'
            }
        }
    }
}
