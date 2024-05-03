import { User } from "@prisma/client";
import { PrismaClient } from "@prisma/client";
import bcrypt from "bcrypt";
import { jwtHelpers } from "../../helpers/jwtHelpers";
import config from "../../config";
import { Secret } from "jsonwebtoken";
import { ILoginResponse } from "./user.interface";

const prisma = new PrismaClient();

const cretaeUser = async (data: User): Promise<User> => {
  const hashedPassword = await bcrypt.hash(
    data.password,
    Number(config.bcrypt_salt_rounds)
  );

  const result = await prisma.user.create({
    data: {
      ...data,
      password: hashedPassword,
    },
  });
  return result;
};

const logInUser = async (data: User): Promise<ILoginResponse> => {
  const { email, password } = data;
  const user = await prisma.user.findUnique({
    where: {
      email,
    },
  });

  if (!user) {
    throw new Error("User not found");
  }
  const isPasswordValid = await bcrypt.compare(password, user.password);
  if (!isPasswordValid) {
    throw new Error("Invalid password");
  }

  // Create Access Token & Refresh Token
  const { id, role } = user;
  const accessToken = jwtHelpers.createToken(
    {
      id,
      role,
    },
    config.jwt.secret as Secret,
    config.jwt.expires_in as string
  );

  const refreshToken = jwtHelpers.createToken(
    {
      id,
    },
    config.jwt.refresh_secrect as Secret,
    config.jwt.refresh_expires_in as string
  );

  return {
    accessToken,
    refreshToken,
  };
};

export const UserService = {
  cretaeUser,
  logInUser,
};
