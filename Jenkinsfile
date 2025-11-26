pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'testing',
                    url: 'https://github.com/joelh91/mini-python-project.git'
            }
        }

        stage('Install Dependencies') {
            agent {
                docker { image 'python:3.11-slim' }
            }
            steps {
                sh 'pip install -r requirements.txt'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t mini-python-project .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run -d -p 5000:5000 mini-python-project'
            }
        }
    }
}
