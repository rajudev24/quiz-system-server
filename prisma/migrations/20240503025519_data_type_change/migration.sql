/*
  Warnings:

  - You are about to alter the column `negativeMarkValue` on the `exam` table. The data in that column could be lost. The data in that column will be cast from `DoublePrecision` to `Decimal(65,30)`.

*/
-- AlterTable
ALTER TABLE "exam" ALTER COLUMN "negativeMarkValue" SET DATA TYPE DECIMAL(65,30);
