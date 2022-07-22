import express from "express";
import controller from "../controllers/apiController";
const router = express.Router();

router.get("/android", controller.getAndroidVersion);
router.get("/iOS", controller.getIOSVersion);

export = router;
