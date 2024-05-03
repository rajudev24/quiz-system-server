import express from "express";
import { QuestionController } from "./question.controller";

const router = express.Router();

router.post("/create-question", QuestionController.createQuestion);
router.get("/get-question", QuestionController.getQuestions);

export const QuestionRoutes = router;
