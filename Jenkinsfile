

pipeline {
    agent {
        kubernetes {
            label "${config.pod_label}"
            yamlFile 'KubernetesPods.yaml'
        }
    }
    stages {
        stage('Docker Build') {
            steps {
                container('docker') {
                    sh "docker rm karate || true"
                    sh "docker network create karate || true"
                    sh "docker build --pull -t karate ."
                }
            }
        }
        stage('Karate Tests') {
            parallel {
                stage('Boss') {
                    steps {
                        container('docker') {
                            sh "docker run --network=karate --name karate --cap-add=SYS_ADMIN -w /src karate mvn clean test -Dtest=JenkinsJobRunner"
                        }
                    }
                }
                stage('Workers') {
                    steps {
                        container('docker') {
                            sh karateWorker
                            sh karateWorker
                            sh karateWorker
                        }
                    }
                }
            }
        }
    }
    post {
        always {
            container('docker') {
                sh "docker cp karate:/src/target ."
            }
            junit "target/karate-reports/*.xml"
            publishHTML(
                target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: false,
                    keepAll: true,
                    reportDir: "target/karate-reports",
                    reportFiles: 'karate-summary.html',
                    reportName: "Karate Summary"
                ]
            )
            zip zipFile: "target.zip", archive: false, dir: "target", glob: "karate-reports/**/*,**/*.log"
            archiveArtifacts "target.zip"
        }
    }
}
/*
node {
    karateWorker = "docker run -d --network=karate --rm --cap-add=SYS_ADMIN -e KARATE_JOBURL=http://karate:9080 karate"
}*/