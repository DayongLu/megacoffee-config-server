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



        stage('Build and Push Docker Image to Paradyme Artifactory'){
            steps {
                script {
                    def customImage = docker.build("registry-vpc.cn-beijing.aliyuncs.com/megacoffee/config-server:${params.buildNum}", ".")
                    docker.withRegistry("https://registry-vpc.cn-beijing.aliyuncs.com/megacoffee"){
                        customImage.push()
                        customImage.push('latest')
                    }
                }
            }
        }





    }
}