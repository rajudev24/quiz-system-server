import { Request, Response } from "express";
import { UserService } from "./user.service";
import config from "../../config";

const cretaeUser = async (req: Request, res: Response) => {
  try {
    const result = await UserService.cretaeUser(req.body);
    res.send({
      success: true,
      message: "User Created Sucessfully",
      data: result,
    });
  } catch (err) {
    res.send(err);
  }
};

const logInUser = async (req: Request, res: Response) => {
  try {
    const result = await UserService.logInUser(req.body);

    const { refreshToken, ...others } = result;

    const cookieOptions = {
      secure: config.env === "production",
      httpOnly: true,
    };
    res.cookie("refreshToken", refreshToken, cookieOptions);

    res.send({
      success: true,
      message: "Login Sucessfully",
      data: others,
    });
  } catch (err) {
    res.send(err);
  }
};

export const userController = {
  cretaeUser,
  logInUser,
};
