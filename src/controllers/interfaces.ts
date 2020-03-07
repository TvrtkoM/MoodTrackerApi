import { Router } from "express";

export interface IController {
  router: Router;
  path: string;
}

export interface ITodoItemJson {
  id: number;
  createdAt: string;
  eventTime: string;
  title: string;
  description?: string;
  mood?: number;
  hasFinished: boolean;
}

export type ITodoItemUpdateJson = Partial<
  Omit<ITodoItemJson, "id" | "createdAt" | "hasFinished">
>;
