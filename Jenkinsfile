pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Rajpootss001/devops-docker-assignment.git'
            }
        }

        stage('Build Docker Images') {
            steps {
                sh 'docker compose build || true'
            }
        }

        stage('Deploy Containers') {
            steps {
                sh '''
                  docker compose down || true
                  docker compose up -d
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh 'docker ps'
            }
        }
    }

    post {
        success {
            echo 'Docker Compose deployment successful'
        }
        failure {
            echo 'Docker Compose deployment failed'
        }
    }
}

