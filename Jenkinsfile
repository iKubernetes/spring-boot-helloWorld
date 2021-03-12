pipeline {
    environment { 
        appName = "spring-boot-helloworld"
        appVersion = "v0.9.0"
        //registry = "http://10.247.192.192:8082"
        registry = "http(s)://YOUR_REGISTRY_HOST:PORT"
        //registryCredential = "nexus_admin"
        registryCredential = "YOUR_REGISTRY_USER_CREDENTIAL"
        dockerImage = ""
    }     
    agent {
        kubernetes {
            label 'maven-and-docker'
        }
    }
    stages {
        stage('Source') {
            steps {
                git branch: 'master', url: 'http://gitlab.gitlab.svc.cluster.local/root/spring-boot-helloworld.git'
            }
        }
        stage('Build') {
            steps {
                container('maven') {
                    sh 'mvn clean test package'
                }
            }
        }
        stage('Building app image') { 
            steps {
                container('docker') {
                    script {
                        dockerImage = docker.build appName + ":" + appVersion
                    }
                }
            }
        }
        stage('Push app image') {
            steps {
                container('docker') {
                    script {
                        docker.withRegistry( registry, registryCredential ) {
                            dockerImage.push()
                        }
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                container('kubectl') {
                    withKubeConfig([credentialsId: 'k8s-cluster-admin-kubeconfig-file'
                                    ]) {
                        sh 'kubectl apply -f deploy/'
                    }                      
                }
            }
        }
    }
    post {
        failure {
            updateGitlabCommitStatus name: 'build', state: 'failed'
        }
        success {
            updateGitlabCommitStatus name: 'build', state: 'success'
        }
    }

}
