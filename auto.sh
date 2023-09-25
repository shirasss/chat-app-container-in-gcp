#!/bin/bash

script_folder="scripts"

print_options(){
    echo "Options:"
    echo "-i, --init   <Version> Build chat-app image with the version provided and run the chat-app container with mounted volumes"
    echo "-d, --delete <Version> Delete chat-app container and the specified chat-app image"
    echo "-e, --exec   Open a bash shell as root inside the chat-app container"
    echo "-de,--deploy <version> <commit-hash>"
    echo "Build, tag, and push the chat-app image with the specified tag to GCR and [OPTIONAL]tag and push the commit hash"
    echo "-p, --prune Prune all Docker resources"
    echo "-in, --info Show all Docker resources"
    exit 1
}

if [ $# -eq 0 ]; then
   print_options
fi

while [ $# -gt 0 ]; do
    case "$1" in 
        -i|--init)
            if [ -n "$2" ]; then
                echo "Running init.sh with version $2"
                ./${script_folder}/init.sh "$2"
                exit 0  # Exit with success
            else
                ./${script_folder}/init.sh
                exit 0  # Exit with success
            fi
            ;;
        -d|--delete)
            if [ -n "$2" ]; then
                echo "Running delete.sh with version $2"
                ./${script_folder}/delete.sh "$2"
                exit 0  # Exit with success
            else
                ./${script_folder}/delete.sh
                exit 0  # Exit with success
            fi
            ;;
        -e|--exec)
            echo "Opening a bash shell as root inside the chat-app container"
            # Add your command to open a bash shell here
            docker exec -it chat-app-run bash
            exit 0  # Exit with success
            ;;
        -de|--deploy)
            if [ -n "$2" ] && [ -n "$3" ]; then
                echo "Building, tagging, and pushing chat-app image with tag $2 to GCR."
                echo "Optional: Tag and push commit hash $3"
                ./${script_folder}/deploy.sh $2 $3
                exit 0  # Exit with success
            else
                ./${script_folder}/deploy.sh
                exit 0  # Exit with success
            fi
            ;;
        -p|--prune)
            echo "Running prune.sh"
            ./${script_folder}/prune.sh
            exit 0  # Exit with success
            ;;
        -in|--info)
            echo "Running info.sh"
            ./${script_folder}/info.sh
            exit 0  # Exit with success
            ;;
        *)
            echo "Error: Unknown option $1"
            print_options
            ;;
    esac
done
