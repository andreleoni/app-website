namespace :docker do
  desc "Creates and pull the image to DockerHub"
  task push_image: :environment do
    TAG = `git rev-parse --short HEAD`.strip

    puts "Building Docker image"
    sh "docker build -t andreleoni/principal-app:#{TAG} ."

    IMAGE_ID = `docker images | grep andreleoni\/principal-app | head -n1 | awk '{print $3}'`.strip

    puts "Tagging latest image"
    sh "docker tag #{IMAGE_ID} andreleoni/principal-app:latest"

    puts "Pushing Docker image"
    sh "docker push andreleoni/principal-app:#{TAG}"
    sh "docker push andreleoni/principal-app:latest"

    puts "Done"
  end
end
