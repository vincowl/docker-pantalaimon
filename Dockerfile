FROM matrixdotorg/pantalaimon

WORKDIR /app

RUN apt-get update && apt-get install -y pkg-config libcairo2-dev libgirepository1.0-dev libdbus-1-dev dbus-x11 

RUN pip install pantalaimon[ui]


COPY config/org.pantalaimon1.service /usr/share/dbus-1/services/.
COPY config/pantalaimon.conf /data/.
COPY runme.sh .


RUN chmod a+x runme.sh \
    && mkdir -p /var/run/dbus \
    && dbus-uuidgen > /var/lib/dbus/machine-id \
    && dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address \
    && export $(dbus-launch)

ENV DISPLAY=localhost:0
ENV $(dbus-launch)

VOLUME /data

ENTRYPOINT ["/bin/bash"]
CMD ["runme.sh"]

