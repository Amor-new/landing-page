pipeline {
  agent any
  stages {
    stage('Clone Repo') {
      steps {
        git 'https://github.com/amor573/Jenkins_Sample.git'
      }
    }
    stage('Build') {
      steps {
        echo 'Building...'
      }
    }
  }
}

