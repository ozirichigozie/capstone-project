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
                    dir('capstone/kubernetes/manifests') {
                        sh "kubectl apply -f customer-core.yaml"
                        sh "kubectl apply -f customer-management-backend.yaml"
                        sh "kubectl apply -f customer-management-frontend.yaml"
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
