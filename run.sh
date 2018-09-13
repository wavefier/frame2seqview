#!/bin/bash 

IMAGE_NAME=frame2seqview
IMAGE_VER=0.0.1
BASEPATH=$(pwd)


${DOCKER} info > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FATAL : Unable to talk to the docker daemon"
  exit 3
fi

function check_images_presence {
  if [[ "$(docker images -q ${IMAGE_NAME}:${IMAGE_VER} 2> /dev/null)" == "" ]]; then
      echo "WARNING: Immage not found, I will build it"
      build_image
  fi
}

function run_image() {
    check_images_presence

    docker run -it --rm \
        -v ${BASEPATH}/app:/adapter \
        -v ${BASEPATH}/data/export:/export \
        -v ${BASEPATH}/data/import:/import \
        ${IMAGE_NAME}:${IMAGE_VER} /bin/bash
}

function build_image() {
    docker build -t  ${IMAGE_NAME}:${IMAGE_VER} .
}


function help {
    echo "USAGE: run.sh <THING>"
    echo ""
    echo "THING is one of this:"
    echo "  -sh, bash               Bash"
    echo "  -bi, build_image        Build Immage"

}

case "$1" in
  -sh | bash)
    echo "This task run a bash on build environments"
    check_images_presence
    run_image
    ;;
  -bi | build_image)
    echo "This task run build  the image"
    build_image
    ;;
  *)
    help
    ;;
esac
