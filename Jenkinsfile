pipeline {
    agent any

    stages {
        stage('Pipeline Stages') {
            steps {
                echo "Running 'sh.sh' script for listing files..."
                sh './sh.sh'  // Call the sh.sh file (make sure it's executable)
            }
        }

        stage('Second Stage') {
            steps {
                echo "Running 'sh.sh' script for printing the working directory..."
                sh './sh.sh'  // Call the sh.sh file (make sure it's executable)
            }
        }
    }
}
