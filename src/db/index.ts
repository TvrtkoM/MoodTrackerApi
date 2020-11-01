import {
  Pool,
  QueryConfig,
  QueryResultRow,
  QueryResult,
  ClientConfig
} from "pg";

import * as dotenv from 'dotenv';
dotenv.config();

const port: number = process.env.DB_PORT != null ? parseInt(process.env.DB_PORT, 10) : 5432;

const dbconfig: ClientConfig = {
  host: process.env.DB_HOST,
  port,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
}

const pool = new Pool(dbconfig);

export class Database {
  static async query<R extends QueryResultRow = any, I extends any[] = any[]>(
    queryConfig: QueryConfig<I>
  ): Promise<QueryResult<R>> {
    return pool.query(queryConfig);
  }
}
