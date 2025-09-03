pipeline {
    agent any

    environment {
        IMAGE_NAME = "chilukuri268/train-ticket-reservation-system"
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
                script {
                    sh "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} ."
                    sh "docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
                        sh "docker push ${IMAGE_NAME}:${BUILD_NUMBER}"
                        sh "docker push ${IMAGE_NAME}:latest"
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    // Stop old container if exists
                    sh "docker rm -f train-ticket-app || true"
                    // Run new container on port 8076
                    sh "docker run -d -p 8076:8076 --name train-ticket-app ${IMAGE_NAME}:latest"
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
