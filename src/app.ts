import express, { Application } from "express";
import cors from "cors";
import { UserRoutes } from "./modules/user/user.route";
import { QuestionRoutes } from "./modules/question/question.route";
import { ExamRoutes } from "./modules/exam/exan.route";
import { CandidateRoutes } from "./modules/candidateExam/candidateExam.route";

const app: Application = express();
app.use(express.json());
app.use(
  cors({
    origin: "http://localhost:3000",
  })
);
app.use(express.urlencoded({ extended: true }));

app.use("/api/user", UserRoutes);
app.use("/api/question", QuestionRoutes);
app.use("/api/exam", ExamRoutes);
app.use("/api/candidate", CandidateRoutes);

export default app;
