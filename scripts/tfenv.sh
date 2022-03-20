#!/usr/bin/env sh

set +x

export TFENV_CURL_OUTPUT=0

TFENV="${HOME}/.tfenv"
LOCAL_BIN="${HOME}/.local/bin/"
TFENV_VERSION="${1:-$(tfenv list-remote | head -n 1)}"
TERRAFORM_VERSION=$(terraform version 2> /dev/null | head -1 | awk -F"v" '{print $2}')

if [ "${TFENV_VERSION}" == "latest" ];
then
  TFENV_VERSION=$(tfenv list-remote | head -n 1)
fi

if [ ! -d "${TFENV}" ];
then
  git clone https://github.com/tfutils/tfenv.git "${TFENV}"
  mkdir -p "${LOCAL_BIN}"
  ln -s ${TFENV}/bin/* ${LOCAL_BIN}
  sh -c "which tfenv"
fi

if [ "$(tfenv list | grep "${TFENV_VERSION}")" = "" ];
then
  tfenv install "${TFENV_VERSION}"
fi

if [ "${TERRAFORM_VERSION}" != "${TFENV_VERSION}" ];
then
  tfenv use "${TFENV_VERSION}"
fi
