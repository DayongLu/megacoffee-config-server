pipeline{
    agent any
    tools{
        maven 'mvn-3.5.2'
        jdk 'jdk8'
    }
    stages{
        stage('Initialize'){
            steps{
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }

        }


        stage('BUILD'){
            steps {
                withMaven(maven: 'mvn-3.5.2'){
                    sh 'mvn clean package'
                }


            }
            post {
                success{
                    junit 'target/surefire-reports/**/*.xml'
                }
            }
        }

        stage('SonarQube Analysis'){
            steps{
                withSonarQubeEnv('Paradyme-SonarQube-Server') {
                      // requires SonarQube Scanner for Maven 3.2+
                      sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.2:sonar'
                    }
            }
        }

        stage("SonarQube Quality Gate") {
                timeout(time: 1, unit: 'HOURS') {
                   def qg = waitForQualityGate()
                   if (qg.status != 'OK') {
                     error "Pipeline aborted due to quality gate failure: ${qg.status}"
                   }
                }
            }

    }
}