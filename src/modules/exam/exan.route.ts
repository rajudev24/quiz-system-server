import express from "express";
import { ExamController } from "./exam.controller";

const router = express.Router();

router.post("/create-exam", ExamController.createExam);
router.get("/", ExamController.getExams);

export const ExamRoutes = router;
