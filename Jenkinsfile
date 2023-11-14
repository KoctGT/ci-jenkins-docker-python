pipeline {
    agent { label "agent01" }
     environment {
        DOCKER_IMAGE_NAME = "python:3"
    }
    stages {
        stage('Docker Build Custom') {
    	    agent any
              steps {
              	sh 'docker build -t kozlovk/pythonext:latest .'
              }
        }
//        stage('Docker Push') {
//            steps {
//                withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
//        	    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
//                sh 'docker push kozlovk/pythonext:latest'
//        }
                
        stage('Build and Test') {
            agent { 
                docker { 
                    image $DOCKER_IMAGE_NAME
                    reuseNode true
                } 
            }
            steps {
                // Download the code
                checkout scm
                // Run the tests
                sh 'python test_calculator.py'
            }
        }
        stage('Final steps') {
            steps {
                // echo
                echo "Pipeline correct complete! =)"
            }
        }
    }
}
