const express = require("express");
import type { Request, Response } from "express";

const app = express();
const port = 3000;

// Middleware
app.use(express.json());

// Routes
app.get("/", (req: Request, res: Response) => {
  res.send("Hello, TypeScript + Express!");
});
app.get("/test", (req: Request, res: Response) => {
    res.status(200).json({
        message: "Finally deployment and cicd pipelined done!",
        version: "1.0.0",
        author: "ss",
        date: new Date().toISOString(),
    });
});
// Start server
app.listen(port, () => {
  console.log(`🚀 Server running at http://localhost:${port}`);
});
