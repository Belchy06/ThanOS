# syntax=docker/dockerfile:experimental
FROM docker:20.10.7-dind
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update; apk add kexec-tools alpine-conf openssh xf86-video-vmware xf86-input-mouse xf86-input-keyboard openrc
RUN mkdir /run/openrc
RUN touch /run/openrc/softlevel 

COPY . .
RUN chmod +x ./start.sh
# ENTRYPOINT ["./start.sh"]
