pipeline {
    agent any
    
    environment {
        KUBECTL_PATH = "C:/Users/user/kubectl" // kubectl 실행 파일의 경로
    }
    
    stages {
        stage('Clone Git repository') {
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: 'main']],
                          doGenerateSubmoduleConfigurations: false,
                          extensions: [[$class: 'SubmoduleOption', disableSubmodules: false, parentCredentials: true, recursiveSubmodules: true, reference: '', trackingSubmodules: false]],
                          submoduleCfg: [],
                          userRemoteConfigs: [[url: 'https://github.com/ganyga/finalproject.git']]])
            }
        }
        stage('Deploy Nginx') {
            steps {
                sh "${KUBECTL_PATH} apply -f nginx.yaml"
                sh "IP=$(kubectl get services/nginx -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')"
                sh "curl -s ${IP}"
            }
        }
    }
}
