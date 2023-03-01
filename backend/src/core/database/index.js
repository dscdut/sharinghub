import knex from 'knex';
import config from '../config/knexfile.config';
import { logger } from '../utils';
import { NODE_ENV } from '../env';

const connection = knex(config[NODE_ENV]);

export default connection;

export const getTransaction = () => connection.transaction();

export const connectDatabase = async () => {
    try {
        await connection.raw('SELECT 1');
        logger.info('Database connection successful');
    } catch (error) {
        logger.error('Database connection error, please check your connection');
    }
};
