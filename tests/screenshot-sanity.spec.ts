import { test, expect } from "@playwright/test";

test("SANITY: screenshot-on-failure produces artifact", async ({ page }) => {
  await page.goto("https://example.com");

  // Intentionally wrong expectation to force a failure.
  // With screenshot: "only-on-failure", Playwright should write a screenshot to test-results/.
  await expect(page).toHaveTitle("THIS TITLE IS INTENTIONALLY WRONG");
});
