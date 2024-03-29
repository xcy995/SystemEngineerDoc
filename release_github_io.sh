#!/bin/bash

# 将文件同步到 GitHub Pages 仓库中
# 请将以下路径替换为您的 GitHub Pages 仓库路径

REPO_PATH="/home/yyf/workspace/xcy995-github-io"

# 使用 rsync 命令将文件同步到 GitHub Pages 仓库中
# 您可以根据需要修改路径和同步的文件

rsync -avcz --progress --delete ./css ./fonts ./images ./js "$REPO_PATH/seia/"
rsync -avcz --progress 系统工程师文档.html "$REPO_PATH/seia/index.html"

