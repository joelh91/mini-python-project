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
            steps {
                sh 'python3 --version'
                sh 'pip3 --version'
                sh 'pip3 install -r requirements.txt'
            }
        }

        stage('Run Tests') {
            steps {
                echo 'No tests yet — skipping'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t mini-python-project .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run -d -p 5000:5000 --name mini-python-project mini-python-project'
            }
        }
    }
}

