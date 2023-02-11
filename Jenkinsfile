pipeline{
    environment{
        dockerImage = ''
        registryName = "krushnabhanage10/jnlp-slave"
        registryCredential = 'dockerhub'
        registryUrl = 'krushnaacr.azurecr.io'
        tag = 'javamavenpythonnodejs'
    }
//     agent{
//       label "vm"
//     }
    agent{
        kubernetes{
    label 'k8sagent'
    defaultContainer 'jnlp'
    yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: jnlp
    image: krushnabhanage10/jnlp-slave:kubectl2
    tty: true
    volumeMounts:
    - mountPath: /var/run/
      name: docker-sock
    - mountPath: "/home/jenkins/agent"
      name: "workspace-volume"
      readOnly: false
    workingDir: "/home/jenkins/agent"    
    resources:
      limits:
        cpu: 400m
        memory: 600Mi
      requests:
        cpu: 200m
        memory: 300Mi
    env:
    - name: JENKINS_URL
      value: http://47.242.21.13:8080/
    securityContext:
      privileged: true
      runAsUser: 0
  - name: docker
    image: docker:19.03.1-dind
    volumeMounts:
    - mountPath: /var/run/
      name: docker-sock
    securityContext:
      privileged: true
      runAsUser: 0
  volumes:
    - name: docker-sock
      emptyDir: {}
    - emptyDir:
      medium: ""
      name: "workspace-volume"
"""
        }
    }
    stages{
        stage("Image_Build_Push"){
            steps{
                dir("${workspace}/buildimage"){
                    sh "pwd"
                    //sh "docker build -t krushnabhanage10/dotnetapp:jenkins ."
                }
                script{
                    withDockerRegistry(/*url: "https://${registryUrl}",*/ credentialsId: registryCredential) {
                        dockerImage = docker.build("${registryName}:${tag}")
                        //sh "docker push $registryName:$tag"
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
