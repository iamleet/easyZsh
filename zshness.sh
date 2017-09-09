# Install zsh ohmyzsh zgen and awesomefonts
# being everything is already installed on my system some results may vary..

date "+DATE: %Y-%m-%d%nTIME: %H:%M:%S"
version=${1:-latest}
day=`date +%Y-%m-%d`
time=`date +%H:%M:%S`
logFile="$day-easyDocker.log"
zshrc="zshrc"
touch ~/.zshrc
function logConfig()
{
  mkdir ./logs || echo "$time - Directory already exist..."
  echo "$time - Log directory created! It starts..." >> ./logs/$logFile
  # Can use this section to check if another installation has happened and take action
}


function banner {
    # Show random banner because 1337
    b=$(( ( RANDOM % 1 ) + 1 ))
    case "$b" in
        1)
        echo '              _                 _            '
        echo '        | | _(_)_ __  _   _  __| | _____   __'
        echo '        | |/ / |  _ \| | | |/ _` |/ _ \ \ / /'
        echo '        |   <| | |_) | |_| | (_| |  __/\ V / '
        echo '        |_|\_\_| .__/ \__,_|\__,_|\___| \_/  '
        echo '               |_|                           '
        echo "Updating the heck out of your shell"
        ;;
        2)
        echo '               _                            _ _      '
        echo '         | | _(_)_ __  _   _ ___| |__   ___| | |____ '
        echo '         | |/ / |  _ \| | | / __|  _ \ / _ \ | |_  / '
        echo '         |   <| | |_) | |_| \__ \ | | |  __/ | |/ /  '
        echo '         |_|\_\_| .__/ \__,_|___/_| |_|\___|_|_/___| '
        echo '               |_|                                   '
        ;;
    esac
}

addAwesomefont()
{
  echo "$time - Adding awesomefont for cmd symbols..." >> ./logs/$logFile
  brew install python || echo "$time - Python already installed..." >> ./logs/$logFile
  pip install --user powerline-status
  echo "$time - Fonts ready..." >> ./logs/$logFile
}

generateConfig()
{
  mv ~/.zshrc ~/.zshrc.bak
  echo "$time - Backed up the default zshrc file..." >> ./logs/$logFile
  echo "USERNAME=$USERNAME" >> ~/.$zshrc
  echo "AWS_DEFAULT_PROFILE=" >> ~/.$zshrc
  echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.$zshrc
  echo '. "/usr/local/opt/nvm/nvm.sh"' >> ~/.$zshrc
  echo " #Theme it up - adjust the look and feel" >> ~/.$zshrc
  echo ' POWERLEVEL9K_MODE='awesome-patched'' >> ~/.$zshrc
  echo ' ZSH_THEME="powerlevel9k/powerlevel9k"' >> ~/.$zshrc
  echo ' POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator dir vcs aws)' >> ~/.$zshrc
  echo ' POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time rvm rbenv nvm background_jobs virtualenv)' >> ~/.$zshrc
  echo ' POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="↳ "' >> ~/.$zshrc
  echo ' POWERLEVEL9K_PROMPT_ON_NEWLINE=true' >> ~/.$zshrc
  echo ' POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="\n"' >> ~/.$zshrc
  echo ' POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S \uE868  %d.%m.%y}"' >> ~/.$zshrc
  echo ' POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="%K{white}%F{black} $POWERLEVEL9K_TIME_FORMAT%f%k%F{white}%f "' >> ~/.$zshrc
  echo ' POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0' >> ~/.$zshrc
  echo ' POWERLEVEL9K_ALWAYS_SHOW_USER=false' >> ~/.$zshrc
  echo ' POWERLEVEL9K_NVM_BACKGROUND="238"' >> ~/.$zshrc
  echo ' POWERLEVEL9K_NVM_FOREGROUND="green"' >> ~/.$zshrc
  echo '  # === ZGEN stuff ===' >> ~/.$zshrc
  echo '   if [ !  -f ~/.zgen/zgen.zsh ]; then' >> ~/.$zshrc
  echo '      echo "Zgen not found, bootstrapping."' >> ~/.$zshrc
  echo '      mkdir -p ~/.zgen' >> ~/.$zshrc
  echo '      curl -L https://raw.githubusercontent.com/tarjoilija/zgen/master/zgen.zsh > ~/.zgen/zgen.zsh' >> ~/.$zshrc
  echo '  fi' >> ~/.$zshrc
  echo '  source ~/.zgen/zgen.zsh' >> ~/.$zshrc
  echo '  if ! zgen saved; then' >> ~/.$zshrc
  echo '    # Bootstrap fonts' >> ~/.$zshrc
  echo '    # Load skwp theme, in case powerlevel9k doesnt work.' >> ~/.$zshrc
  echo '    zgen prezto prompt theme 'skwp'' >> ~/.$zshrc
  echo '    zgen prezto syntax-highlighting color 'yes'' >> ~/.$zshrc
  echo '    # prezto and modules' >> ~/.$zshrc
  echo '    zgen prezto' >> ~/.$zshrc
  echo '  # zgen prezto git' >> ~/.$zshrc
  echo '  # zgen prezto command-not-found' >> ~/.$zshrc
  echo '    zgen prezto syntax-highlighting' >> ~/.$zshrc
  echo '    zgen prezto history-substring-search' >> ~/.$zshrc
  echo '    zgen prezto completion' >> ~/.$zshrc
  echo '  #   zgen prezto fasd' >> ~/.$zshrc
  echo '    zgen load tarruda/zsh-autosuggestions' >> ~/.$zshrc
  echo '    if [[ ! $TERM =~ linux ]];' >> ~/.$zshrc
  echo '    then' >> ~/.$zshrc
  echo '      zgen load bhilburn/powerlevel9k powerlevel9k.zsh-theme' >> ~/.$zshrc
  echo '    fi' >> ~/.$zshrc
  echo '    prompt skwp' >> ~/.$zshrc
  echo 'fi' >> ~/.$zshrc
  echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> ~/.$zshrc
  echo "$time - .zshrc created!" >> ./logs/$logFile
}

installZsh()
{
  brew install zsh zsh-completions ||   echo "$time - Installing zsh failed via Brew" >> ./logs/$logFile
  echo "$time - Installing zsh successful via Brew..." >> ./logs/$logFile
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"  ||   echo "$time - Installing ohmyzsh failed via curl" >> ./logs/$logFile
  echo "$time - Installing ohmyzsh successful via curl..." >> ./logs/$logFile
}

installZgen()
{
  git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen" ||   echo "$time - Installing zgen failed via git" >> ./logs/$logFile
  echo "$time - Installing ohmyzsh successful via curl..." >> ./logs/$logFile
}

echo "Installing zsh and stuff..." >> ./logs/$logFile
banner
installZsh
installZgen
addAwesomefont
generateConfig
echo "Succesfully installed zsh and stuff..." >> ./logs/$logFile
