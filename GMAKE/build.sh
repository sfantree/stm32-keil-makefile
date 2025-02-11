set -ex
pushd $HOME
echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf
echo "APT::Acquire::Retries \"10\";" > /etc/apt/apt.conf.d/80-retries
echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes
echo "APT::Get::AllowUnauthenticated \"true\";" > /etc/apt/apt.conf.d/91unauthenticated

apt-get -qq -y update || true
apt-get -qq -y install wget curl vim cmake make gcc g++ automake pkg-config libc6-dev libunwind-dev openssl git unzip zip build-essential libssl-dev zlib1g-dev autoconf flex bison gperf libsqlite3-dev libicu-dev libncurses-dev lib32c-dev lib32z1 lib32stdc++6 dpkg-dev || true
apt-get -qq -y install jq iproute2 iputils-ping file xz-utils || true
apt-get -qq -y install python3-virtualenv gcc-arm-none-eabi  || true

git clone --depth 1 https://github.com/sfantree/stm32-keil-makefile.git
pushd stm32-keil-makefile/GMAKE
make
zip /tmp/main.zip main.*
popd #$gmake

echo "deb [ allow-insecure=yes ]  https://download.mono-project.com/repo/debian stable-buster main" | tee /etc/apt/sources.list.d/mono-official-stable.list

apt-get -qq -y update || true
apt-get -qq -y install mono-complete || true
wget -q https://github.com/renode/renode/releases/download/v1.15.3/renode_1.15.3_amd64.deb
apt-get -qq -y install ./renode_1.15.3_amd64.deb || true

pushd stm32-keil-makefile/GMAKE
timeout 180 renode --disable-gui --console -e "s @stm32f103.mod.resc" || true
popd #$gmake

popd #$home