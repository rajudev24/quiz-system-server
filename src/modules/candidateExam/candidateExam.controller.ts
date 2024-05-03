import { Request, Response } from "express";
import { CandidateService } from "./candidateExam.service";

const createCandidateExam = async (req: Request, res: Response) => {
  try {
    const result = await CandidateService.createCandidateExam(req.body);
    res.send({
      success: true,
      message: "Candidate Exam Created Successfully",
      data: result,
    });
  } catch (err) {
    res.send(err);
  }
};

const getCandidateExams = async (req: Request, res: Response) => {
  try {
    const result = await CandidateService.getCandidateExams();
    res.send({
      success: true,
      message: "Candidate Exams retrived Successfully",
      data: result,
    });
  } catch (err) {
    res.send(err);
  }
};

export const CandidateController = {
  createCandidateExam,
  getCandidateExams,
};
