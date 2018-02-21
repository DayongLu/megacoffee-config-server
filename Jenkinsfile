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

        stage('STATIC'){
            steps{
                checkstyle canComputeNew: false, defaultEncoding: '', healthy: '', pattern: 'target/checkstyle-result.xml', unHealthy: ''
                findbugs canComputeNew: false, defaultEncoding: '', excludePattern: '', healthy: '', includePattern: '', pattern: 'target/findbugsXml.xml', unHealthy: ''
                withMaven(maven: 'mvn-3.5.2'){
                                    sh 'mvn sonar:sonar \
                                          -Dsonar.host.url=http://18.219.80.119:9000 \
                                          -Dsonar.login=ba5f3d138b0d64b62083b05a64a4e5807b5014e4'
                                }
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

    }
}