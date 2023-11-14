pipeline {
    agent { label "agent01" }
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
            steps {
                // Run the tests
                sh 'python test_calculator.py'
            }
        }
    }
}
