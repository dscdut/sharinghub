import env from 'dotenv';

env.config();

export const NODE_ENV = process.env.NODE_ENV || 'development';
export const PORT = process.env.PORT || 3000;
export const HOST = process.env.HOST || 'http://localhost:3000';
export const JWT_SECRET = process.env.JWT_SECRET || 'vjppro';
export const EXPIRE_DAYS = process.env.EXPIRE_DAYS || '1d';
export const { DATABASE_URL } = process.env;
export const ROOT_DIR = process.env === 'production' ? `${process.cwd()}/dist` : `${process.cwd()}/src`;
export const { CLOUDINARY_NAME, CLOUDINARY_API_KEY, CLOUDINARY_API_SECRET } = process.env;
export const SALT_ROUNDS = Number.parseInt(process.env.SALT_ROUNDS, 10);
export const EMAIL = 'sharinghub.gdscdut@gmail.com';
export const SENGRID_API_KEY = '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';
