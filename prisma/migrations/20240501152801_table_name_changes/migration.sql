/*
  Warnings:

  - You are about to drop the `candidate_responses` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `candidates_exam` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `exams` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `questions` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "candidate_responses" DROP CONSTRAINT "candidate_responses_candidateExamId_fkey";

-- DropForeignKey
ALTER TABLE "candidate_responses" DROP CONSTRAINT "candidate_responses_questionId_fkey";

-- DropForeignKey
ALTER TABLE "candidates_exam" DROP CONSTRAINT "candidates_exam_candidateId_fkey";

-- DropForeignKey
ALTER TABLE "candidates_exam" DROP CONSTRAINT "candidates_exam_examId_fkey";

-- DropForeignKey
ALTER TABLE "questions" DROP CONSTRAINT "questions_examId_fkey";

-- DropForeignKey
ALTER TABLE "questions" DROP CONSTRAINT "questions_exmainerId_fkey";

-- DropTable
DROP TABLE "candidate_responses";

-- DropTable
DROP TABLE "candidates_exam";

-- DropTable
DROP TABLE "exams";

-- DropTable
DROP TABLE "questions";

-- CreateTable
CREATE TABLE "question_bank" (
    "id" SERIAL NOT NULL,
    "question" TEXT NOT NULL,
    "questionType" "QuestionType" NOT NULL DEFAULT 'SINGLE',
    "options" JSONB NOT NULL,
    "corretAnswers" JSONB NOT NULL,
    "exmainerId" INTEGER NOT NULL,
    "marks" INTEGER NOT NULL,
    "examId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "question_bank_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "exam" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "duration" "DurationType" NOT NULL DEFAULT 'PerQuestion',
    "durationOfExam" INTEGER NOT NULL,
    "negativeMarks" BOOLEAN,
    "negativeMarkValue" INTEGER,
    "numberOfQuestions" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "exam_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "candidate_exam" (
    "id" SERIAL NOT NULL,
    "candidateId" INTEGER NOT NULL,
    "examId" INTEGER NOT NULL,
    "startTime" TIMESTAMP(3) NOT NULL,
    "endTime" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "candidate_exam_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "candidate_response" (
    "id" SERIAL NOT NULL,
    "candidateExamId" INTEGER NOT NULL,
    "questionId" INTEGER NOT NULL,
    "chosenAnswers" TEXT[],
    "marksAwarded" INTEGER NOT NULL,

    CONSTRAINT "candidate_response_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "question_bank" ADD CONSTRAINT "question_bank_exmainerId_fkey" FOREIGN KEY ("exmainerId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "question_bank" ADD CONSTRAINT "question_bank_examId_fkey" FOREIGN KEY ("examId") REFERENCES "exam"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "candidate_exam" ADD CONSTRAINT "candidate_exam_candidateId_fkey" FOREIGN KEY ("candidateId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "candidate_exam" ADD CONSTRAINT "candidate_exam_examId_fkey" FOREIGN KEY ("examId") REFERENCES "exam"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "candidate_response" ADD CONSTRAINT "candidate_response_candidateExamId_fkey" FOREIGN KEY ("candidateExamId") REFERENCES "candidate_exam"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "candidate_response" ADD CONSTRAINT "candidate_response_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES "question_bank"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
