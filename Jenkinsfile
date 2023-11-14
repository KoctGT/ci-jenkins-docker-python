pipeline {
    agent { label "agent01" }
    stages {
        stage('Build') {
            agent { docker { image 'python:3' } }
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
