# syntax=docker/dockerfile:experimental
FROM docker:20.10.7-dind

# Install X11 packages
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update; apk add alpine-conf xf86-video-vmware xf86-input-mouse xf86-video-ati xf86-video-nouveau xf86-input-keyboard mesa-egl openrc xrandr jq
RUN mkdir /run/openrc
RUN touch /run/openrc/softlevel 

#Install Audio 
RUN apk add alsa-utils alsa-utils-doc alsa-lib alsaconf
RUN addgroup root audio

#Install firefox, required firefox libs and fonts
RUN apk add firefox pciutils-libs ttf-dejavu ttf-liberation

COPY . .
RUN chmod +x ./start.sh
RUN chmod +x ./pause.sh
ENTRYPOINT ["/bin/sh", "-c", "export DISPLAY=:0 && ./start.sh"]
# ENTRYPOINT ["/bin/sh", "-c", "./pause.sh"]
