FROM oraclelinux:7-slim

ARG oraclever=19.10

RUN  yum -y install oracle-release-el7 && \
  yum-config-manager --enable ol7_oracle_instantclient && \
  yum -y install oracle-instantclient${oraclever}-{basic,sqlplus}

RUN mkdir -p /usr/lib/oracle/${oraclever}/client64/network/admin
COPY admin /usr/lib/oracle/${oraclever}/client64/network/admin

ENV ORACLE_HOME /usr/lib/oracle/${oraclever}/client64

ENTRYPOINT [ "sqlplus" ]
CMD ["-v"]