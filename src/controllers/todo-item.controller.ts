import express, { Router, Request, Response } from "express";
import moment from "moment";
import { TodoItems } from "../db/todo-item";
import { IController, ITodoItemJson, ITodoItemUpdateJson } from "./interfaces";

export class TodoItemController implements IController {
  router: Router = express.Router();
  path = "/todo-item";

  constructor() {
    this.router.get("", async (req: Request, res: Response) => {
      try {
        const items = await TodoItems.collection();
        return res.send(items.map(i => i.json));
      } catch (err) {
        res.status(500);
        res.send({ error: err.message });
      }
    });

    this.router.get("/:id(\\d+)", async (req: Request, res: Response) => {
      const paramId = parseInt(req.params["id"]);
      try {
        const item = await TodoItems.get(paramId);
        if (item == null) {
          res.status(404);
          return res.send({ error: "Not Found" });
        }
        return res.send(item.json);
      } catch (err) {
        res.status(500);
        res.send({ error: err.message });
      }
    });

    this.router.post("", async (req: Request, res: Response) => {
      try {
        const data: ITodoItemJson = req.body;
        const item = await TodoItems.create(
          data.title,
          moment(data.eventTime).toDate(),
          data.description
        );
        res.status(201);
        res.send(item.json);
      } catch (err) {
        res.status(500);
        res.send({ error: err.message });
      }
    });

    this.router.put("/:id(\\d+)", async (req: Request, res: Response) => {
      const paramId = parseInt(req.params["id"]);
      const data: ITodoItemUpdateJson = req.body;
      try {
        const item = await TodoItems.get(paramId);
        if (item == null) {
          res.status(404);
          return res.send({ error: "Not Found" });
        }
        await item.update(TodoItems.jsonToModel(data));
        res.send(item.json);
      } catch (err) {
        res.status(500);
        res.send({ error: err.message });
      }
    });
  }
}
