FROM python:3.11-slim

RUN pip install --no-cache-dir dbt-duckdb==1.8.1

WORKDIR /usr/app


