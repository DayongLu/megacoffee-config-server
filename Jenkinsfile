def server = Artifactory.server 'paradyme-artifactory'
def rtMaven = Artifactory.newMavenBuild()
def buildInfo
pipeline{
    agent any
    tools{
        maven 'mvn-3.5.2'

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



        stage("Distribute to Artifactory"){
            steps{
                script{


                 rtMaven.tool = 'mvn-3.5.2' // Tool name from Jenkins configuration
                 rtMaven.deployer releaseRepo: 'libs-release-local', snapshotRepo: 'libs-snapshot-local', server: server
                 rtMaven.resolver releaseRepo: 'libs-release', snapshotRepo: 'libs-snapshot', server: server
                 buildInfo = Artifactory.newBuildInfo()
                 buildInfo.retention maxBuilds: 3, maxDays: 7, doNotDiscardBuilds: ["3"], deleteBuildArtifacts: true
                 rtMaven.run pom: 'pom.xml', goals: 'clean install', buildInfo: buildInfo
                 buildInfo.name = 'as-config-server'
                 server.publishBuildInfo buildInfo

                }

            }
        }

        stage("Trigger Image build Job"){
            steps{

                                    script{
                                        def job = build job: 'deployment-job', parameters: [
                                        [$class: 'StringParameterValue', name: 'buildName', value: buildInfo.name],
                                        [$class: 'StringParameterValue', name: 'buildNum', value: buildInfo.number],
                                        [$class: 'StringParameterValue', name: 'replica', value: '1'],
                                        [$class: 'StringParameterValue', name: 'serviceType', value: 'none'],
                                        [$class: 'StringParameterValue', name: 'namespace', value: 'middleware'],
                                        [$class: 'StringParameterValue', name: 'profile', value: 'build']
                                        ]
                                    }

                                }
        }



    }
}