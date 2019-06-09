namespace :docker do
  desc "Creates and pull the image to DockerHub"
  task push_image: :environment do
    TAG = `git rev-parse --short HEAD`.strip

    puts "Building Docker image"
    sh "docker build -t andreleoni/app-website:#{TAG} ."

    IMAGE_ID = `docker images | grep andreleoni\/app-website | head -n1 | awk '{print $3}'`.strip

    puts "Tagging latest image"
    sh "docker tag #{IMAGE_ID} andreleoni/app-website:latest"

    puts "Pushing Docker image"
    sh "docker push andreleoni/app-website:#{TAG}"
    sh "docker push andreleoni/app-website:latest"

    puts "Done"
  end

  desc "Creates and pull the image to DockerHub for circleci"
  task push_image_circle_ci: :environment do
    TAG = `git rev-parse --short HEAD`.strip

    puts "Building Docker image"
    sh "docker build -t andreleoni/app-website-circleci:#{TAG} -f docker/CircleCI_Dockerfile ."

    IMAGE_ID = `docker images | grep andreleoni\/app-website-circleci | head -n1 | awk '{print $3}'`.strip

    puts "Tagging latest image"
    sh "docker tag #{IMAGE_ID} andreleoni/app-website-circleci:latest"

    puts "Pushing Docker image"
    sh "docker push andreleoni/app-website-circleci:#{TAG}"
    sh "docker push andreleoni/app-website-circleci:latest"

    puts "Done"
  end
end
