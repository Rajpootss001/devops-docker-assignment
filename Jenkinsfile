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
                echo 'Using official images from Docker Hub'
            }
        }

        stage('Deploy Using Docker Compose') {
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
            echo 'Deployment completed successfully'
        }
        failure {
            echo 'Deployment failed'
        }
    }

}
