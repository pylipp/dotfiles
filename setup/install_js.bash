#!/usr/bin/env bash

# List available versions: nvm ls-remote --lts
nvm install v16.17.0

npm install -g yarn

yarn config set prefix ~/.local
yarn global add trello-cli
