import { test as base } from "@playwright/test";
import * as fs from "fs";
import * as path from "path";

export const test = base.extend({
  page: async ({ page }, use, testInfo) => {
    const logs: string[] = [];

    const onConsole = (msg: any) => {
      // Capture errors (and optionally warnings)
      if (msg.type() === "error") {
        logs.push(`[console.${msg.type()}] ${msg.text()}`);
      }
    };

    const onPageError = (err: Error) => {
      logs.push(`[pageerror] ${err.name}: ${err.message}\n${err.stack ?? ""}`);
    };

    page.on("console", onConsole);
    page.on("pageerror", onPageError);

    await use(page);

    // Write logs at end of test (always), or only on failure (your choice)
    const shouldWrite = true; // or: testInfo.status !== testInfo.expectedStatus

    if (shouldWrite) {
      const outDir = testInfo.outputDir; // per-test output folder inside outputDir
      fs.mkdirSync(outDir, { recursive: true });
      fs.writeFileSync(path.join(outDir, "runtime-errors.log"), logs.join("\n") + "\n");
    }

    page.off("console", onConsole);
    page.off("pageerror", onPageError);
  },
});

export { expect } from "@playwright/test";
