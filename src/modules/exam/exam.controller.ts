import { Request, Response } from "express";
import { ExamService } from "./exam.service";

const createExam = async (req: Request, res: Response) => {
  try {
    const result = await ExamService.cretaeExam(req.body);
    res.send({
      success: true,
      message: "Exam Created Successfully",
      data: result,
    });
  } catch (err) {
    res.send(err);
  }
};

const getExams = async (req: Request, res: Response) => {
  try {
    const result = await ExamService.getExams();
    res.send({
      success: true,
      message: "Exam retrived Successfully",
      data: result,
    });
  } catch (err) {
    res.send(err);
  }
};

export const ExamController = {
  createExam,
  getExams,
};
