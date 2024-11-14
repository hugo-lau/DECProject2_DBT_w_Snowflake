# FROM python:3.9
FROM ghcr.io/dbt-labs/dbt-snowflake:1.7.1

WORKDIR /app 

COPY . .

COPY requirements.txt .

ENV SNOWFLAKE_USERNAME

RUN pip install -r requirements.txt 

# ENTRYPOINT ["/bin/bash", "build_dbt.sh"]

CMD ["dbt", "run"]
