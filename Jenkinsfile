/* Requires the Docker Pipeline plugin */
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh '''
                    docker build \
                    --pull \
                    -t lightrush/syncthing:latest .
                '''
            }
        }
        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-lightrush', passwordVariable: 'docker_password', usernameVariable: 'docker_username')]) {
                    sh 'echo $docker_password | docker login -u $docker_username --password-stdin'
                }
                sh 'docker push lightrush/syncthing'
            }
        }
    }
}
