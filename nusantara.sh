# Buka Directory
cd ~/nusantara

# Sync Repo
repo init -u ssh://git@github.com/Nusantara-ROM/android.git -b 11
repo sync --force-sync --no-tags --no-clone-bundle

# Hapus Out
rm -rf out
rm -rf out/.lock

# Hapus Tree
rm -rf device/xiaomi/santoni
rm -rf kernel/xiaomi/msm8937
rm -rf vendor/xiaomi

# Hapus Qcom Power
rm -rf vendor/qcom/opensource/power

# Hapus Toolclain
rm -rf prebuilts/clang/host/linux-x86/clang-12

# Clone Tree
git clone https://github.com/NusantaraROM-Devices/device_xiaomi_santoni.git -b 11 device/xiaomi/santoni
git clone https://github.com/zhantech/android_kernel_xiaomi_santoni.git -b luuvy-4.9 kernel/xiaomi/msm8937
git clone https://github.com/NusantaraROM-Devices/vendor_xiaomi_santoni.git -b 11 vendor/xiaomi/

# Clone Toolclain
git clone https://github.com/kdrag0n/proton-clang --depth=1 prebuilts/clang/host/linux-x86/clang-12

# Use Cache
export USE_CCACHE=1
ccache -M 150G

# Build Rom
. build/envsetup.sh
lunch nad_santoni-userdebug
export KBUILD_BUILD_USER="ZHANtech™"; export KBUILD_BUILD_HOST="batikholic"
mka nad -j40
