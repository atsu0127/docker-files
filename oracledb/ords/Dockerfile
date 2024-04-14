FROM oraclelinux:8.9

RUN dnf install -y oracle-instantclient-release-el8.x86_64 && \
    dnf install -y https://yum.oracle.com/repo/OracleLinux/OL8/oracle/software/x86_64/getPackage/ords-23.2.0-5.el8.noarch.rpm && \
    dnf install -y https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm && \
    dnf install -y jq sudo less oracle-instantclient-basic.x86_64 oracle-instantclient-sqlplus.x86_64

COPY init.sh /init.sh

CMD ["sh", "/init.sh"]