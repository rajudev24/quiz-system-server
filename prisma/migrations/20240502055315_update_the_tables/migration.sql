/*
  Warnings:

  - The values [MULTIPALE] on the enum `QuestionType` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `questionId` on the `candidate_response` table. All the data in the column will be lost.
  - You are about to drop the column `durationOfExam` on the `exam` table. All the data in the column will be lost.
  - You are about to drop the column `examId` on the `question_bank` table. All the data in the column will be lost.
  - Added the required column `exmainerId` to the `exam` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `duration` on the `exam` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "QuestionType_new" AS ENUM ('SINGLE', 'MULTIPLE');
ALTER TABLE "question_bank" ALTER COLUMN "questionType" DROP DEFAULT;
ALTER TABLE "question_bank" ALTER COLUMN "questionType" TYPE "QuestionType_new" USING ("questionType"::text::"QuestionType_new");
ALTER TYPE "QuestionType" RENAME TO "QuestionType_old";
ALTER TYPE "QuestionType_new" RENAME TO "QuestionType";
DROP TYPE "QuestionType_old";
ALTER TABLE "question_bank" ALTER COLUMN "questionType" SET DEFAULT 'SINGLE';
COMMIT;

-- DropForeignKey
ALTER TABLE "candidate_response" DROP CONSTRAINT "candidate_response_questionId_fkey";

-- DropForeignKey
ALTER TABLE "question_bank" DROP CONSTRAINT "question_bank_examId_fkey";

-- AlterTable
ALTER TABLE "candidate_response" DROP COLUMN "questionId";

-- AlterTable
ALTER TABLE "exam" DROP COLUMN "durationOfExam",
ADD COLUMN     "durationType" "DurationType" NOT NULL DEFAULT 'PerQuestion',
ADD COLUMN     "exmainerId" INTEGER NOT NULL,
DROP COLUMN "duration",
ADD COLUMN     "duration" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "question_bank" DROP COLUMN "examId";

-- CreateTable
CREATE TABLE "_ExamToQuestion" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_ExamToQuestion_AB_unique" ON "_ExamToQuestion"("A", "B");

-- CreateIndex
CREATE INDEX "_ExamToQuestion_B_index" ON "_ExamToQuestion"("B");

-- AddForeignKey
ALTER TABLE "exam" ADD CONSTRAINT "exam_exmainerId_fkey" FOREIGN KEY ("exmainerId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ExamToQuestion" ADD CONSTRAINT "_ExamToQuestion_A_fkey" FOREIGN KEY ("A") REFERENCES "exam"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ExamToQuestion" ADD CONSTRAINT "_ExamToQuestion_B_fkey" FOREIGN KEY ("B") REFERENCES "question_bank"("id") ON DELETE CASCADE ON UPDATE CASCADE;
