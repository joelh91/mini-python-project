pipeline {
    agent any

    environment {
        SONAR_TOKEN = credentials('SONAR_TOKEN')
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'testing', url: 'https://github.com/joelh91/mini-python-project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '/usr/local/bin/docker build -t mini-python-4:latest .'
            }
        }

        stage('Run Docker Container (Local Test)') {
            steps {
                sh '/usr/local/bin/docker rm -f mini-python-joel3 || true'
                sh '/usr/local/bin/docker run -d --name mini-python-joel3 -p 5000:5000 mini-python-4:latest'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQubeLocal') {
                    sh """
                        ${tool 'sonarqube-scanner'}/bin/sonar-scanner \
                          -Dsonar.projectKey=mini-python-project \
                          -Dsonar.sources=. \
                          -Dsonar.host.url=http://localhost:9000 \
                          -Dsonar.token=${SONAR_TOKEN}
                    """
                }
            }
        }

        stage('Login to AWS ECR') {
            steps {
                sh '''
                    aws ecr get-login-password --region us-east-1 \
                    | docker login --username AWS --password-stdin 203918843788.dkr.ecr.us-east-1.amazonaws.com
                '''
            }
        }

        stage('Tag & Push Image to ECR') {
            steps {
                sh '''
                    docker tag mini-python-4:latest 203918843788.dkr.ecr.us-east-1.amazonaws.com/mini-python-repo:latest
                    docker push 203918843788.dkr.ecr.us-east-1.amazonaws.com/mini-python-repo:latest
                '''
            }
        }

        stage('Deploy to EKS') {
            steps {
                sh '''
                    kubectl set image deployment/mini-python-deploy \
                      mini-python-container=203918843788.dkr.ecr.us-east-1.amazonaws.com/mini-python-repo:latest \
                      --namespace default
                '''
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished!'
        }
    }
}
