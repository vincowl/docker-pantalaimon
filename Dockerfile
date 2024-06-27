FROM matrixdotorg/pantalaimon

RUN apt-get update && apt-get install -y pkg-config libcairo2-dev libgirepository1.0-dev libdbus-1-dev dbus-x11 

RUN pip install pantalaimon[ui]
ENV DISPLAY=localhost:0

COPY config/org.pantalaimon1.service /usr/share/dbus-1/services/.

ENV DISPLAY=:0

RUN mkdir -p /var/run/dbus \
    && dbus-uuidgen > /var/lib/dbus/machine-id \
    && dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address \
    && export $(dbus-launch)

ENTRYPOINT ["pantalaimon"]
CMD ["-c", "/data/pantalaimon.conf", "--data-path", "/data"]

