import { PrismaClient, Prisma, CandidateExam } from "@prisma/client";
const prisma = new PrismaClient();

const createCandidateExam = async (
  data: CandidateExam
): Promise<CandidateExam> => {
  const result = await prisma.candidateExam.create({
    data,
  });
  return result;
};

const getCandidateExams = async (): Promise<CandidateExam[]> => {
  const result = await prisma.candidateExam.findMany();
  return result;
};

export const CandidateService = {
  createCandidateExam,
  getCandidateExams,
};
