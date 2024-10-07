IMAGE_NAME="downloader"
CONTAINER_NAME="downloader"

if ! [ -z "$1" ]; then
    YOUTUBE_URL=$1
fi

printf "Download YouTube Song\n\n"

if [ -z "${YOUTUBE_URL}" ]; then
    printf "A YouTube url must be passed in!\n"
    printf "Usual format: https://www.youtube.com/watch\?v\=<youtube_id>\n"
    printf "\n"
    exit -1
fi

if [ -z "${DOWNLOAD_FOLDER}" ]; then
    DOWNLOAD_FOLDER="./downloaded_files"
fi

# NOTE: If the folder does not exist on the host docker run 
#       will create it
# if ! [ -d "${DOWNLOAD_FOLDER}" ]; then
#     printf "\n"
#     printf "Creating download folder: ${DOWNLOAD_FOLDER}"
#     mkdir ${DOWNLOAD_FOLDER}
# fi

printf "\n"
printf "Downloading YouTube Song from: ${YOUTUBE_URL}\n"
printf "    mp3 file will be created in this folder: ${DOWNLOAD_FOLDER}\n"
printf "\n"
printf "Checking docker container: ${CONTAINER_NAME}\n"
CONTAINER=$(docker ps -qa -f name=${CONTAINER_NAME})

if ! [ -z "${CONTAINER}" ]; then
    printf "    Container ${CONTAINER} with this name already exists. Removing it now...\n"
    docker rm -f ${CONTAINER}
    printf "    Removed.\n"
fi

printf "\n"
printf "Building the docker image (${IMAGE_NAME})...\n\n"
docker build . --tag ${IMAGE_NAME}

printf "\n"
printf "Running container ${CONTAINER_NAME}...\n\n"

docker run \
    --env YOUTUBE_URL=${YOUTUBE_URL} \
    --name ${CONTAINER_NAME} \
    --rm \
    -v ${DOWNLOAD_FOLDER}:/downloaded_files \
    ${IMAGE_NAME}

printf "\n"
printf "Downloaded File: \n"
ls -las ${DOWNLOAD_FOLDER}
