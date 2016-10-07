FROM gcr.io/stacksmith-images/ubuntu:14.04-r10

MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=owncloud \
    BITNAMI_IMAGE_VERSION=9.1.1-r0 \
    PATH=/opt/bitnami/php/bin:/opt/bitnami/mysql/bin/:$PATH

# Additional modules required
RUN bitnami-pkg unpack php-5.6.26-1 --checksum b7a72ae78f9b19352bd400dfe027465c88a8643c0e5d9753f8d12f4ebae542a2
RUN bitnami-pkg unpack apache-2.4.23-7 --checksum bcbe93875f4017ed762caf73774a35b449e22c441e6b3f619f386294ba0a5958
RUN bitnami-pkg install mysql-client-10.1.13-4 --checksum 14b45c91dd78b37f0f2366712cbe9bfdf2cb674769435611955191a65dbf4976
RUN bitnami-pkg install libphp-5.6.26-1 --checksum 327d070f57727f2ed4f0246d0e3f61c5a94f6366d21a7e7e4572fe6c9c8e8c2d

# Install owncloud
RUN bitnami-pkg unpack owncloud-9.1.1-0 --checksum abf26188608e3dae5b809130ae4ccec66c6c804a4c67ad131f652de156bda1e1

COPY rootfs /

VOLUME ["/bitnami/owncloud", "/bitnami/apache", "/bitnami/php"]

EXPOSE 80 443

ENTRYPOINT ["/app-entrypoint.sh"]

CMD ["harpoon", "start", "--foreground", "apache"]
