*** Settings ***
Documentation       Search results page (/search).
Library             Browser
Library             String


*** Variables ***
${RESULT_TITLES}        css=.search-results .product-item .product-title a
${NO_RESULTS_TEXT}      css=.search-results .result


*** Keywords ***
Search Results Count Should Be
    [Arguments]    ${expected}
    Get Element Count    ${RESULT_TITLES}    ==    ${expected}

Every Search Result Should Contain
    [Arguments]    ${term}
    ${titles}=    Get Elements    ${RESULT_TITLES}
    FOR    ${title}    IN    @{titles}
        ${text}=    Get Text    ${title}
        ${text}=    Convert To Lower Case    ${text}
        ${term}=    Convert To Lower Case    ${term}
        Should Contain    ${text}    ${term}
    END

No Results Message Should Be Shown
    Get Text    ${NO_RESULTS_TEXT}    contains    No products were found that matched your criteria.
    Get Element Count    ${RESULT_TITLES}    ==    0
