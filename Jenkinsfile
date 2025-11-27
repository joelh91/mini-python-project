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

        stage('Run Docker Container') {
            steps {
                // remove old container if running
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
    }

    post {
        always {
            echo 'Pipeline success!'
        }
    }
}

