pipeline {
    agent any

    stages {

        stage('Init') {
            steps {
                // Clean up all containers
                sh 'docker rm -f $(docker ps -qa) || true'

                // Create a custom Docker network
                sh 'docker network create new-network || true'
            }
        }

        stage('Build') {
            steps {
                // Build the flask app Docker image
                sh 'docker build -t flask-app .'

                // Build the Nginx Docker image from the Nginx-specific Dockerfile
                sh 'docker build -t mynginx -f nginx.conf .'
            }
        }

        stage("Security Scan") {
            steps {
                // Run Trivy scan on the file system and output as JSON
                sh "trivy fs --format json -o trivy-report.json ."
            }
            post {
                always {
                    // Archive the Trivy report (even if scan fails)
                    archiveArtifacts artifacts: 'trivy-report.json', allowEmptyArchive: true
                }
            }
        }

        stage('Deploy') {
            steps {
                // Run the Flask app container in the custom network
                sh 'docker run -d --name flask-app --network new-network flask-app:latest'

                // Run the Nginx container and map it to port 80
                sh 'docker run -d -p 80:80 --name mynginx --network new-network mynginx:latest'
            }
        }

        stage('Execute Tests') {
            steps {
                script {
                    // Use a try-catch block to handle errors and continue if the tests fail
                    catchError(buildResult: 'UNSTABLE', stageResult: 'UNSTABLE') {
                        sh '''
                            # Set up a Python virtual environment for testing
                            python3 -m venv .venv
                            . .venv/bin/activate

                            # Install dependencies
                            pip install -r requirements.txt

                            # Run the unit tests
                            python3 -m unittest discover -s tests .

                            # Deactivate the virtual environment
                            deactivate
                        '''
                    }
                }
            }
        }

    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}

