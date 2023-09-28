#!/bin/bash

# Check if the script was passed any arguments
if [ $# -eq 0 ]; then
    # No arguments were passed, so prompt the user for them
    # Get the version and commit hash from the user
    echo "Enter the version number: "
    read version
    echo "Enter the commit hash: "
    read commit_hash
else
    # Arguments were passed, so use them
    version=$1
    commit_hash=$2
fi

appname="chat-app"
image_name="${appname}:${version}"

# Check if the Docker image already exists
if docker inspect "$image_name" &>/dev/null; then
    # Image exists
    echo "Docker image $image_name already exists."

    # Ask the user if they want to rebuild the image
    echo "Use the existing image  - [N|n] or rebuild and delete the existing one - [Y|y]" 
    read rebuild_choice
    if [[ "$rebuild_choice" == "y" || "$rebuild_choice" == "Y" ]]; then
        # Remove the existing image
        docker rmi "$image_name"
        # Build the Docker image
        docker build -t "$image_name" .
    elif [[ "$rebuild_choice" == "n" || "$rebuild_choice" == "N" ]]; then
        echo "Using the existing image."
    else
       echo "invalid input ---> using the existing image"    
    fi
else
    # Image does not exist, so build it
    docker build -t "$image_name" .
fi
# If a commit hash is provided, check if it exists
if [ -n "$commit_hash" ] && ! git rev-parse --verify "$commit_hash" &>/dev/null; then
    echo "Error: The specified commit hash does not exist."
    exit 1
fi
# Ask the user if they want to tag and push to GitHub
read -p "Do you want to tag and push to GitHub? enter [y|Y] if you want otherwise
enter [n|N]: " push_choice
if [[ "$push_choice" == "Y" || "$push_choice" == "y" ]]; then
    # Tag the image with the commit hash
    git tag "${version}" "${commit_hash}"
    git push origin "${version}"

    # Check if the image was pushed successfully
    if [ $? -ne 0 ]; then
        echo "Error pushing image to GitHub"
        exit 1
    fi
    echo "tag pushed to GitHub successfully"
elif [[ "$push_choice" == "N" || "$push_choice" == "n" ]]; then
    echo "Tagging and pushing to GitHub skipped."
else
    # If the choice is neither 'Y' nor 'N', show a message
    echo "Invalid choice ---> (not tagging and pushing to GitHub)."
fi

# Push the Docker image to Artifact Registry (optional)
echo "Do you want to push to GCR?"
echo "enter Y|y or N|n"
read push_to_gcr
if [[ "$push_to_gcr" == "Y" || "$push_to_gcr" == "y" ]]; then
   gcloud config set auth/impersonate_service_account artifact-admin-sa@grunitech-mid-project.iam.gserviceaccount.com 	
   gcloud auth configure-docker me-west1-docker.pkg.dev
   artifact_registry_image=me-west1-docker.pkg.dev/grunitech-mid-project/shira-shani-chat-app-images/${appname}:${version}
   docker tag ${image_name} ${artifact_registry_image} 
   docker push ${artifact_registry_image}
   gcloud config unset auth/impersonate_service_account
else
    echo "not pushing to GCR"
fi       


#====================================================
#====================================================
# before changing deploy.sh, the simple version:
 #!/bin/bash

# # Check if the script was passed any arguments
# if [ $# -eq 0 ]; then
#     # No arguments were passed, so prompt the user for them
#     # Get the version and commit hash from the user
#     echo "Enter the version number: "
#     read version
#     echo "Enter the commit hash: "
#     read commit_hash
# else
#   # Arguments were passed, so use them
#   version=$1
#   commit_hash=$2
# fi

# echo vertion commit_hash

# appname="chat-app"
# # Build the Docker image
# docker build -t ${appname}:${version} .

# # Tag the image with the commit hash
# git tag ${version} ${commit_hash}

# git push origin ${version}
# # Check if the image was pushed successfully
# if [ $? -ne 0 ]; then
#   echo "Error pushing image to GitHub"
#   exit 1
# fi

# # Success!
# echo "Image pushed to GitHub successfully"


#============================================
#============================================

#Modify deploy.sh to check if the image exists before building it and ask the user if he wants to rebuild the image or use the existing one. If he chooses to rebuild then delete the existing one.
#!/bin/bash
# Check if the script was passed any arguments
# if [ $# -eq 0 ]; then
#     # No arguments were passed, so prompt the user for them
#     # Get the version and commit hash from the user
#     echo "Enter the version number: "
#     read version
#     echo "Enter the commit hash: "
#     read commit_hash
# else
#   # Arguments were passed, so use them
#   version=$1
#   commit_hash=$2
# fi

# appname="chat-app"
# image_name="${appname}:v${version}"

# # Check if the Docker image already exists
# if docker inspect "$image_name" &>/dev/null; then
#     # Image exists
#     echo "Docker image $image_name already exists."

#     # Ask the user if they want to rebuild the image
#     echo "Do you want to rebuild the image? (yes/no)"
#     read rebuild_choice

#     if [ "$rebuild_choice" == "yes" ]; then
#         # Remove the existing image
#         docker rmi "$image_name"

#         # Build the Docker image
#         docker build -t "$image_name" .
#     else
#         echo "Using the existing image."
#     fi
# else
#     # Image does not exist, so build it
#     docker build -t "$image_name" .
# fi

# # Tag the image with the commit hash
# git tag "v${version}" "${commit_hash}"
# git push origin "v${version}"

# # Check if the image was pushed successfully
# if [ $? -ne 0 ]; then
#   echo "Error pushing image to GitHub"
#   exit 1
# fi

# # Success!
# echo "Image pushed to GitHub successfully"


#============================================
#============================================

#Modify deploy.sh that tagging and pushing to gitHub repo is now optional(Don’t forget to check if commit hash exists)
#!/bin/bash
#!/bin/bash

# Check if the script was passed any arguments
# if [ $# -eq 0 ]; then
#     # No arguments were passed, so prompt the user for them
#     # Get the version and commit hash from the user
#     echo "Enter the version number: "
#     read version
#     echo "Enter the commit hash: "
#     read commit_hash
# else
#     # Arguments were passed, so use them
#     version=$1
#     commit_hash=$2
# fi

# appname="chat-app"
# image_name="${appname}:${version}"

# # Check if the Docker image already exists
# if docker inspect "$image_name" &>/dev/null; then
#     # Image exists
#     echo "Docker image $image_name already exists."

#     # Ask the user if they want to rebuild the image
#     echo "Use the existing image  - [N|n] or rebuild and delete the existing one - [Y|y]" 
#     read rebuild_choice
#     if [[ "$rebuild_choice" == "y" || "$rebuild_choice" == "Y" ]]; then
#         # Remove the existing image
#         docker rmi "$image_name"
#         # Build the Docker image
#         docker build -t "$image_name" .
#     elif [[ "$rebuild_choice" == "n" || "$rebuild_choice" == "N" ]]; then
#         echo "Using the existing image."
#     else
#        echo "invalid input ---> using the existing image"    
#     fi
# else
#     # Image does not exist, so build it
#     docker build -t "$image_name" .
# fi
# # If a commit hash is provided, check if it exists
# if [ -n "$commit_hash" ] && ! git rev-parse --verify "$commit_hash" &>/dev/null; then
#     echo "Error: The specified commit hash does not exist."
#     exit 1
# fi

# # Ask the user if they want to tag and push to GitHub
# read -p "Do you want to tag and push to GitHub? enter [y|Y] if you want otherwise
# enter [n|N]: " push_choice
# if [[ "$push_choice" == "Y" || "$push_choice" == "y" ]]; then
#     # Tag the image with the commit hash
#     git tag "${version}" "${commit_hash}"
#     git push origin "${version}"

#     # Check if the image was pushed successfully
#     if [ $? -ne 0 ]; then
#         echo "Error pushing image to GitHub"
#         exit 1
#     fi
#     echo "Image pushed to GitHub successfully"
# elif [[ "$push_choice" == "N" || "$push_choice" == "n" ]]; then
#     echo "Tagging and pushing to GitHub skipped."
# else
#     # If the choice is neither 'Y' nor 'N', show a message
#     echo "Invalid choice ---> (not tagging and pushing to GitHub)."
# fi
