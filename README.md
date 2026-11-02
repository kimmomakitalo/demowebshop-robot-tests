# Demo Web Shop – Robot Framework smoke tests

[![Smoke tests](https://github.com/kimmomakitalo/demowebshop-robot-tests/actions/workflows/smoke.yml/badge.svg)](https://github.com/kimmomakitalo/demowebshop-robot-tests/actions/workflows/smoke.yml)

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

### Parallel run (pabot)

```powershell
$env:PYTHONIOENCODING = 'utf-8'
pabot --processes 4 --testlevelsplit --outputdir results tests
```

Measured on a 4-core Intel N95 (headless): sequential 16 s, pabot ×2 22 s, pabot ×4 18 s.
Each pabot process starts its own Playwright server and browser, so with a suite this short
the startup cost outweighs the gain. CI therefore runs sequentially; pabot pays off once the
suite takes minutes.

## Results

Open `results\report.html` for the summary and `results\log.html` for step-by-step
details. Failed tests get a screenshot automatically in the log.

## Continuous integration (Jenkins)

The [Jenkinsfile](Jenkinsfile) defines a declarative pipeline that:

1. Checks GitHub for new commits every ~5 minutes (`pollSCM`) and runs on any change.
2. Installs the dependencies from `requirements.txt`.
3. Runs the suite headless, optionally filtered by the `INCLUDE_TAG` build parameter.
4. Publishes the results with the Robot Framework plugin: 100 % pass = success,
   80–99 % = unstable, below 80 % = failure. Failure screenshots are archived with the results.

Requirements for the Jenkins agent: Windows, Python with the packages above installed and
`rfbrowser init chromium` run once, and the
[Robot Framework plugin](https://plugins.jenkins.io/robot/). To make `log.html` and
`report.html` render inside Jenkins, start Jenkins with
`-Dhudson.model.DirectoryBrowserSupport.CSP=` (only advisable for a local, non-public instance).

## Continuous integration (GitHub Actions)

[.github/workflows/smoke.yml](.github/workflows/smoke.yml) runs the same suite on GitHub's
Ubuntu runners on every push to `main`, on pull requests, and manually from the Actions tab.
The Robot report and log are uploaded as the `robot-results` artifact of each run.

## Structure

| Path | Purpose |
|---|---|
| `tests/smoke.robot` | Test cases |
| `resources/common.resource` | Browser setup/teardown, base URL, timeouts |
| `resources/pages/*.resource` | Locators and keywords per page (header, search, category, cart) |
| `Jenkinsfile` | Jenkins pipeline definition |
| `.github/workflows/smoke.yml` | GitHub Actions workflow |
| `run.ps1` | Local run helper |
