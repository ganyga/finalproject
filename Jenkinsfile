pipeline {
    agent any
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
                sh "kubectl apply -f nginx.yaml"
                // ...
            }
        }
        // ...
    }
}
