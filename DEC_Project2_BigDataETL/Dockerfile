# FROM python:3.9
FROM ghcr.io/dbt-labs/dbt-snowflake:1.7.1

WORKDIR /app 

COPY . .


ENTRYPOINT ["/bin/bash", "build_dbt.sh"]

# CMD ["dbt", "run"]

CMD ["dbt", "run", "--select", "staging.*", "--exclude", "marts.*+"]
