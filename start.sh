#!/bin/bash

# add user
if [ -z "${USER_ID}" -o -z "${USER_PASSWORD}" ]
then
    echo "USER_ID and USER_PASSWORD should be set as environment variables"
    exit 1
else
    useradd -m -d /home/${USER_ID} -G sudo -s /bin/bash ${USER_ID}
    echo "${USER_ID}:${USER_PASSWORD}" | chpasswd
fi

# change sshd_config
sed -i 's/#PasswordAuthentication/PasswordAuthentication/g' /etc/ssh/sshd_config
service ssh restart

# run script for toolchain installation
if [ -z "${SCRIPT_REPO_URL}" -o -z "${SCRIPT_FILE}" ]
then
    echo "SCRIPT_REPO_URL and SCRIPT_FILE env variables are needed!"
    exit 1
else
    curl -L ${SCRIPT_REPO_URL}/${SCRIPT_FILE} -o /tmp/${SCRIPT_FILE}
    chmod +x /tmp/${SCRIPT_FILE}
    /tmp/${SCRIPT_FILE}
fi

exec supervisord -n
