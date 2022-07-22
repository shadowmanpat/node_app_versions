"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
const express_1 = __importDefault(require("express"));
const apiController_1 = __importDefault(require("../controllers/apiController"));
const router = express_1.default.Router();
router.get("/android", apiController_1.default.getAndroidVersion);
router.get("/iOS", apiController_1.default.getIOSVersion);
module.exports = router;
