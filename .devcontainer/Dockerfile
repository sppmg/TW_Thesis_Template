FROM qmcgaw/latexdevcontainer:latest-full
# KEYNOTE: Very likely everything is set up with `USER root` in `FROM qmcgaw/latexdevcontainer:latest`.

RUN apt-get update && apt-get -y install \
    libfontconfig libfontconfig1 \
    # libfontconfig1 is for ... I don't know. But without it, my LaTeX compliation failed
    ghostscript \
    # ghostscript for handling eps image files
    curl \
    bash-completion\
    # # This fix the annoying chktex warning
    # Which is equivalently in bash,
    # 1. apt-get install chktex
    # 2. cp /usr/bin/chktex /usr/local/bin/chktex
    # Noted that `COPY /usr/bin/chktex /usr/local/bin/chktex` will fail due to "no such file or directory: /usr/bin/chktex"
    chktex && \
    cp /usr/bin/chktex /usr/local/bin/chktex


# Install Fonts for CJK supports
# in order to use `fc-cache -f -v` and `fc-list :lang=zh`, `fontconfig` is required
# - `fc-cache -f -v`: (copy font files to /usr/share/fonts/ and Update Font Cache)
# - `fc-list :lang=zh`: List all chinese font available
RUN apt update && apt install \
    fontconfig \
    fonts-noto-cjk \
    fonts-arphic-uming \
    fonts-arphic-ukai

## Only root can chmod files/directories that are accessible only to root
USER root


## Copy the file ".devcontainer/fix-permissions" to local machine for later call
# - also see https://www.cnblogs.com/sparkdev/p/9573248.html for "building context"
COPY fix-permissions /usr/local/bin/fix-permissions
RUN chmod a+rx /usr/local/bin/fix-permissions


ARG NB_USER="jovyan"
ARG NB_UID="1000"
ARG NB_GID="100"

ARG VSCODE_PATH="/home/jovyan/.vscode-server/"

ARG WORKSPACE_DIR="/workspace/dir/defined/in/docker-compose/yml"
ARG SUB_PROJECT_DIR="/workspace/dir/defined/in/docker-compose/yml"
ARG HOME=/home/$NB_USER

ARG PSWD="1234"
## Configure environment
ENV NB_USER=$NB_USER \
    NB_UID=$NB_UID \
    NB_GID=$NB_GID\
    WORKSPACE_DIR=$WORKSPACE_DIR\
    HOME=$HOME\
    PSWD=$PSWD\
    SUB_PROJECT_DIR=$SUB_PROJECT_DIR \
    VSCODE_PATH=${VSCODE_PATH}

RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER

## Change (set) password: Use the password 1234 to switch to root if you'd like to install other things
# A user cannot use sudo if he has no password set
# See https://stackoverflow.com/questions/2150882/how-to-automatically-add-user-account-and-password-with-a-bash-script
RUN echo $NB_USER:$PSWD | chpasswd
RUN echo root:$PSWD | chpasswd



## Copy starship configuration for later use
COPY starship.toml /$HOME/.config/starship.toml
## If there is git-completion.bash, you should use it
# - this makes auto-completion after `git branch ...` works properly
# - Requirement: git-completion.bash; see below `RUN ... curl ... git-completion.bash`.
# - zsh seems natively supports auto completion. See https://apple.stackexchange.com/a/55886
COPY .bash_profile /$HOME/.bash_profile

## Fix permissions for NB_USER
# ERROR will occur if:
# - Without `chown $NB_USER:$NB_GID /home/$NB_USER`, subdirectories for vscode cannot be created because "/home/$NB_USER" is created and only owned by root.
RUN chown $NB_USER:$NB_GID $WORKSPACE_DIR && \
    chown $NB_USER:$NB_GID /usr/local/bin && \
    fix-permissions $WORKSPACE_DIR && \
    fix-permissions /home/$NB_USER && \
    # or `chown $NB_USER:$NB_GID /home/$NB_USER`
    fix-permissions /usr/local/bin
# in order to install starship

## Switch to user
USER $NB_UID
WORKDIR $WORKSPACE_DIR

# Set up Vscode extensions
RUN rm -rf $VSCODE_PATH
RUN mkdir -p $VSCODE_PATH/extensions \
    $SUB_PROJECT_DIR \
    && chown -R $NB_USER:$NB_GID \
    $VSCODE_PATH


## Install Starship and git-auto completion
RUN curl -fsSL https://starship.rs/install.sh | sh -s -- -y \
    && echo 'eval "$(starship init bash)"' >> ~/.bashrc \
    && mkdir -p ~/.config \
    # auto completion for git: https://ithelp.ithome.com.tw/articles/10227698
    && curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.sh
