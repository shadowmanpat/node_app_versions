"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
// interface VersionModel {
//     version: String;
//     notes: String;
// }
// getting all posts
const getAndroidVersion = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var gplay = require("google-play-scraper");
    var result = yield gplay.app({ appId: "com.myjobnow.mjn_crew.prod" });
    return res.status(200).json({
        result: result,
    });
});
const getIOSVersion = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var store = require("app-store-scraper");
    var result = yield store.app({ id: 1591603398, country: "GR" });
    return res.status(200).json({
        result: result,
    });
});
exports.default = { getAndroidVersion, getIOSVersion };
