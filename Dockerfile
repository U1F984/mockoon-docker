# Use the KasmVNC Ubuntu Jammy base image
FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

# Install dependencies and clean up in a single layer to reduce image size
RUN apt-get update && \
    apt-get install -y libgtk-3-0 libnotify4 libatspi2.0-0 libsecret-1-0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Download and install Mockoon's Debian package
RUN curl -L -o mockoon.deb https://github.com/mockoon/mockoon/releases/download/v7.0.0/mockoon-7.0.0.amd64.deb && \
    dpkg -i mockoon.deb && \
    rm mockoon.deb

# Create the autostart directory and autostart file for Mockoon
RUN mkdir -p /defaults && \
    echo "/opt/Mockoon/mockoon" > /defaults/autostart && \
    chmod +x /defaults/autostart
