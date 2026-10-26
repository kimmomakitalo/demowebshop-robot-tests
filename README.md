# Demo Web Shop – Robot Framework smoke tests

UI smoke tests for https://demowebshop.tricentis.com/ using Robot Framework and the
Browser library (Playwright). No user account is needed.

## Setup (one time)

```powershell
python -m pip install -r requirements.txt
rfbrowser init chromium
```

## Run

```powershell
.\run.ps1                              # all tests, headless
.\run.ps1 --variable HEADLESS:False    # watch the browser
.\run.ps1 --test "Home Page Loads"     # one test
.\run.ps1 --include smoke              # by tag
```

## Results

Open `results\report.html` for the summary and `results\log.html` for step-by-step
details. Failed tests get a screenshot automatically in the log.

## Structure

| Path | Purpose |
|---|---|
| `tests/smoke.robot` | Test cases |
| `resources/common.resource` | Browser setup/teardown, base URL, timeouts |
| `resources/pages/*.resource` | Locators and keywords per page (header, search, category, cart) |
