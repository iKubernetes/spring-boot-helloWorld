pipeline {
    agent {
        kubernetes {
            inheritFrom 'kube-maven'
        }
    }    
    triggers {
        gitlab(triggerOnPush: true,
               triggerOnMergeRequest: true,
               branchFilterType: 'All',
               secretToken: '9iH0tq33ROMS07przzLiclNmfqSaoIeTOolHYf1E')
    }
    parameters {
        booleanParam(name: "PUSH", defaultValue: true)
    }    
    environment {
        GitRepo="http://gitlab.magedu.com/root/spring-boot-helloWorld.git"
        HarborServer='hub.magedu.com'
        ImageUrl="ikubernetes/spring-boot-helloworld"
        ImageTag="latest"
        RegistryCredential='harbor-user-credential'
        RegistryUrl="https://${HarborServer}"
    }  
    stages {
        stage('Source') {
            steps {
                git branch: 'main', url: "${GitRepo}"
            }
        }      
        stage('Build') {
            steps {
            	container('maven') {
                    sh 'mvn -B -DskipTests clean package'
                }
            }
        }       
        stage('Test') {
            steps {
            	container('maven') {
                    sh 'mvn test'
                }
            }
        }
        stage("SonarQube Analysis") {
            steps {
                withSonarQubeEnv('SonarQube-Server') {
                    container('maven') {
                        sh 'mvn sonar:sonar'
                    }
                }
            }
        }
        stage("Quality Gate") {
            steps {
                timeout(time: 30, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
        stage('Build Image') {
            steps {
                container('dind') {
                    script {
                        dockerImage = docker.build("${HarborServer}/${ImageUrl}:${ImageTag}")  
                    }
                }
            }
        }       
        stage('Push Image') {
            when {
                expression { params.PUSH }
                beforeAgent true
            }
            steps {
                container('dind') {
                    script {
                        docker.withRegistry( RegistryUrl, RegistryCredential ) {
                            dockerImage.push()
                        }
                    }
                }
            }
        }                 
    }
    post{
        always {
            mail to: 'mage@magedu.com',
            subject: "Status of pipeline: ${currentBuild.fullDisplayName}",
            body: "${env.BUILD_URL} has result ${currentBuild.result}"
        }
    }
}
