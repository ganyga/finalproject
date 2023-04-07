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
    stage('git scm update') {
      steps {
        git url: 'https://github.com/ganyga/finalproject.git', branch: 'main'
      }
    }
    
    stage('docker build') {
      steps {
        sh '''
          docker build -t gaeunoo/nginx:gany .
          docker push gaeunoo/nginx:gany
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
