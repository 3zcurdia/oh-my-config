LOCAL_DIR=~/local
LOCAL_BIN="$LOCAL_DIR/bin"

# Section to install robbyrussell/oh-my-zsh
OH_MY_ZSH_DIR=~/.oh-my-zsh
DOT_ZSHRC=~/.zshrc
OH_MY_ZSH_REMOTE="https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh"
SHELL=`which zsh`
if [ ! -d "$OH_MY_ZSH_DIR" ]
then

  curl -L $OH_MY_ZSH_REMOTE | sh

  plugin_output="$(sed -n '/^plugin/p' $DOT_ZSHRC)"
  if [ ! -z $plugin_output ]
  then
    echo "plugins=(git rails3 textmate ruby bundler lol github gem ssh-agent cap osx mysql-macports macports)" >> $DOT_ZSHRC
  fi

  editor_output="$(sed -n '/^EDITOR/p' $DOT_ZSHRC)"
  if [ ! -z $editor_output ]
  then
    echo "EDITOR=vim" >> $DOT_ZSHRC
  fi

  if [ -z "$(chsh -s $SHELL)" ]
  then
    echo "SHELL has been changed to $SHELL"
  fi

else
  echo "$OH_MY_ZSH_DIR exists!, I can not overwrite this automatically."
fi

# Section to set tmux configuration files

# Section to install rvm
RVM_DIR=~/.rvm
RVM_REMOTE="get.rvm.io"
RUBY_VERSION="1.9.3-p327"

if [ ! -d "$RVM_DIR" ]
then
  curl -L $RVM_REMOTE | bash -s stable

  rvm_output="$(sed -n '/rvm\/scripts\/rvm/p' $DOT_ZSHRC)"
  if [ ! -z $rvm_output ]
  then
    echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> $DOT_ZSHRC
  fi

  source "$HOME/.rvm/scripts/rvm"

  rvm --skip-autoreconf pkg install readline
  rvm --skip-autoreconf pkg install iconv
  rvm pkg install zlib
  rvm pkg install openssl
  rvm pkg install autoconf 
  rvm install $RUBY_VERSION 
  rvm use $RUBY_VERSION --default
  gem install bundler
  gem install rake
  gem install certified

  tmuxinator_output="$(sed -n '/\.tmuxinator\/scripts\/tmuxinator/p' $DOT_ZSHRC)"
  if [ ! -z $tmuxinator_output ]
  then
    echo '[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator' >> $DOT_ZSHRC
  fi

else
  echo "$RVM_DIR exists!, I can not overwrite this automatically."
fi

GITCONFIG_DST=~/.gitconfig
GITCOFIG_REMOTE="https://raw.github.com/3zcurdia/oh-my-config/master/dotgitconfig"
if [ ! -f "$GITCONFIG_DST" ]
then
  curl -L $GITCONFIG_REMOTE -o $GITCONFIG_DST
else
  echo "$GITCONFIG_DST exists!, I can not overwrite this automatically."
fi
