pipeline {
    agent { label "agent01" }
     environment {
        DOCKER_IMAGE_NAME = "kozlovk/pylint:latest"
    }
    stages {
//        stage('Checkout') {
//        This stage execute in Jenkins automatic as Declarative: Checkout SCM
//          steps {
//            // Download the code
//             checkout scm
//           }
//        }
        stage('Docker Build Custom pylint') {
          steps {
             sh 'docker build -t kozlovk/pylint:latest .'
           }
        }
//        stage('Docker Push') {
//            steps {
//                withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
//        	    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
//                sh 'docker push kozlovk/pythonext:latest'
//            }
//        }
        stage('Linting') { // Run pylint against your code
            agent { 
                docker { 
                    image "kozlovk/pylint:latest"
                    reuseNode true
                } 
            }
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    script {
                      sh """
                      pylint **/*.py
                      """
                    }
                }
            }
        }
        stage('Unit Testing') {
            agent { 
                docker { 
                    image "${DOCKER_IMAGE_NAME}"
                    reuseNode true
                } 
            }
            steps {
                // Run the tests
                sh 'python test_calculator.py'
            }
        }
//        stage('Integration Testing') { //Perform integration testing
//            steps {
//                script {
//                  sh """
//                  # You have the option to stand up a temporary environment to perform
//                  # these tests and/or run the tests against an existing environment. The
//                  # advantage to the former is you can ensure the environment is clean
//                  # and in a desired initial state. The easiest way to stand up a temporary
//                  # environment is to use Docker and a wrapper script to orchestrate the
//                  # process. This script will handle standing up supporting services like
//                  # MySQL & Redis, running DB migrations, starting the web server, etc.
//                  # You can utilize your existing automation, your custom scripts and Make.
//                  ./standup_testing_environment.sh # Name this whatever you'd like
//        
//                  python -m unittest discover -s tests/integration
//                  """
//                  }
//            }
//        }

        stage('Deploy') {
            when {
                branch 'master'
            }
            steps {
                 input 'Deploy to production?'
                 milestone(1)
               // Ansible example
               // - Ansible should be preinstalled on the Jenkins servers
               // - need to store SSH key in Jenkins that can be used for deployments
               // withCredentials([sshUserPrivateKey(credentialsId: "deploy-ssh-key", keyFileVariable: 'deploy.pem')]) {
               //  sh """
               //  ansible-playbook \
               //    --key-file ./deploy.pem \
               //    --extra-vars "environment=#{params.DEPLOY_ENV} version=#{params.DEPLOY_VER}" \
               //    deploy_#{params.DEPLOY_APP}.yml
               //  """
                 script {
                        try {
                            sh 'docker stop kkpylint'
                            sh 'docker rm kkpylint'
                        } catch (err) {
                            echo: 'caught error: $err'
                        }
                        sh 'docker run --restart on-failure --name kkpylint -p 8000:8000 -d kozlovk/pylint:latest python websrv.py'
                    }
                }
        }
    }
    post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if successful'
        }
        failure {
            echo 'This will run only if failed'
            script {
                msg = "Build error for ${env.JOB_NAME} ${env.BUILD_NUMBER} (${env.BUILD_URL})"
            }
        }
        unstable {
            echo 'This will run only if the run was marked as unstable'
        }
        changed {
            echo 'This will run only if the state of the Pipeline has changed'
            echo 'For example, if the Pipeline was previously failing but is now successful'
        }
    }
}
