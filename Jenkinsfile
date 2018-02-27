def server = Artifactory.server 'paradyme-artifactory'
def rtMaven = Artifactory.newMavenBuild()
def buildInfo
pipeline{
    agent any
    tools{
        maven 'mvn-3.5.2'
        jdk 'jdk8'
    }
    stages{


        stage('Build'){
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
            steps{
                timeout(time: 1, unit: 'HOURS') {
                   script {
                       def qg = waitForQualityGate()
                       if (qg.status != 'OK') {
                         error "Pipeline aborted due to quality gate failure: ${qg.status}"
                       }
                   }

                }
            }
        }

        stage("Distribute to Artifactory"){
            steps{
                script{


                 rtMaven.tool = 'mvn-3.5.2' // Tool name from Jenkins configuration
                 rtMaven.deployer releaseRepo: 'libs-release-local', snapshotRepo: 'libs-snapshot-local', server: server
                 rtMaven.resolver releaseRepo: 'libs-release', snapshotRepo: 'libs-snapshot', server: server
                 buildInfo = Artifactory.newBuildInfo()
                 buildInfo.retention maxBuilds: 3, maxDays: 7, doNotDiscardBuilds: ["3"], deleteBuildArtifacts: true
                 rtMaven.run pom: 'pom.xml', goals: 'clean install', buildInfo: buildInfo
                 server.publishBuildInfo buildInfo

                }

            }
        }

        stage("Trigger Image build Job"){
            steps{
                script{
                    def job = build job: 'attic-space-config-server-deployment', parameters: [[$class: 'StringParameterValue', name: 'buildName', value: buildInfo.name], [$class: 'StringParameterValue', name: 'buildNum', value: buildInfo.number], [$class: 'StringParameterValue', name: 'imageName', value: 'as-config-server']]

                }

            }
        }



    }
}