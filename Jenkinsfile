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