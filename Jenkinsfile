pipeline {
    agent { label "agent01" }
     environment {
        DOCKER_IMAGE_NAME = "python:3"
    }
    options {
    skipDefaultCheckout(true)
    }
    stages {
        stage('Build') {
            agent { 
                docker { 
                    image 'python:3' 
                    reuseNode true
                } 
            }
            steps {
                // Download the code
                checkout scm
            }
        }
        stage('Test') {
            agent { 
                docker { 
                    image 'python:3' 
                    reuseNode true
                } 
            }
            steps {
                // Run the tests
                sh 'python test_calculator.py'
            }
        }
    }
}
