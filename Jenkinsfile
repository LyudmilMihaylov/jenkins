pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                script {
                    echo 'Building the project...'
                    sh 'ls'  // List files to show what is present in the workspace
                }
            }
        }
        
        stage('Test') {
            steps {
                script {
                    echo 'Running tests...'
                    sh 'pwd'  // Print the working directory
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo 'Deploying the project...'
                    sh 'touch deploy.txt'  // Create a file to simulate a deployment
                    sh 'mv deploy.txt /tmp/deploy.txt'  // Simulate deployment by moving the file
                }
            }
        }
    }
}
