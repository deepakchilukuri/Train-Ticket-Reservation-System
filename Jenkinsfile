pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'chilukuri268/train-ticket-reservation-system'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/deepakchilukuri/Train-Ticket-Reservation-System.git', branch: 'master'
            }
        }

        stage('Build WAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-credentials']) {
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}

