#!/bin/bash
set -e

echo "#################################################"
echo "Starting ${GITHUB_WORKFLOW}:${GITHUB_ACTION}"

# Available env
# echo "INPUT_HOST: ${INPUT_HOST}"
# echo "INPUT_PORT: ${INPUT_PORT}"
# echo "INPUT_USER: ${INPUT_USER}"
# echo "INPUT_PASS: ${INPUT_PASS}"
# echo "INPUT_KEY: ${INPUT_KEY}"
# echo "INPUT_RUN: ${INPUT_RUN}"
# echo "INPUT_SRC: ${INPUT_SRC}"
# echo "INPUT_DIST: ${INPUT_DIST}"

CMD="${INPUT_RUN/$'\n'/' && '}"

if [ -z "$INPUT_KEY" ] # Password
then
    echo "Using password"
    export SSHPASS=$PASS
    sshpass -e scp $INPUT_SRC -o StrictHostKeyChecking=no -p $INPUT_PORT $INPUT_USER@$INPUT_HOST:$INPUT_DIST

else # Private key
    echo "Using private key"
    pwd
    mkdir "/root/.ssh"

    echo "$INPUT_KEY" > "/root/.ssh/id_rsa"
    chmod 400 "/root/.ssh/id_rsa"

    echo "Host *" > "/root/.ssh/config"
    echo "  AddKeysToAgent yes" >> "/root/.ssh/config"
    echo "  IdentityFile /root/.ssh/id_rsa" >> "/root/.ssh/config"

    cat "/root/.ssh/config"

    ls -lha "/root/.ssh/"
    # sshpass ssh -v -o StrictHostKeyChecking=no -p $INPUT_PORT $INPUT_USER@$INPUT_HOST "$CMD"
    sshpass scp $INPUT_SRC -o StrictHostKeyChecking=no -p $INPUT_PORT $INPUT_USER@$INPUT_HOST:$INPUT_DIST

fi

echo "#################################################"
echo "Completed ${GITHUB_WORKFLOW}:${GITHUB_ACTION}"
