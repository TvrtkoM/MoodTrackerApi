import {
  Pool,
  QueryConfig,
  QueryResultRow,
  QueryResult,
  ClientConfig
} from "pg";
import dbconfig from "./dbconfig.json";

const pool = new Pool(dbconfig as ClientConfig);

export class Database {
  static async query<R extends QueryResultRow = any, I extends any[] = any[]>(
    queryConfig: QueryConfig<I>
  ): Promise<QueryResult<R>> {
    return pool.query(queryConfig);
  }
}
