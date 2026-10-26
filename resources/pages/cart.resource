*** Settings ***
Documentation       Shopping cart page (/cart).
Library             Browser


*** Variables ***
${CART_ROWS}            css=table.cart tbody tr
${CART_PRODUCT_NAMES}   css=table.cart .product-name


*** Keywords ***
Cart Page Should Be Open
    Get Url    contains    /cart

Cart Should Contain Only
    [Arguments]    ${product}
    Get Element Count    ${CART_ROWS}    ==    1
    Get Text    ${CART_PRODUCT_NAMES}    ==    ${product}
