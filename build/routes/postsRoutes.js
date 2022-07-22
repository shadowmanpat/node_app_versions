"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
/** source/routes/posts.ts */
const express_1 = __importDefault(require("express"));
const postsController_1 = __importDefault(require("../controllers/postsController"));
const router = express_1.default.Router();
router.get("/posts", postsController_1.default.getPosts);
router.get("/posts/:id", postsController_1.default.getPost);
router.put("/posts/:id", postsController_1.default.updatePost);
router.delete("/posts/:id", postsController_1.default.deletePost);
router.post("/posts", postsController_1.default.addPost);
module.exports = router;
