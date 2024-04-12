FROM oraclelinux:8.9

RUN dnf install -y oracle-instantclient-release-el8.x86_64 && \
    dnf install -y https://yum.oracle.com/repo/OracleLinux/OL8/oracle/software/x86_64/getPackage/ords-23.2.0-5.el8.noarch.rpm && \
    dnf install -y java-17-openjdk.x86_64 sudo less oracle-instantclient-basic.x86_64 oracle-instantclient-sqlplus.x86_64

COPY init.sh /init.sh

CMD ["sh", "/init.sh"]