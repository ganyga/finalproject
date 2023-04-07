pipeline {
  agent any
  stages {
    stage('git scm update') {
      steps {
        git url: 'https://github.com/ganyga/jen', branch: 'main'
      }
    }
    stage('docker build') {
      steps {
        sh '''
        docker build -t gaeunoo/my-nginx . 
        sudo docker push rapa.iptime.org:5000/mynginx:gany
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
