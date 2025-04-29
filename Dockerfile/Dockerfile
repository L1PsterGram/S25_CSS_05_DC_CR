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

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV UNAME=pentester
ENV HOME=/home/$UNAME
ENV SCAN_OUTPUT_DIR=$HOME/reports

# ============================================
# Install Dependencies
# ============================================
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
 && apt clean && rm -rf /var/lib/apt/lists/*

# ============================================
# Add User
# ============================================
RUN groupadd --gid "$GID" "$UNAME" && \
    useradd --uid "$UID" --gid "$GID" -ms /bin/bash "$UNAME" && \
    echo "$UNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# ============================================
# Setup Report Directory
# ============================================

# Pre-create report directories and log files
RUN mkdir -p "$SCAN_OUTPUT_DIR"/logs "$SCAN_OUTPUT_DIR"/screenshots "$SCAN_OUTPUT_DIR"/vulnerabilities && \
    touch "$SCAN_OUTPUT_DIR"/logs/exploit.log "$SCAN_OUTPUT_DIR"/logs/recon.log "$SCAN_OUTPUT_DIR"/logs/scan.log && \
    touch "$SCAN_OUTPUT_DIR"/vulnerabilities/vulnerabilities.log && \
    chown -R $UNAME:$UNAME /home/$UNAME

# ============================================
# Copy Entrypoint Script
# ============================================
# Install dependencies including dos2unix
RUN apt-get update && \
    apt-get install -y curl bash cron dos2unix && \
    rm -rf /var/lib/apt/lists/*

# Copy your entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Convert to Unix format and make it executable
RUN dos2unix /usr/local/bin/entrypoint.sh && \
    chmod +x /usr/local/bin/entrypoint.sh

# ============================================
# Switch to Non-root User
# ============================================
# Set user context
USER $UNAME
WORKDIR $HOME

# ============================================
# Entrypoint and CMD
# ============================================
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]
