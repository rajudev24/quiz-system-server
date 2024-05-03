import { Exam, PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

const cretaeExam = async (data: Exam) => {
  console.log(data);
  const { numberOfQuestions } = data;
  const questions = await prisma.question.findMany({
    take: numberOfQuestions,
  });

  if (questions.length < numberOfQuestions) {
    throw new Error("Insufficient questions available");
  }
  const result = await prisma.exam.create({
    data: {
      ...data,
      questions: {
        connect: questions.map((question) => ({ id: question.id })),
      },
    },
    include: {
      questions: true,
    },
  });

  return result;
};

const getExams = async (): Promise<Exam[]> => {
  const result = await prisma.exam.findMany({
    include: {
      questions: true,
    },
  });
  return result;
};

export const ExamService = {
  cretaeExam,
  getExams,
};
