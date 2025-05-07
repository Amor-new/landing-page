pipeline {
    agent any
    stages {
       stage("Create docker repository"){
        steps {
            echo "aws create-repository --name notifications_api || true "
        }
       }
 
       stage("Build docker image"){
        steps {
            sh "export DOCKER_TLS_VERIFY=1"
            sh "export DOCKER_HOST=tcp://192.168.49.2:2376"
            sh "export DOCKER_CERT_PATH=/home/kuber/.minikube/certs"
            sh "export MINIKUBE_ACTIVE_DOCKERD=minikube"
            echo "cat regpwd.txt | docker login --username devqxz@gmail.com --password-stdin "
            echo "docker build -t devxy/notifications_api:$BUILD_NUMBER ."
            echo "docker tag devxy/notifications_api:$BUILD_NUMBER devxy/notifications_api:latest "
        }
       }
 
       stage("Docker image scan"){
        steps {
            echo "synk notifications_api:v1 --policies 'novulno' "
        }
       }
 
      stage("Push image to registry"){
        steps {
            sh "export DOCKER_TLS_VERIFY=1"
            sh "export DOCKER_HOST=tcp://192.168.49.2:2376"
            sh "export DOCKER_CERT_PATH=/home/kuber/.minikube/certs"
            sh "export MINIKUBE_ACTIVE_DOCKERD=minikube"
            echo "docker push devxy/notifications_api:$BUILD_NUMBER"
            echo "docker push devxy/notifications_api:latest"
        }
      }
 
     stage("deploy"){
        steps {
            echo "kubectl delete -f deploy || true "
            echo "kubectl apply -f deploy"
        }
     }   
    }
}