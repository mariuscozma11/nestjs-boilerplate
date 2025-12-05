import { DataSource } from 'typeorm';
import * as dotenv from 'dotenv';
dotenv.config();

const isProd = process.env.NODE_ENV === 'production';

export const AppDataSource = new DataSource({
  type: 'postgres',
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT),
  username: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE,
  synchronize: false,
  entities: isProd ? ['dist/**/*.entity.js'] : ['src/**/*.entity.ts'],
  migrations: isProd ? ['dist/src/db/migrations/*.js'] : ['src/db/migrations/*.ts'],
  logging: !isProd,
  migrationsRun: isProd,
  ssl: isProd ? { rejectUnauthorized: false } : false,
});
