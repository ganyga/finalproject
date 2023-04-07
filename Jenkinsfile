pipeline {
    agent any
    environment {
        KUBECONFIG = credentials('kubeconfig')
        IMAGE_NAME = 'gaeunoo/nginx-example'
        APP_NAME = 'nginx-example'
        NAMESPACE = 'default'
    }
    stages {
        stage('Build and Push Docker Image') {
            steps {
                script {
                    def app = docker.build(IMAGE_NAME)
                    app.push()
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    kubectl config use-context kubernetes
                    kubectl set image deployment/${APP_NAME} ${APP_NAME}=${IMAGE_NAME} -n ${NAMESPACE}
                '''
            }
        }
    }
}
