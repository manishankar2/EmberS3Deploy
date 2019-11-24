FROM node:8

LABEL version="1.0.0"
LABEL repository="https://github.com/manishankar/EmberS3Deploy"
LABEL maintainer="Manishankar <manishankar2@gmail.com>"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
