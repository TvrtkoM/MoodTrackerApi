import { App } from "./app";
import { TodoItemController } from "./controllers/todo-item.controller";

const controllers = [new TodoItemController()];

const app = new App(controllers);

app.run();
