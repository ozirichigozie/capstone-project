pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage("Create nginx-controller") {
            steps {
                script {
                    dir('nginx-controller') {
                        sh "aws eks --region us-east-1 update-kubeconfig --name capstone"
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }

        stage("Create prometheus") {
            steps {
                script {
                    dir('prometheus') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }

        stage("Deploy LakesideMutual to EKS") {
            steps {
                script {
                    dir('e-commerce') {
                        sh "kubectl apply -f cart-cna-microservice/"
                        sh "kubectl apply -f products-cna-microservice/"
                        sh "kubectl apply -f search-cna-microservice/"
                        sh "kubectl apply -f store-ui/"
                        sh "kubectl apply -f users-cna-microservice/"
                    }
                }
            }
        }

        stage("Deploy ingress rule to EKS") {
            steps {
                script {
                    dir('ingress-rule') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }
    }
}
