pipeline {
  agent {
    node {
      label 'localhost_vagrant'
    }

  }
  stages {
    stage('Build Oracle SQL Developer Data Modeler Image') {
      steps {
        sh 'if [ ! -f $SW_FILE ]; then cp "$SW_DIR/$SW_FILE" $SW_FILE; fi'
        sh 'sudo docker build --tag oracle/datamodeler:$SW_VERSION --build-arg SW_FILE=$SW_FILE .'
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
  environment {
    SW_VERSION = '4.1.5'
    SW_FILE = 'datamodeler-4.1.5.907-1.noarch.rpm'
    SW_DIR = '/software/Oracle/SQL Developer Data Modeler'
  }
}
