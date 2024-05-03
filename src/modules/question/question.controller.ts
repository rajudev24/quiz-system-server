import { Request, Response } from "express";
import { QuestionService } from "./question.service";

const createQuestion = async (req: Request, res: Response) => {
  try {
    const result = await QuestionService.createQuestion(req.body);
    res.send({
      success: true,
      message: "Question Created Successfully",
      data: result,
    });
  } catch (err) {
    res.send(err);
  }
};

const getQuestions = async (req: Request, res: Response) => {
  try {
    const result = await QuestionService.getQuestions();
    res.send({
      success: true,
      message: "Question retrived Successfully",
      data: result,
    });
  } catch (err) {
    res.send(err);
  }
};

export const QuestionController = {
  createQuestion,
  getQuestions,
};
