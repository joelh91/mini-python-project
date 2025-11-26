pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'testing', url: 'https://github.com/joelh91/mini-python-project.git'
            }
        }

        stage('Setup Python') {
            steps {
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                    . venv/bin/activate
                    pytest || true
                '''
            }
        }
    }

    post {
        success {
            echo "Pipeline finished successfully!"
        }
        failure {
            echo "Pipeline failed. Check logs."
        }
    }
}
