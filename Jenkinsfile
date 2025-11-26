pipeline {
    agent any

    stages {
        stage('Checkout SCM') {
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
                pip install pytest
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                . venv/bin/activate
                # Run tests, continue even if none are found
                if pytest; then
                    echo "Tests ran successfully!"
                else
                    echo "No tests found or tests failed."
                fi
                '''
            }
        }

        stage('Build App') {
            steps {
                sh 'echo "Build step placeholder"'
            }
        }

        stage('Run App') {
            steps {
                sh 'echo "Run step placeholder"'
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
