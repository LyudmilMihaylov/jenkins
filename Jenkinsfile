pipeline {
    agent any

    stages {
        stage('Init') {
            steps {
                // Clean up any running containers and create a new network
                sh 'docker rm -f $(docker ps -qa) || true'
                sh 'docker network create new-network || true'
            }
        }

        stage('Build') {
            steps {
                // Build Flask app image
                sh 'docker build -t flask-app .'

                // Create Dockerfile.nginx dynamically and build Nginx image
                sh '''
                cat <<EOF > Dockerfile.nginx
                FROM nginx:alpine
                COPY nginx.conf /etc/nginx/nginx.conf
                EXPOSE 80
                CMD ["nginx", "-g", "daemon off;"]
                EOF

                // Build the Nginx image
                docker build -t mynginx -f Dockerfile.nginx .
                '''
            }
        }

        stage("Security Scan") {
            steps {
                sh "trivy fs --format json -o trivy-report.json ."
            }
            post {
                always {
                    // Archive the Trivy report
                    archiveArtifacts artifacts: 'trivy-report.json', onlyIfSuccessful: true
                }
            }
        }

        stage('Deploy') {
            steps {
                // Deploy the Flask app container
                sh 'docker run -d --name flask-app --network new-network flask-app:latest'

                // Deploy the Nginx container
                sh 'docker run -d -p 80:80 --name mynginx --network new-network mynginx:latest'
            }
        }

        stage('Execute Tests') {
            steps {
                script {
                    catchError(buildResult: 'UNSTABLE', stageResult: 'UNSTABLE') {
                        sh '''
                        python3 -m venv .venv
                        . .venv/bin/activate
                        pip install -r requirements.txt
                        python3 -m unittest discover -s tests .
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

