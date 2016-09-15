#!/bin/bash
if [ ! -r ~/.oh-my-zsh ]; then
  curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
else
  echo 'oh-my-zsh already installed'
fi
