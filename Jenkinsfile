pipeline {
    agent any

    environment {
        NETWORK_NAME = 'new-network'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Init') {
            steps {
                sh 'docker ps -qa'
                sh 'docker rm -f $(docker ps -qa) || true'
                script {
                    try {
                        sh 'docker network create $NETWORK_NAME || true'
                    } catch (e) {
                        echo "Network creation failed, it might already exist"
                    }
                }
            }
        }

        stage('Build Flask App') {
            steps {
                sh 'docker build -t flask-app .'
            }
        }

        stage('Build Nginx') {
            steps {
                sh 'docker build -t mynginx -f Dockerfile.nginx .'
            }
        }

        stage('Security Scan') {
            steps {
                sh 'trivy fs --format json -o trivy-report.json .'
            }
        }

        stage('Deploy') {
            steps {
                // Run Flask App
                sh 'docker run -d --name flask-app --network $NETWORK_NAME flask-app:latest'

                // Run Nginx
                sh 'docker run -d -p 80:80 --name mynginx --network $NETWORK_NAME mynginx:latest'
            }
        }

        stage('Execute Tests') {
            steps {
                echo "Tests would be executed here"
            }
        }

        stage('Post Actions') {
            steps {
                echo 'Pipeline failed!' // You can add conditional actions here based on success/failure
            }
        }
    }
}

