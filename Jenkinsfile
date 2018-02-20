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
                echo 'Building..'

            }
        }

    }
}