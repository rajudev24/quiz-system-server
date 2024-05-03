/*
  Warnings:

  - The `duration` column on the `exams` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the `CandidateExam` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `CandidateResponse` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "DurationType" AS ENUM ('PerQuestion', 'ExamWise');

-- DropForeignKey
ALTER TABLE "CandidateExam" DROP CONSTRAINT "CandidateExam_candidateId_fkey";

-- DropForeignKey
ALTER TABLE "CandidateExam" DROP CONSTRAINT "CandidateExam_examId_fkey";

-- DropForeignKey
ALTER TABLE "CandidateResponse" DROP CONSTRAINT "CandidateResponse_candidateExamId_fkey";

-- DropForeignKey
ALTER TABLE "CandidateResponse" DROP CONSTRAINT "CandidateResponse_questionId_fkey";

-- AlterTable
ALTER TABLE "exams" DROP COLUMN "duration",
ADD COLUMN     "duration" "DurationType" NOT NULL DEFAULT 'PerQuestion',
ALTER COLUMN "negativeMarkValue" DROP NOT NULL;

-- DropTable
DROP TABLE "CandidateExam";

-- DropTable
DROP TABLE "CandidateResponse";

-- CreateTable
CREATE TABLE "candidates_exam" (
    "id" SERIAL NOT NULL,
    "candidateId" INTEGER NOT NULL,
    "examId" INTEGER NOT NULL,
    "startTime" TIMESTAMP(3) NOT NULL,
    "endTime" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "candidates_exam_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "candidate_responses" (
    "id" SERIAL NOT NULL,
    "candidateExamId" INTEGER NOT NULL,
    "questionId" INTEGER NOT NULL,
    "chosenAnswers" TEXT[],
    "marksAwarded" INTEGER NOT NULL,

    CONSTRAINT "candidate_responses_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "candidates_exam" ADD CONSTRAINT "candidates_exam_candidateId_fkey" FOREIGN KEY ("candidateId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "candidates_exam" ADD CONSTRAINT "candidates_exam_examId_fkey" FOREIGN KEY ("examId") REFERENCES "exams"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "candidate_responses" ADD CONSTRAINT "candidate_responses_candidateExamId_fkey" FOREIGN KEY ("candidateExamId") REFERENCES "candidates_exam"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "candidate_responses" ADD CONSTRAINT "candidate_responses_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES "questions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
