pipeline {
  agent any
  
    environment {
    gitName = 'gany'
    gitEmail = 'artzana03@gmail.com'
    gitWebaddress = 'https://github.com/ganyga/finalproject.git'
    gitCredential = 'git_cre' // github credential 생성 시의 ID
    dockerHubRegistry = 'gaeunoo/nginx'
    dockerHubRegistryCredential = 'docker_cre'
    }
  
  stages {
    stage('checkout Github') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: gitCredential, url: gitWebaddress]]])
        }
        post {
            failure {
                echo 'Repository clone failure'
            }
            success {
                echo 'Repository clone success'
            }
        }
    }
    stage('docker build') {
      steps {
        sh '''
        sudo docker build -t gaeunoo/nginx:gany .
        sudo docker push gaeunoo/nginx:gany
        '''
      }
    }
    
    stage('deploy k8s') {
      steps {
        sh '''
        sudo kubectl apply -f test.yml
        '''
      }
    }
    
  }
}
