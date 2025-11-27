pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'testing', url: 'https://github.com/joelh91/mini-python-project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build Docker image and tag it using full Docker path
                sh '/usr/local/bin/docker build -t mini-python-3:latest .'
            }
        }

        stage('Run Docker Container') {
            steps {
                // Run container in detached mode using full Docker path
                sh '/usr/local/bin/docker run -d --name mini-python-joel -p 5000:5000 mini-python-3:latest'
            }
        }
    }

    post {
        always {
            echo 'Pipeline success!'
        }
    }
}

