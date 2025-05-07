pipeline {
  agent any

  environment {
    IMAGE_NAME = "Amor573/landing-page"
    K8S_SECRET_NAME = "dockerhub-regcred"
  }

  stages {
    stage('Checkout Code') {
      steps {
        checkout scm
      }
    }

    stage('Docker Login & Build') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh '''
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker build -t $IMAGE_NAME:$BUILD_NUMBER .
            docker tag $IMAGE_NAME:$BUILD_NUMBER $IMAGE_NAME:latest
          '''
        }
      }
    }

    stage('Snyk Image Scan') {
      steps {
        withCredentials([string(credentialsId: 'snyk-token', variable: 'SNYK_TOKEN')]) {
          sh '''
            snyk container test $IMAGE_NAME:$BUILD_NUMBER || true
          '''
        }
      }
    }

    stage('Push to Docker Hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh '''
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker push $IMAGE_NAME:$BUILD_NUMBER
            docker push $IMAGE_NAME:latest
          '''
        }
      }
    }
  }
}
