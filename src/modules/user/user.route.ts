import express from "express";
import { userController } from "./user.controller";

const router = express.Router();

router.post("/create-user", userController.cretaeUser);
router.post("/login-user", userController.logInUser);

export const UserRoutes = router;
