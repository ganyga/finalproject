pipeline {
  agent any
  
  environment {
    gitName = 'ganyga'
    gitEmail = 'artzana03@gmail.com'
    gitWebaddress = 'https://github.com/ganyga/finalproject.git'
    gitCredential = 'git_cre'
    GITDEPADD = 'git@github.com:ganyga/finalproject.git'
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
   
    stage('Docker image Build') {
      steps {
        sh "docker build -t ${dockerHubRegistry}:${currentBuild.number} ."
        sh "docker build -t ${dockerHubRegistry}:latest ."
        }
        post {
            failure {
                echo 'docker image build failure'
            }
            success {
                echo 'docker image build success'
            }
        }
    }
    
    stage('Docker image Push') {
      steps {
        withDockerRegistry(credentialsId: dockerHubRegistryCredential, url: '') {
       
            sh "docker push ${dockerHubRegistry}:${currentBuild.number}"
            sh "docker push ${dockerHubRegistry}:latest"
          }
      }
      
      post {
        failure {
            echo 'Docker image push failure'
            sh "docker image rm -f ${dockerHubRegistry}:${currentBuild.number}"
            sh "docker image rm -f ${dockerHubRegistry}:latest"
        }
        success {
            echo 'Docker image push success'
            sh "docker image rm -f ${dockerHubRegistry}:${currentBuild.number}"
            sh "docker image rm -f ${dockerHubRegistry}:latest"
        }
     }
    }
    stage('k8s manifest file update') {
      steps {
        git credentialsId: gitCredential,
            url: gitWebaddress,
            branch: 'main'
        
        // 이미지 태그 변경 후 메인 브랜치에 푸시
        sh "git config --global user.email ${gitEmail}"
        sh "git config --global user.name ${gitName}"
        sh "sed -i 's@${dockerHubRegistry}:.*@${dockerHubRegistry}:${currentBuild.number}@g' test.yml"
        sh "git add ."
        sh "git commit -m 'fix:${dockerHubRegistry} ${currentBuild.number} image versioning'"
        sh "git branch -M main"
        sh "git remote remove origin"
        sh "git remote add origin ${GITDEPADD}"
        sh "git push -u origin main"

      }
      post {
        failure {
          echo 'Container Deploy failure'
        }
        success {
          echo 'Container Deploy success'  
        }
      }
    }
  }
}
