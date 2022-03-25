FROM centos:centos7

RUN yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm && \
  yum install -y postgresql13-13.5-1PGDG.rhel7.aarch64 postgresql13-server-13.5-1PGDG.rhel7.aarch64 less

ENV PATH $PATH:/usr/pgsql-13/bin
ENV PGDATA /var/lib/pgsql/13/data

USER postgres
COPY --chown=postgres:postgres ./scripts/entrypoint.sh ./scripts/init.sql /init/
COPY --chown=postgres:postgres ./config/postgresql.conf /etc/postgresql/postgresql.conf
RUN chmod 755 /init/entrypoint.sh
EXPOSE 5432
ENTRYPOINT ["/init/entrypoint.sh"]
CMD ["/bin/sh", "-c", "while :; do sleep 3; done"]