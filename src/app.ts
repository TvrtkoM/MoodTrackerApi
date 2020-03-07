import express, { Express } from "express";
import { IController } from "./controllers/interfaces";
import cors from "cors";

export class App {
  controllersMap: Map<string, IController> = new Map();

  constructor(controllers: IController[]) {
    this._app = express();
    this._app.use(express.json());
    this._app.use(cors());
    controllers.forEach(c => {
      this.controllersMap.set(c.path, c);
      this._app.use(c.path, c.router);
    });
  }

  run(port: number = 3000) {
    this._app.listen(port, () => {
      console.log(`Server running on port ${port}`);
    });
  }

  private _app: Express;
}
