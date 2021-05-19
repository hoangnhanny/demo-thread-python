FROM mysql:5.7

COPY sql/* /docker-entrypoint-initdb.d/

ENV MYSQL_DATABASE=demo
ENV MYSQL_ROOT_PASSWORD=demo

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh", "mysqld", "--datadir", "/initialized-db", "--sql-mode", ""]

