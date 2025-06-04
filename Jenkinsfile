pipeline {
  agent any

  environment {
    IMAGE = "chat-ci"
    TAG   = "${env.BUILD_NUMBER}"
  }

  stages {
    stage('Build image') {
      steps {
        echo "🚧 Building Docker image..."
        bat "docker build -t ${IMAGE}:${TAG} ."
      }
    }
   }

  post {
    success {
      echo "✅ Build #${env.BUILD_NUMBER} succeeded"
    }
    failure {
      echo "❌ Build #${env.BUILD_NUMBER} failed"
    }
  }
}
