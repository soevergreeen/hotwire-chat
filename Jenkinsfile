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
        sh "docker build -t ${IMAGE}:${TAG} ."
      }
    }

    stage('Run tests') {
      steps {
        echo "🧪 Running RSpec..."
        sh "docker run --rm ${IMAGE}:${TAG} bash -lc 'bundle exec rspec'"
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
