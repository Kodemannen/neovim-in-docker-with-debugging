#     _   _                      _            
#    | \ | |  ___   ___  __   __(_) _ __ ___  
#    |  \| | / _ \ / _ \ \ \ / /| || '_ ` _ \ 
#    | |\  ||  __/| (_) | \ V / | || | | | | |
#    |_| \_| \___| \___/   \_/  |_||_| |_| |_|
#
#     _           ____                _                
#    (_) _ __    |  _ \   ___    ___ | | __  ___  _ __ 
#    | || '_ \   | | | | / _ \  / __|| |/ / / _ \| '__|
#    | || | | |  | |_| || (_) || (__ |   < |  __/| |   
#    |_||_| |_|  |____/  \___/  \___||_|\_\ \___||_|   
#
#              _  _    _               _                _             
#   __      __(_)| |_ | |__     _ __  | | _   _   __ _ (_) _ __   ___ 
#   \ \ /\ / /| || __|| '_ \   | '_ \ | || | | | / _` || || '_ \ / __|
#    \ V  V / | || |_ | | | |  | |_) || || |_| || (_| || || | | |\__ \
#     \_/\_/  |_| \__||_| |_|  | .__/ |_| \__,_| \__, ||_||_| |_||___/ 
#                              |_|               |___/                



#-------------------------------------------------------------------------------
# Some standard docker-stuff:
#-------------------------------------------------------------------------------
FROM ubuntu:jammy
RUN apt-get update \
    && apt-get install -y wget curl htop python3-pip python3-venv git tmux 


#-------------------------------------------------------------------------------
# Install Neovim:
#-------------------------------------------------------------------------------
RUN : \
    && wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
    && chmod u+x nvim.appimage \
    && ./nvim.appimage --appimage-extract \
    && ln -s /squashfs-root/AppRun /usr/bin/nvim \
    && rm nvim.appimage


#-------------------------------------------------------------------------------
# Make a virtual environment that neovim will use for debugging:
#-------------------------------------------------------------------------------
RUN python3 -m venv .virtualenvs/debugpy
RUN . /.virtualenvs/debugpy/bin/activate && pip install debugpy
RUN pip3 install pynvim  \
    && ln -s /usr/bin/python3 /usr/bin/python



#-------------------------------------------------------------------------------
# Add a plugin-manager:
#-------------------------------------------------------------------------------
RUN : \
    && mkdir -p $HOME/.config/nvim/autoload \
    && curl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    -o $HOME/.config/nvim/autoload/plug.vim


#-------------------------------------------------------------------------------
# Add Neovim config:
#-------------------------------------------------------------------------------
ADD neovim-configs/plugins.vim /root/.config/nvim/init.vim


#-------------------------------------------------------------------------------
# Install the Neovim plugins:
#-------------------------------------------------------------------------------
RUN nvim --headless +PlugInstall +qa 



#-------------------------------------------------------------------------------
# Append more Neovim settings:
#-------------------------------------------------------------------------------
ADD neovim-configs/settings.vim /tmp/settings.vim
RUN cat /tmp/settings.vim >> /root/.config/nvim/init.vim && rm /tmp/settings.vim

#   - NOTE: If we have all the settings in the init.vim file when we run the 
#           PlugInstall command above, we get some warnings/issues, so we 
#           instead append the settings to it after



#-------------------------------------------------------------------------------
# Some preferences for the shell (optional):
#-------------------------------------------------------------------------------
RUN : \
    # Set Vi mode inside the docker terminal: \
    && echo "set -o vi" >> $HOME/.bashrc \
    # remove highlighting colors from folders (or something): \
    && echo export LS_COLORS="$LS_COLORS:ow=1:" >> $HOME/.bashrc 



CMD ["bash"]
