# Prepare Ubuntu
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade

# Prepare Build Tools
=======================
# get superuser access.

sudo su

# install JDK (press enter 2 times).

add-apt-repository ppa:openjdk-r/ppa

# update all packages.

apt-get update

# install more packages.

apt-get install bison build-essential curl ccache flex lib32ncurses5-dev lib32z1-dev libncurses5-dev libsdl1.2-dev libxml2 libxml2-utils lzop pngcrush schedtool squashfs-tools xsltproc zip zlib1g-dev git-core make gperf openjdk-8-jdk -y

# become a normal user.

exit

# creating a bin folder.

mkdir ~/bin && PATH=~/bin:$PATH && cd ~/bin && curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

chmod a+x ~/bin/repo && git clone https://github.com/akhilnarang/scripts.git scripts && cd scripts && bash setup/android_build_env.sh
=================================

# Buka Directory
cd ~/nad-11

# Generate SSH
ssh-keygen -t ed25519 -C "703joko@gmail.com"

eval "$(ssh-agent -s)"

ssh-add ~/.ssh/id_ed25519
=========

# Initial git
git config --global user.email "703joko@gmail.com" && git config --global user.name "703joko"

# Sync Repo
repo init -u ssh://git@github.com/Nusantara-ROM/android.git -b 11
repo sync --force-sync --no-tags --no-clone-bundle

# Hapus Out
rm -rf out
rm -rf out/.lock

# Hapus Tree
rm -rf device/realme/RMX1971
rm -rf kernel/realme/RMX1971
rm -rf vendor/realme/RMX1971

# Hapus Qcom Power
rm -rf vendor/qcom/opensource/power

# Hapus Toolclain
rm -rf prebuilts/clang/host/linux-x86/clang-12

# Clone Tree 1
git clone https://github.com/NusantaraROM-Devices/device_realme_RMX1971.git -b R device/realme/RMX1971 && git clone https://github.com/703joko/Nusa_Kernel_realme_RMX1971 -b 11 kernel/realme/RMX1971 && git clone https://github.com/NusantaraROM-Devices/vendor_realme_RMX1971.git -b 11 vendor/realme/RMX1971

# Clone Tree 2
git clone https://github.com/NusantaraROM-Devices/device_realme_RMX1971.git -b R device/realme/RMX1971 && git clone https://github.com/LuckVii/kernel_realme_RMX1971.git -b 11 kernel/realme/RMX1971 && git clone https://github.com/NusantaraROM-Devices/vendor_realme_RMX1971.git -b 11 vendor/realme/RMX1971

# Clone Toolclain
git clone https://github.com/kdrag0n/proton-clang --depth=1 prebuilts/clang/host/linux-x86/clang-12

# Hals Display SDM845
git clone https://github.com/Nusantara-ROM/android_hardware_qcom_display -b 11-845 hardware/qcom-caf/sdm845/display

# Use Cache
export USE_CCACHE=1
ccache -M 150G

# Fix Hotspot
rm -rf hardware/qcom-caf/wlan
git clone https://github.com/SakilMondal/android_hardware_qcom-caf_wlan -b lineage-18.0 hardware/qcom-caf/wlan

# Neverallow
export SELINUX_IGNORE_NEVERALLOWS=true

# Build Rom
. build/envsetup.sh && lunch nad_RMX1971-userdebug
export KBUILD_BUILD_USER="jrInfected™"; export KBUILD_BUILD_HOST="jrmod.inc"
mka nad -j$(nproc --all)

# Hals 
sudo rm -R hardware/qcom-caf/sdm845/audio && sudo rm -R hardware/qcom-caf/sdm845/media && sudo rm -R hardware/qcom-caf/sdm845/display && git clone https://github.com/LineageOS/android_hardware_qcom_audio.git -b lineage-17.1-caf-sdm845 hardware/qcom-caf/sdm845/audio && cd hardware/qcom-caf/sdm845/audio && git fetch https://github.com/PotatoProject-next/hardware_qcom_audio.git d-staging1-caf-sdm845 && git cherry-pick 3dac2939b38b30addf6d4dbcf4410e6c4954fabf && cd && cd nad && git clone https://github.com/LineageOS/android_hardware_qcom_media.git -b lineage-17.1-caf-sdm845 hardware/qcom-caf/sdm845/media && git clone https://github.com/LineageOS/android_hardware_qcom_display.git -b lineage-17.1-caf-sdm845 hardware/qcom-caf/sdm845/display && cd hardware/qcom-caf/sdm845/display && git fetch https://github.com/PotatoProject-next/hardware_qcom_display.git d-staging1-caf-sdm845 && git cherry-pick 14998d0d45a6a54b6296c45732c11e256545ffb8^..2f8f16a825fea46b5497cbcdbf98ec6a5bae2e88 && cd && cd nad
