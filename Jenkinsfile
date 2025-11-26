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
                // Build Docker image and tag it
                sh 'docker build -t mini-python-app:latest .'
            }
        }

        stage('Run Docker Container') {
            steps {
                // Run container in detached mode
                sh 'docker run -d --name mini-python-container -p 5000:5000 mini-python-app:latest'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished!'
        }
    }
}
