pipeline {
    agent any

    stages {
        stage('Checkout SCM') {
            steps {
                // Clone your repository
                git branch: 'testing', url: 'https://github.com/joelh91/mini-python-project.git'
            }
        }

        stage('Setup Python') {
            steps {
                sh '''
                # Create and activate virtual environment
                python3 -m venv venv
                . venv/bin/activate
                # Upgrade pip
                pip install --upgrade pip
                # Install dependencies
                pip install -r requirements.txt
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                . venv/bin/activate
                # Ensure pytest is installed
                pip install pytest
                # Run tests, fail build if any test fails
                pytest
                '''
            }
        }

        stage('Build App') {
            steps {
                sh '''
                echo "Build step placeholder - here you can build Docker image or package your app"
                '''
            }
        }

        stage('Run App') {
            steps {
                sh '''
                echo "Run step placeholder - here you can start your app or run additional scripts"
                '''
            }
        }
    }

    post {
        success {
            echo "Pipeline finished successfully!"
        }
        failure {
            echo "Pipeline failed — check the logs for details."
        }
    }
}
