pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "chilukuri268/train-ticket-reservation-system"
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
                sh 'docker build -t $DOCKER_IMAGE:$BUILD_NUMBER -t $DOCKER_IMAGE:latest .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-credentials', url: 'https://index.docker.io/v1/']) {
                    sh 'docker push $DOCKER_IMAGE:$BUILD_NUMBER'
                    sh 'docker push $DOCKER_IMAGE:latest'
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
