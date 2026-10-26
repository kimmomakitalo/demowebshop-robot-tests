*** Settings ***
Documentation       Header area shown on every page: logo, search box, cart link, top menu.
Library             Browser


*** Variables ***
${LOGO}             css=.header-logo img
${SEARCH_INPUT}     id=small-searchterms
${SEARCH_BUTTON}    css=input.search-box-button
${CART_LINK}        css=#topcartlink > a
${CART_QTY}         css=#topcartlink .cart-qty
${TOP_MENU}         css=ul.top-menu


*** Keywords ***
Logo Should Be Visible
    Wait For Elements State    ${LOGO}    visible

Search For
    [Arguments]    ${term}
    Fill Text    ${SEARCH_INPUT}    ${term}
    Click    ${SEARCH_BUTTON}

Cart Quantity Should Be
    [Arguments]    ${expected}
    Get Text    ${CART_QTY}    ==    (${expected})

Open Cart
    Click    ${CART_LINK}

Top Menu Should Contain
    [Arguments]    @{categories}
    FOR    ${category}    IN    @{categories}
        Wait For Elements State    ${TOP_MENU} > li > a >> text="${category}"    visible
    END

Open Category From Top Menu
    [Arguments]    ${category}
    Click    ${TOP_MENU} > li > a >> text="${category}"
