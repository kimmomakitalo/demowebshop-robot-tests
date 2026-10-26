*** Settings ***
Documentation       Shared settings, browser setup and teardown.
Library             Browser


*** Variables ***
${BASE_URL}         https://demowebshop.tricentis.com
${BROWSER}          chromium
${HEADLESS}         True
${TIMEOUT}          15s


*** Keywords ***
Start Browser
    [Documentation]    Suite setup: one browser process for the whole suite (saves CPU/RAM).
    Set Browser Timeout    ${TIMEOUT}
    New Browser    ${BROWSER}    headless=${HEADLESS}

Open Shop As New Guest
    [Documentation]    Test setup: a fresh context = clean cookies, so every test starts with an empty cart.
    New Context    viewport={'width': 1280, 'height': 900}
    New Page    ${BASE_URL}

Stop Browser
    Close Browser    ALL
