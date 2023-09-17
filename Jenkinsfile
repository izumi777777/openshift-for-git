pipeline {
    agent {
        label 'nginx'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/izumi777777/openshift-for-git'
            }
        }

        stage('Build and Deploy Nginx') {
            steps {
                // Create a new OpenShift application from the Nginx template
                sh 'oc new-app nginx-example'

                // Expose the Nginx service to create a route
                sh 'oc expose svc/nginx-example'

                // Wait for the deployment to complete
                sh 'oc rollout status dc/nginx-example'
            }
        }
    }
}
