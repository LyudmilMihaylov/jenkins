pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/LyudmilMihaylov/jenkins.git'
            }
        }

        stage('Cleanup Previous Containers') {
            steps {
                sh 'docker stop my_running_app || true'
                sh 'docker rm my_running_app || true'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t myapp .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run -d -p 5000:5000 --name my_running_app myapp'
            }
        }

        stage('Verify Running Container') {
            steps {
                sh 'docker ps'
            }
        }
    }
}

