pipeline {
    agent any

    environment {
        TRIVY_OUTPUT = 'trivy_scan_results.json'
    }

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

        stage('Run Trivy Scan') {
            steps {
                script {
                    // Run Trivy scan on the Docker image and save the output as JSON
                    sh "trivy image --format json --output ${TRIVY_OUTPUT} myapp"
                }
            }
        }

        stage('Archive Trivy Scan Results') {
            steps {
                // Archive the Trivy scan results for later inspection
                archiveArtifacts allowEmptyArchive: true, artifacts: "${TRIVY_OUTPUT}"
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

        stage('Install Dependencies for Testing') {
            steps {
                // Install necessary dependencies for testing
                sh 'pip install requests'
            }
        }

        stage('Run Flask Tests') {
            steps {
                script {
                    // Assuming you have a test file `flask_test.py` with your unit tests
                    sh 'python3 -m unittest flask_test.py'
                }
            }
        }
    }
}

