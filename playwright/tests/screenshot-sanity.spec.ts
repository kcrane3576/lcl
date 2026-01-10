import { test, expect } from "@playwright/test";
import fs from "fs";
import path from "path";

test("SANITY: evidence capture works (no video)", async ({ page }, testInfo) => {
  const logs: string[] = [];

  page.on("console", (msg) => {
    // keep only errors (or include warn/info if you want)
    if (msg.type() === "error") {
      logs.push(`[console.error] ${msg.text()}`);
    }
  });

  page.on("pageerror", (err) => {
    logs.push(`[pageerror] ${err.name}: ${err.message}\n${err.stack ?? ""}`);
  });

  await page.goto("https://example.com");

  // Generate a console error (captured)
  await page.evaluate(() => console.error("SANITY console error"));

  // Generate a pageerror (captured)
  await page.evaluate(() => {
    throw new Error("SANITY page error");
  });

  // Write the log file into this test’s artifact folder
  fs.mkdirSync(testInfo.outputDir, { recursive: true });
  fs.writeFileSync(
    path.join(testInfo.outputDir, "runtime-errors.log"),
    logs.join("\n") + "\n",
    "utf8"
  );

  // Intentionally wrong expectation to force failure:
  // - screenshot ("only-on-failure")
  // - trace ("retain-on-failure")
  await expect(page).toHaveTitle("THIS TITLE IS INTENTIONALLY WRONG");
});

