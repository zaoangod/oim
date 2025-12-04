#!/usr/bin/env bash

# 脚本执行时若任何命令返回非 0 状态码（执行失败），则立即终止脚本
set -e

# 设置代理
export http_proxy=http://127.0.0.1:7890
export https_proxy=http://127.0.0.1:7890

base_directory=$(pwd)

rime_version=1.15.0
rime_git_hash="75bc43a"

# rime
rime_archive="rime-${rime_git_hash}-macOS-universal.tar.bz2"
rime_download_url="https://github.com/rime/librime/releases/download/${rime_version}/${rime_archive}"

# rime_deps
rime_deps_archive="rime-deps-${rime_git_hash}-macOS-universal.tar.bz2"
rime_deps_download_url="https://github.com/rime/librime/releases/download/${rime_version}/${rime_deps_archive}"

echo "---------start download lib---------"
rime_directory="${base_directory}/library/download/rime"
rime_deps_directory="${base_directory}/library/download/rime_deps"

echo "base_directory: ${base_directory}"
echo "rime_directory: ${rime_directory}"
echo "rime_deps_directory: ${rime_deps_directory}"

mkdir -p ${rime_directory}
cd ${rime_directory}
echo "-> download ${rime_archive}: ${rime_download_url}"
curl -# -LO "${rime_download_url}"
tar --bzip2 -xf "${rime_archive}"

mkdir -p ${rime_deps_directory}
cd ${rime_deps_directory}
echo "-> download ${rime_deps_archive}: ${rime_deps_download_url}"
curl -# -LO "${rime_deps_download_url}"
tar --bzip2 -xf "${rime_deps_archive}"


mkdir -p ${base_directory}/library/rime/share/
cp -R ${rime_directory}/dist ${base_directory}/library/rime/
cp -R ${rime_deps_directory}/share/opencc ${base_directory}/library/rime/share/

# 跳过构建 librime 和 opencc 数据，使用下载的二进制文件
make copy-rime-binary copy-opencc-data

# git submodule update --init plum

# rime_dir=plum/output bash plum/rime-install ${SQUIRREL_BUNDLED_RECIPES}
# make copy-plum-data
