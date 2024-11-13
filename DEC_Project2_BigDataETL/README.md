# DEC Project#2 - Big Data ETL
# Objective

This project will explore building a big data ETL pipeline solution using the lessons learnt such as:
> - data integration tools like Airbyte
> - cluster compute engines to transform data such as Snowflake
> - Create DAGs for transformations using dbt
> - data quality tests for using transformations using dbt tests
> - host this solution on the AWS cloud

## Consumers
The end users would be analysts from the sales and marketing team who will need to generate sales and customer reports.

## Questions
> - which city and country where most movies are rented out?
> - Which year are the most movies rented out?
> - rental amount associated with each rental
> - income related to areas of movies
> - which movie types made the most type of money

## Source datasets

| Source Name           | Source Type | Source Documentation                       |
|----------------------|-------------|-------------------------------------------|
| DVD Rental Database  | Postgres SQL   | (https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database) |

Due to limited time, we limiting our dataset to above, with purpose of using the techniques learned last few weeks.

## Solution architecture

Here's a high-level sequence of the pipeline solution:

1. The source , DVD Rental Database, will be either loaded into the local computer by postgres or on the RDS database depending on cost
2. Airbyte will ingest the source data into Data Warehouse Snowflake
3. DBT will be responsible DAG formation based on data formation
4. Semantic modeling and visualization - a tool such as Preset or PowerBI will be used to visualize the data reports.

Depending on costs, we may host locally before seeing it can be deployed on EC2

# Breakdown of Tasks
- Hugo will put together the documents
- Veda will determine how we can break this source schema to fact table and schema




# Setting up the environment

## Cloning the project
```
> git init


## Virtual Environment (conda)
1. Open the terminal and create a conda environment
```
> conda create -n project1 python=3.9
```

2. Activate the conda env
```
> conda activate project1
```

3. Install the requirements in project1 conda environment
```
> pip install -r requirements.txt
```

4. entry point for pythonetl 
```
> cd app
> python -m etl_project.pipelines.spotify
```

5. entry point for sqletl
```
> cd app2
> python extract_load.py
```

6. entry point for finalized pipeline
7. 
```
> cd app3
> python -m etl_project.pipelines.spotify
```

6. docker build and run
```
 -- Container#1 - python-etl (full-extract)
> docker build --platform=linux/amd64 -t project1_pythonetl .
> docker run --env-file .env project1_pythonetl:latest

 -- Container#2 - sql-etl(incremental extract)
> docker build --platform=linux/amd64 -t project1_sqletl .
> docker run --env-file .env project1_ project1_sqletl:latest

 -- Container#3 - python-sql etl(incremental extract)
> docker build --platform=linux/amd64 -t pythonsql .
> docker run --env-file .env pythonsql:latest
```



## AWS Screenshots

To be added

**Dataset loaded in RDS**



**Scheduled Task in ECS**


**Container Image in ECR**


**IAM Created Role**


S3 Bucket containing env file



