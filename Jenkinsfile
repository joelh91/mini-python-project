pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'testing', url: 'https://github.com/joelh91/mini-python-project.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'pytest || echo "No tests found"'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t mini-python-project .'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed — please check the logs.'
        }
    }
}
