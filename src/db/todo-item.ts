import moment, { Moment } from "moment";
import { Database } from ".";
import { QueryConfig } from "pg";
import { ITodoItemModel, ITodoItemUpdateModel } from "./interfaces";
import { ITodoItemJson, ITodoItemUpdateJson } from "../controllers/interfaces";

export class TodoItem {
  id: number;
  createdAt: Moment;
  eventTime: Moment;
  title: string;
  description?: string;
  mood?: number;

  constructor(data: ITodoItemModel) {
    this.id = data.id;
    this.createdAt = moment(data.createdAt);
    this.eventTime = moment(data.eventTime);
    this.title = data.title;
    this.description = data.description;
    this.mood = data.mood ? data.mood : undefined;
  }

  async update(data: ITodoItemUpdateModel): Promise<TodoItem> {
    const map: Map<keyof typeof data, any> = new Map(
      Object.entries(data) as any
    );
    let i = 1;
    if (map.size !== 0) {
      const values = [];
      const query: QueryConfig = {
        text: `update items set`
      };
      for (const [key, value] of map) {
        const thisRef = this as any;
        if (value instanceof Date) {
          thisRef[key] = moment(value);
        } else {
          thisRef[key] = value;
        }
        query.text = `${query.text} "${key}"=$${i}`;
        values.push(value);
        if (i < map.size) {
          query.text = `${query.text},`;
        }
        i++;
      }
      query.text = `${query.text} where id=$${i}`;
      values.push(this.id);
      query.values = values;
      await Database.query(query);
    }
    return this;
  }

  get hasFinished(): boolean {
    return this.eventTime.diff(moment()) <= 0;
  }

  get json(): ITodoItemJson {
    return {
      id: this.id,
      createdAt: this.createdAt.format(),
      eventTime: this.eventTime.format(),
      title: this.title,
      description: this.description,
      mood: this.mood,
      hasFinished: this.hasFinished
    };
  }
}

export class TodoItems {
  static async create(
    title: string,
    eventTime: Date,
    description?: string
  ): Promise<TodoItem> {
    const res = await Database.query({
      text: `insert into items ("title", "description", "eventTime")
        values ($1::text, $2::text, $3::timestamp) returning id`,
      values: [title, description, eventTime]
    });
    const id = parseInt(res.rows[0].id);
    // we will most definitely get the result
    // unless there was an issue with database
    // but i hate the syntax - it's confusing
    return <TodoItem>(<unknown>this.get(id));
  }

  static async collection(
    options: {
      showFinished: boolean;
    } = { showFinished: false }
  ): Promise<Array<TodoItem>> {
    const query: QueryConfig = {
      text: `select * from items`
    };
    if (options.showFinished === false) {
      query.text = `${query.text} where "eventTime" > now()::timestamptz`;
    }
    query.text = `${query.text} order by "eventTime" asc`;
    const res = await Database.query(query);
    const items: Array<TodoItem> = (res.rows as Array<ITodoItemModel>).map(
      item => {
        return new TodoItem(item);
      }
    );
    return items;
  }

  static async get(id: number): Promise<TodoItem | undefined> {
    const res = await Database.query({
      text: "select * from items where id=$1::integer",
      values: [id]
    });
    const items: Array<ITodoItemModel> = res.rows;
    const item: TodoItem | undefined =
      items.length === 0 ? undefined : new TodoItem(items[0]);
    return item;
  }

  static jsonToModel(
    json: Partial<Omit<ITodoItemJson, "hasFinished">>
  ): Partial<ITodoItemModel> {
    const res: Partial<ITodoItemModel> = {};
    for (const k of Object.keys(json) as Array<keyof typeof json>) {
      const v = json[k];
      if (["id", "title", "description", "mood"].indexOf(k) !== -1) {
        res[k] = v as any;
      } else {
        res[k] = moment(v).toDate() as any;
      }
    }
    return res;
  }
}
