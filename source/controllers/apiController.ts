/** source/controllers/posts.ts */
import { Request, Response, NextFunction } from "express";
import axios, { AxiosResponse } from "axios";
import cheerio from "cheerio";
// interface VersionModel {
//     version: String;
//     notes: String;
// }

// getting all posts
const getAndroidVersion = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  var gplay = require("google-play-scraper");

  var result = await gplay.app({ appId: "com.myjobnow.mjn_crew.prod" });
  return res.status(200).json({
    result: result,
  });
};

const getIOSVersion = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  var store = require("app-store-scraper");

  var result = await store.app({ id: 1591603398, country: "GR" });
  return res.status(200).json({
    result: result,
  });
};

export default { getAndroidVersion, getIOSVersion };
