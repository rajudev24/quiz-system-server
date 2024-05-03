import express from "express";
import { CandidateController } from "./candidateExam.controller";
const router = express.Router();

router.post("/create-candidate-exam", CandidateController.createCandidateExam);
router.get("/get-candidate-exam", CandidateController.getCandidateExams);

export const CandidateRoutes = router;
