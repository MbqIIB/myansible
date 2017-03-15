FROM s-mqfDNVKhw-web-demo-v3.0

ADD . /bd_build

RUN /bd_build/doinit.sh && \
    /bd_build/update.sh

CMD ["/sbin/my_init"]
