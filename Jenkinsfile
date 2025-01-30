pipeline {
    agent any

    stages {
        stage('Pipeline Stages') {
            steps {
                echo "Running 'deploy.sh' script for listing files..."
                sh './deploy.sh'  // This will replace sh "ls" with the .sh file
            }
        }

        stage('Second Stage') {
            steps {
                echo "Running 'deploy.sh' script for printing the working directory..."
                sh './deploy.sh'  // This will replace sh "pwd" with the .sh file
            }
        }
    }
}

