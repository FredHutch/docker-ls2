FROM fredhutch/fredhutch-ubuntu:16.04-20171009

# OS packages
#   libibverbs-dev is required my easybuild (openmpi) and must be provided by the OS
#   libssl-dev is commonly pulled from OS to keep up to date for security patches
RUN apt-get update && apt-get install -y \
    lua5.2 \
    lua-posix \
    lua-filesystem \
    lua-term \
    libibverbs-dev \
    libssl-dev

# set up our user
RUN useradd -ms /bin/bash neo
USER neo
WORKDIR /home/neo
SHELL ["/bin/bash", "-c"]

# set up Lmod (newer version than Ubuntu repos provide
RUN LMOD_VER="7.7.3"; curl -L -o Lmod-${LMOD_VER}.tar.gz https://github.com/TACC/Lmod/archive/${LMOD_VER}.tar.gz && \
    tar -xzf Lmod-${LMOD_VER}.tar.gz && \
    cd Lmod-${LMOD_VER} && \
    ./configure --prefix=/home/neo/.local --with-tcl=no && \
    make install && \
    cd .. && \
    rm -r Lmod-${LMOD_VER} && \
    rm Lmod-${LMOD_VER}.tar.gz
COPY start_lmod /home/neo/.start_lmod
ENV BASH_ENV=/home/neo/.start_lmod

# set up easybuild
ENV EASYBUILD_PREFIX=/home/neo/.local/easybuild
ENV EASYBUILD_MODULES_TOOL=Lmod
ENV EASYBUILD_MODULE_SYNTAX=Lua
ENV EASYBUILD_ROBOT_PATHS=:/home/neo/.local/fh_easyconfigs
RUN curl -O https://raw.githubusercontent.com/easybuilders/easybuild-framework/develop/easybuild/scripts/bootstrap_eb.py && python bootstrap_eb.py $EASYBUILD_PREFIX && rm bootstrap_eb.py

# ugly hack as dockerhub autobuild doesn't support git lfs and Oracle removed old Java downloads
RUN mkdir /home/neo/.local/easybuild/sources
COPY sources/* /home/neo/.local/easybuild/sources/
RUN cd /home/neo/.local/easybuild/sources/ && \
    cat jdk-8u92-linux-x64a* >> jdk-8u92-linux-x64.tar.gz && \
    rm jdk-8u92-linux-x64a*

# install easybuild software
COPY easybuild-life-sciences/fh_easyconfigs/*.eb /home/neo/.local/fh_easyconfigs/
RUN ml EasyBuild && eb foss-2016b.eb --robot
