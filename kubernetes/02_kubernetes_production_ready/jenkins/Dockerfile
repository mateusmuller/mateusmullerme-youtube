# ref:
# https://medium.com/@lilnya79/building-jenkins-image-with-docker-cli-preinstalled-for-seamless-devops-integration-ec185f76755b
FROM jenkins/jenkins:latest

USER root

RUN apt-get update && \
    apt-get install -y sudo vim curl wget

RUN echo 'root:abc123' | chpasswd

RUN echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN apt-get update && \
    apt-get install -y apt-transport-https \
                       ca-certificates \
                       gnupg2 \
                       software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker.gpg && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce-cli

RUN groupadd docker

RUN usermod -aG docker jenkins

USER jenkins
