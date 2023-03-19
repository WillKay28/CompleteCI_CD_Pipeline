pipeline {
    agent any

    stages {

        stage('Fetch code') {
            steps {
                git branch: 'main', url: 'https://github.com/WillKay28/CompleteCI_CD_Pipeline.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install -DskipTests'
            }
            post {
                success {
                    echo 'Now Archiving.'
                    archiveArtifacts artifacts: '**/target/*.war'
                }
            }
        }
        
        stage('Unit Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Checkstyle Analysis') {
            steps {
                sh 'mvn checkstyle:checkstyle'
            }
            post {
                success {
                    echo 'Generated Analysis Result'
                }
            }
        }

        stage("build & SonarQube analysis") {
            steps {
                withSonarQubeEnv('sonar') {
                    sh 'mvn clean package sonar:sonar'
                }
            }
        }

        stage("Quality Gate") {
            steps {
              timeout(time: 1, unit: 'MINUTES') {
                waitForQualityGate abortPipeline: true
              }
            }
          }

        stage ('Deploy to Tomcat') {
            steps {
                sshagent(['deploy_to_tomcat']) {
                    sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/java/target/vprofile-v2.war ubuntu@3.239.109.209:/opt/tomcat/webapps'
                }
            }
        }
    }
}
