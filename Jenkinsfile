pipeline {
    agent any

    environment {
        SONAR_TOKEN = credentials('SONAR_TOKEN')
        AWS_REGION = "us-east-1"
        AWS_CREDS = "aws-creds"   // you must create this in Jenkins credentials
        ECR_REGISTRY = "203918843788.dkr.ecr.us-east-1.amazonaws.com"
        ECR_REPO = "mini-python"
        IMAGE_TAG = "latest"
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
                          -Dsonar.login=${SONAR_TOKEN}
                    """
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Login to AWS ECR') {
            steps {
                withAWS(credentials: AWS_CREDS, region: AWS_REGION) {
                    sh """
                        aws ecr get-login-password --region $AWS_REGION \
                        | docker login --username AWS --password-stdin $ECR_REGISTRY
                    """
                }
            }
        }

        stage('Tag & Push Image to ECR') {
            steps {
                sh """
                    docker tag mini-python-4:latest $ECR_REGISTRY/$ECR_REPO:$IMAGE_TAG
                    docker push $ECR_REGISTRY/$ECR_REPO:$IMAGE_TAG
                """
            }
        }

        stage('Deploy to EKS') {
            steps {
                withAWS(credentials: AWS_CREDS, region: AWS_REGION) {
                    sh """
                        aws eks update-kubeconfig --name mini-python-cluster --region $AWS_REGION
                        kubectl set image deployment/mini-python mini-python=$ECR_REGISTRY/$ECR_REPO:$IMAGE_TAG --record || true
                    """
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline success!'
        }
    }
}
