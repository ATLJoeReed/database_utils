#!/usr/bin/env python3.5
# coding: utf-8

import logging
from urllib.request import urlopen

import psycopg2

from config import constants, constants_sql, settings


def setup_logger(logger_name, log_file_name):
    logger = logging.getLogger(logger_name)
    logger.setLevel(logging.INFO)
    fh = logging.FileHandler(log_file_name)
    formatter = logging.Formatter(
            '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
        )
    fh.setFormatter(formatter)
    logger.addHandler(fh)
    return logger


def download_data(filename):
    try:
        logger.info('Downloading file: {}'.format(filename))
        response = urlopen(constants.base_url + filename)
        html = response.read()
        with open(constants.path + filename, 'wb') as f:
            f.write(html)
    except Exception as e:
        logger.error("Exception downloading file: {}".format(e))


def insert_data(filename):
    try:
        logger.info('Inserting records from file: {}'.format(filename))
        with open(constants.path + filename, 'r') as f:
            cur.copy_expert(sql=constants_sql.copy_sql, file=f)
            conn.commit()
    except Exception as e:
        logger.error("Exception inserting data: {}".format(e))
    finally:
        cur.close

logger = setup_logger('data_loader_logger', 'data_loader.log')

try:
    conn = psycopg2.connect(**settings.credentials)
    cur = conn.cursor()
except Exception as e:
    logger.error("Exception inserting data: {}".format(e))

# We do a complete data load each time...
try:
    logger.info('Truncating table...')
    cur.execute(constants_sql.truncate_table_sql)
except Exception as e:
    logger.error("Exception truncating table: {}".format(e))

# Found a significant speed increase by removing indexes,
# doing the inserts and then rebuilding the indexes...
try:
    logger.info('Dropping indexes...')
    cur.execute(constants_sql.tear_down_indexes_sql)
except Exception as e:
    logger.error("Exception dropping indexes: {}".format(e))

logger.info('Starting to loop through files...')
for file in constants.files:
    download_data(file)
    insert_data(file)

# Rebuilding the indexes...
try:
    logger.info('Rebuilding indexes...')
    cur.execute(constants_sql.build_indexes_sql)
except Exception as e:
    logger.error("Exception dropping indexes: {}".format(e))
