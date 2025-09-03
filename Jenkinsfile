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
                echo 'Running Maven build...'
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}:latest")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub-credentials') {
                        dockerImage.push()
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning workspace...'
            cleanWs()
        }
    }
}

