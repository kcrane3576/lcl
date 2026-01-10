import { defineConfig } from "@playwright/test";

export default defineConfig({
  testDir: "./tests",
  timeout: 30_000,
  use: {
    // Key requirement:
    // - screenshot only on failure (proves the mechanism)
    screenshot: "only-on-failure",
    trace: "retain-on-failure",
    video: "off"
  },

  // Put all artifacts in a predictable directory
  // outputDir: "/results/tests/playwright-test-results",
  outputDir: process.env.PLAYWRIGHT_TEST_RESULTS_DIR || "playwright-test-results",


  // Only run these browsers (no WebKit)
  projects: [
    {
      name: "chromium",
      use: {
        browserName: "chromium"
      }
    },
    {
      name: "firefox",
      use: {
        browserName: "firefox"
      }
    }
  ],

  // Keep CI output readable
  reporter: [["list"]]
});
