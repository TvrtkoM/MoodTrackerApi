export interface ITodoItemModel {
  id: number;
  createdAt: Date;
  eventTime: Date;
  title: string;
  description?: string;
  mood?: number;
}

export type ITodoItemUpdateModel = Partial<
  Omit<ITodoItemModel, "id" | "createdAt">
>;
