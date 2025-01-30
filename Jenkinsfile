pipeline {
    agent any

    stages {
        stage('Pipeline Stages') {
            steps {
                echo "Making 'sh.sh' script executable..."
                // Make sure the script is executable
                sh 'chmod +x ./sh.sh'
                
                echo "Running 'sh.sh' script for listing files..."
                // Run the script
                sh './sh.sh'
            }
        }

        stage('Second Stage') {
            steps {
                echo "Making 'sh.sh' script executable..."
                // Ensure it's executable again for this stage
                sh 'chmod +x ./sh.sh'
                
                echo "Running 'sh.sh' script for printing the working directory..."
                // Run the script
                sh './sh.sh'
            }
        }
    }
}
