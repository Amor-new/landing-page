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

    stage('Authenticate Snyk') {
      steps {
        withCredentials([string(credentialsId: 'synk-token', variable: 'SNYK_TOKEN')]) {
          sh 'snyk auth $SNYK_TOKEN'
        }
      }
    }

    stage('Snyk Image Scan') {
      steps {
        sh '''
          snyk container test $IMAGE_NAME:$BUILD_NUMBER || true
        '''
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

    stage('Deploy to Local VM') {
      steps {
        sh '''
          docker pull $IMAGE_NAME:$BUILD_NUMBER
          docker stop landing-container || true
          docker rm landing-container || true
          docker run -d --name landing-container -p 80:80 $IMAGE_NAME:$BUILD_NUMBER
        '''
      }
    }
  }
}
