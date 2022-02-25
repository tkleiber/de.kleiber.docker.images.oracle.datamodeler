pipeline {

  agent {
    node {
      label 'docker_in_docker'
    }
  }

  environment {
    SW_VERSION = '21.4.1'
    SW_FILE = 'datamodeler-21.4.1.349.1605-1.noarch.rpm'
    SW_DIR = '/software/Oracle/SQL Developer Data Modeler'
  }

  options {
    buildDiscarder logRotator(numToKeepStr: '1')
  }

  stages {

    stage('Build Oracle SQL Developer Data Modeler Image') {
      steps {
        sh 'if [ ! -f $SW_FILE ]; then cp "$SW_DIR/$SW_FILE" $SW_FILE; fi'
        withCredentials(bindings: [usernamePassword(credentialsId: 'docker_hub_id', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          sh '''
            export DOCKER_BUILDKIT=1
            docker login --username $USERNAME --password $PASSWORD
            docker build --progress=plain --tag oracle/datamodeler:$SW_VERSION --build-arg SW_FILE=$SW_FILE .
          '''
        }

      }
    }

    stage('Push Docker Image to Local Registry') {
      steps {
        sh 'docker tag oracle/datamodeler:$SW_VERSION localhost:5000/oracle/datamodeler:$SW_VERSION'
        sh 'docker push localhost:5000/oracle/datamodeler:$SW_VERSION'
      }
    }

    stage('Cleanup') {
      steps {
        sh 'docker rmi --force localhost:5000/oracle/datamodeler:$SW_VERSION'
        sh 'docker rmi --force oracle/datamodeler:$SW_VERSION'
      }
    }

  }

}
