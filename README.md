<<<<<<< HEAD
# Hugo-Lab-ETL
=======
# DEC Project#2 - Big Data ETL
# Objective

This project will explore building a big data ETL pipeline solution on the AWS cloud. The solution will utilize lessons learn in past few weeks to.
The source database containing the dvd_rental information is hosted in the RDS database. We will spin up an EC2 instance on AWS, to host a data ingestion tool called airbyte.
We will access the airbyte instance through EC2 instaince public dns IP on web browers, and schedule/trigger a replication sync to replicate the data in raw format to a snowflake warehouse.
From there, we have build another docker container, hosting the dbt-snowflake package.
Running this application on ECS, will trigger data modelling techniques used to transform the data useable for business outcomes.
Will be transforming data from raw, to staging, to marts/dimensioning and fact tables along with big tables.
Additionally, custom transformation techniques will be used to answer specific business questions.

Both Airbyte replication and Docker dbt-snowflake data can be triggered manually online or scheduled one after the other.

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

1. The source , DVD Rental Database, will be either loaded into the RDS database. This database can be accessible through postgres.
2. Airbyte hosted on EC2 instance will ingest the source data into Data Warehouse Snowflake
3. From there, a snowflake-dbt package in a container will do the data transformation based on the data modelling techniques used, taking through staging, marts along with dimensioning and fact tables. 
4. Semantic modeling and visualization - a tool such as Preset or PowerBI will be used to visualize the data reports.

High-Level Flow so far:
Source Database for DVD_Rental (RDS, Postgres) --> Airbyte --> Snowflake (raw tables)
Snowflake (raw tables) --> DBT --> Snowflake (staging tables)
Snowflake staging tables --> DBT --> Snowflake (mart tables/dim_tables and custome transformations)
Snowflake (mart tables/dim_tables) --> fact_table
then report sale (one big table)

**Airbyte**
An EC2 instance will be spin up. Afterwards, we will install the airbyte instance then access the airbyte application through the EC2 instance public IP on web browser and using the abctl local credentials.
The source connector will be RDS postgres while the destination connector will be snowflake.
Afterwards setup the replication setup, and run a full replication of all 15 tables to snowflake as a raw table.

While running airbyte locally doesn't pose any resource issue, running airbyte online means there maybe some resource (compute, memory) issues. Sometimes this means ensuring kubernetes is installed in the EC2 instance as well, then bouncing the pods responsible for the replications after making the resource adjustment.

**Snowflake-DBT**
Once the raw data is in snowflakes, we be using data modelling techniques to go through several rounds of transformations.
From docker perspective, we will draw the package from an existing dbt-snowflake package available in dbt-labs to include on the containers.
The docker container will be run on ECS cluster will can be triggered anytime or run scheduled through a task definition.
Logs below and corresponding snowflake data shows the sync happened.

# Breakdown of Tasks





# Setting up the environment





## ELT Screenshots

**Dataset loaded in RDS**
![](images/11-16-2024%20RDS%20Database.jpg)

**ECS Cluster**
![](images/11-16-2024%20ECS%20Cluster.jpg)

**Container Image in ECR**
![](images/11-16-2024%20ECR%20Repository.jpg)

**EC2 Airbyte Data Ingestion from Postgres to Snowflake Succesful**
![](images/11-15-2024%20Snowflake_Ingestion_Successful.jpg)

**ECS Logs showing Docker DBT-Snowflake being run on ECS**
Snowflake Query History shows recently run after ECS task to run snowflake-dbt docker file on AWS is triggered
![](images/11-16-2024%20snowflake-dbt_docker%20runs%20on%20ECS.jpg)

Logs showing the successul run of snowflake-dbt docker container on ECS
![](images/11-16-2024%20ECS%20Log%20Part%201.jpg)

![](images/11-16-2024%20ECS%20Log%20Part%202.jpg)

![](images/11-16-2024%20ECS%20Log%20Part%203.jpg)



