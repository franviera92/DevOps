FROM bennu/jobs:sh

RUN rm /opt/jobs/sh/entrypoint.sh

ADD entrypoint.sh /opt/jobs/sh/entrypoint.sh

#RUN mv /tmp/entrypoint.sh /opt/jobs/sh/entrypoint.sh

RUN chmod +x /opt/jobs/sh/entrypoint.sh

ENTRYPOINT ["/opt/jobs/sh/entrypoint.sh"]

# cd /home/ubuntu/bennu_jobs_sh
#  build -t bennu_jobs_sh .
# docker run -it -d bennu1



