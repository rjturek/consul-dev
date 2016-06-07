#!/usr/bin/env bash

# Wait for cloud-init to do it's thing
timeout 180 /bin/bash -c \
  "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done"

# Literally throw away everything cloud-init has done
echo "Cleaning apt-cache..."
sudo rm -rf /var/lib/apt/lists/* &>/dev/null
sudo apt-get -y clean &>/dev/null

echo "Updating apt-cache..."
sudo apt-get update &>/dev/null
#!/usr/bin/env bash
set -e

command -v jq &>/dev/null || {
  echo "Installing jq..."
  sudo apt-get -yqq update &>/dev/null
  sudo apt-get -yqq install jq &>/dev/null
}
#!/usr/bin/env bash
set -e

command -v docker &>/dev/null || {
  echo "Installing Docker..."
  sudo apt-get -yqq update &>/dev/null
  sudo apt-get -yqq install docker.io &>/dev/null
}
#!/usr/bin/env bash
set -e


echo "Disabling checkpoint..."
sudo tee /etc/profile.d/checkpoint.sh > /dev/null <<"EOF"
export CHECKPOINT_DISABLE=1
EOF

echo "Setting default Vault HTTP_ADDR..."
sudo tee /etc/profile.d/vault.sh > /dev/null <<"EOF"
export VAULT_ADDR=http://127.0.0.1:8200
EOF

echo "Setting default prompt..."
sudo tee /etc/profile.d/ps1.sh > /dev/null <<"EOF"
export PS1="\u@\h $ "
EOF
for d in /home/*; do
  if [ -d "$d" ]; then
    sudo tee -a $d/.bashrc > /dev/null <<"EOF"
export PS1="\u@\h $ "
EOF
  fi
done

source /etc/profile
#!/usr/bin/env bash
set -e

export DEBIAN_FRONTEND=noninteractive
export DEBIAN_PRIORITY=critical

command -v git &>/dev/null || {
  echo "Installing Git..."
  sudo apt-get -yqq update &>/dev/null
  sudo apt-get -yqq install git-core &>/dev/null

  echo "Configuring Git..."
  git config --global color.ui true
  git config --global user.name "Change Me"
  git config --global user.email "ChangeMe@Wherever.com<mailto:ChangeMe@Wherever.com>"
}
#!/usr/bin/env bash
set -e

function install_tool() {
  local TOOL="${TOOL:-$1}"
  if [ -z $TOOL ]; then
    echo "Please specify a tool!"
    exit 1
  fi

  local VERSION="${VERSION:-$2}"
  if [ -z $VERSION ]; then
    echo "Please specify a version!"
    exit 1
  fi

  command -v "/usr/local/bin/${TOOL}" &>/dev/null && "/usr/local/bin/${TOOL}" -v | grep -q "${VERSION}" &>/dev/null && {
    echo "${TOOL} (v${VERSION}) already installed!"
    return
  }

  command -v curl &>/dev/null || {
    echo "Installing curl for downloads..."
    sudo apt-get -yqq update &>/dev/null
    sudo apt-get -yqq install curl &>/dev/null
  }

  command -v unzip &>/dev/null || {
    echo "Installing unzip for tools..."
    sudo apt-get -yqq update &>/dev/null
    sudo apt-get -yqq install unzip &>/dev/null
  }

  echo "Downloading ${TOOL} (v${VERSION})..."
  curl -so "${TOOL}.zip" "https://releases.hashicorp.com/${TOOL}/${VERSION}/${TOOL}_${VERSION}_linux_amd64.zip"

  echo "Installing ${TOOL} ${VERSION}..."
  unzip "${TOOL}.zip" &>/dev/null
  rm "${TOOL}.zip"
  sudo mv ${TOOL}* /usr/local/bin/
  sudo chmod +x /usr/local/bin/$TOOL*

  echo "Successfully installed ${TOOL} (v${VERSION})!"
}

# If args were given to this script directly, assume the user meant to install
# the tool.
if [ ! -z $1 ]; then
  install_tool $1 $2
fi
#!/usr/bin/env bash
set -e

install_tool "consul" "0.6.4"
install_tool "consul-replicate" "0.2.0"
install_tool "consul-template" "0.14.0"
install_tool "envconsul" "0.6.1"
install_tool "nomad" "0.3.2"
install_tool "packer" "0.10.1"
install_tool "serf" "0.7.0"
install_tool "terraform" "0.6.16"

echo Success! Please logout and re-login or run:
echo    $ source /etc/profile
