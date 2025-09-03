pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "chilukuri268/train-ticket-reservation-system:${BUILD_NUMBER}"
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
                sh 'docker tag $DOCKER_IMAGE chilukuri268/train-ticket-reservation-system:latest'
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        sh 'docker push $DOCKER_IMAGE'
                        sh 'docker push chilukuri268/train-ticket-reservation-system:latest'
                    }
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
