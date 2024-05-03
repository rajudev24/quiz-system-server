/*
  Warnings:

  - You are about to drop the column `endTime` on the `candidate_exam` table. All the data in the column will be lost.
  - You are about to drop the column `startTime` on the `candidate_exam` table. All the data in the column will be lost.
  - You are about to drop the `candidate_response` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `rightAnswer` to the `candidate_exam` table without a default value. This is not possible if the table is not empty.
  - Added the required column `wrongAnswer` to the `candidate_exam` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "candidate_response" DROP CONSTRAINT "candidate_response_candidateExamId_fkey";

-- AlterTable
ALTER TABLE "candidate_exam" DROP COLUMN "endTime",
DROP COLUMN "startTime",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "rightAnswer" INTEGER NOT NULL,
ADD COLUMN     "wrongAnswer" INTEGER NOT NULL;

-- DropTable
DROP TABLE "candidate_response";
