FROM hexonxonx4/arch-int-vpn:latest
LABEL org.opencontainers.image.authors = "binhex"
LABEL org.opencontainers.image.source = "https://github.com/binhex/arch-qbittorrentvpn"

# additional files
##################

# add supervisor conf file for app
ADD build/*.conf /etc/supervisor/conf.d/

# add bash scripts to install app
ADD build/root/*.sh /root/

# get release tag name from build arg
ARG release_tag_name

# add run bash scripts
ADD run/abc/*.sh /home/abc/

# add pre-configured config files for abc
ADD config/abc/ /home/abc/

# install app
#############

# make executable and run bash scripts to install app
RUN chmod +x /root/*.sh /home/abc/*.sh && \
	/bin/bash /root/install.sh "${release_tag_name}"

# docker settings
#################

# expose port for incoming connections (used only if vpn disabled)
EXPOSE 6881

# expose port for qbittorrent http
EXPOSE 8080

# expose port for privoxy
EXPOSE 8118

# set permissions
#################

# run script to set uid, gid and permissions
CMD ["/bin/bash", "/usr/local/bin/init.sh"]
