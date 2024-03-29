LOCAL_DIR=~/local
LOCAL_BIN="$LOCAL_DIR/bin"

# Section to install robbyrussell/oh-my-zsh
OH_MY_ZSH_DIR=~/.oh-my-zsh
DOT_ZSHRC=~/.zshrc
SHELL=`which zsh`
if [ ! -d "$OH_MY_ZSH_DIR" ]
then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  
  plugin_output="$(sed -n '/^plugin/p' $DOT_ZSHRC)"
  if [ ! -z $plugin_output ]
  then
    echo "plugins=(git ssh-agent)" >> $DOT_ZSHRC
  fi

  editor_output="$(sed -n '/^EDITOR/p' $DOT_ZSHRC)"
  if [ ! -z $editor_output ]
  then
    echo "EDITOR=vi" >> $DOT_ZSHRC
  fi
else
  echo "$OH_MY_ZSH_DIR exists!, I can not overwrite this automatically."
fi

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
curl https://raw.githubusercontent.com/3zcurdia/oh-my-config/main/Brewfile -o Brewfile
brew bundle install

GITCONFIG_DST=~/.gitconfig
GITCOFIG_REMOTE="https://raw.github.com/3zcurdia/oh-my-config/master/dotgitconfig"
if [ ! -f "$GITCONFIG_DST" ]
then
  curl -L $GITCONFIG_REMOTE -o $GITCONFIG_DST
else
  echo "$GITCONFIG_DST exists!, I can not overwrite this automatically."
fi
