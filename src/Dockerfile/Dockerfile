# ============================================
# Base Image
# ============================================
FROM ubuntu:22.04

# ============================================
# Build Arguments
# ============================================
ARG UNAME=pentester
ARG UID=1100
ARG GID=1100

# ============================================
# Environment Variables
# ============================================
ENV DEBIAN_FRONTEND=noninteractive
# Use ARG value for UNAME
ENV UNAME=${UNAME}
# Use ARG value for HOME
ENV HOME=/home/${UNAME}
# Use evaluated HOME for SCAN_OUTPUT_DIR
ENV SCAN_OUTPUT_DIR=${HOME}/reports
# Python specific ENV vars
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# ============================================
# Install Dependencies
# ============================================
# Consolidate apt installs and add dos2unix here
RUN apt update && apt install -y --no-install-recommends \
    sudo \
    wget \
    curl \
    net-tools \
    vim \
    gnupg \
    apt-transport-https \
    nmap \
    python3 \
    python3-pip \
    ruby \
    tshark \
    sqlmap \
    dirb \
    gobuster \
    nikto \
    cron \
    bash \
    dos2unix \
 && apt clean && rm -rf /var/lib/apt/lists/*

# ============================================
# Add User
# ============================================
RUN groupadd --gid "${GID}" "${UNAME}" && \
    useradd --uid "${UID}" --gid "${GID}" -ms /bin/bash "${UNAME}" && \
    echo "${UNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# ============================================
# Setup Application Directory & Python Dependencies
# ============================================
# Set workdir before copying files relative to user's home
# Note: HOME is now correctly evaluated based on the ENV var set above
WORKDIR ${HOME}

# Copy Python requirements file first for Docker layer caching
COPY requirements.txt .
# Ensure pip is up-to-date and install Python dependencies
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install --no-cache-dir -r requirements.txt

# ============================================
# Copy Application Scripts & Configs
# ============================================
# Copy the shell script containing functions (if your Python TUI calls it)
COPY entrypoint_functions.sh /usr/local/bin/shell_functions.sh
# Copy the main Python TUI application script
COPY tui_menu.py ${HOME}/tui_menu.py
# ADDED: Copy the custom bashrc file to the user's home directory
COPY custom_bashrc ${HOME}/.bashrc

# Convert shell scripts and bashrc to Unix format and make scripts executable
RUN dos2unix /usr/local/bin/shell_functions.sh && \
    chmod +x /usr/local/bin/shell_functions.sh && \
    chmod +x ${HOME}/tui_menu.py && \
    dos2unix ${HOME}/.bashrc # ADDED: Run dos2unix on the copied bashrc

# ============================================
# Setup Report Directory & Final Permissions
# ============================================
# Create directories and set permissions
# Note: SCAN_OUTPUT_DIR is now correctly evaluated
RUN mkdir -p "${SCAN_OUTPUT_DIR}"/logs "${SCAN_OUTPUT_DIR}"/screenshots "${SCAN_OUTPUT_DIR}"/vulnerabilities && \
    touch "${SCAN_OUTPUT_DIR}"/logs/exploit.log "${SCAN_OUTPUT_DIR}"/logs/recon.log "${SCAN_OUTPUT_DIR}"/logs/scan.log && \
    touch "${SCAN_OUTPUT_DIR}"/vulnerabilities/vulnerabilities.log && \
    # Ensure the user owns their entire home directory, including the new .bashrc
    chown -R ${UNAME}:${UNAME} ${HOME} 

# ============================================
# Switch to Non-root User
# ============================================
USER ${UNAME}
# WORKDIR is already ${HOME}

# ============================================
# CMD
# ============================================
# The Python TUI script is now the main command to run.
CMD ["python3", "tui_menu.py"]