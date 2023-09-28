# #!/bin/bash
 read -p "enter the version to run: "  version

appname="chat-app"
image_name="${appname}:${version}"

# docker volume create chat-app-data
# artifact_registry_image=me-west1-docker.pkg.dev/grunitech-mid-project/shira-shani-chat-app-images/${appname}:${version}
# gcloud compute ssh shira-shani-first-instance --project grunitech-mid-project --zone me-west1-a 
# gcloud auth configure-docker me-west1-docker.pkg.dev
# docker pull ${artifact_registry_image}
# docker run -p 8080:5000 ${artifact_registry_image}

artifact_registry_image=me-west1-docker.pkg.dev/grunitech-mid-project/shira-shani-chat-app-images/${appname}:${version}
gcloud compute ssh shira-shani-first-instance --project grunitech-mid-project --zone me-west1-a  --command "gcloud auth configure-docker me-west1-docker.pkg.dev; docker volume create chat-app-data; docker pull ${artifact_registry_image}; docker run -p 8080:5000 ${artifact_registry_image}"

#!/bin/bash
# docker volume create chat-app-data
# docker build -t  chat-app .
# # docker run --name chat-run -p 5000:5000 chat-app 
# docker run -v chat-app-data:/chatApp/data -p 5001:5000 chat-app