import { Question } from "@prisma/client";
import { PrismaClient, Prisma } from "@prisma/client";
const prisma = new PrismaClient();

const createQuestion = async (
  data: Prisma.QuestionCreateInput
): Promise<Question> => {
  const result = await prisma.question.create({
    data,
  });
  return result;
};

const getQuestions = async (): Promise<Question[]> => {
  const result = await prisma.question.findMany();
  return result;
};

export const QuestionService = {
  createQuestion,
  getQuestions,
};
