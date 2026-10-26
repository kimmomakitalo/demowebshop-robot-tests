*** Settings ***
Documentation       Product category pages (/books, /computers, ...).
Library             Browser
Library             Collections


*** Variables ***
${PAGE_TITLE}           css=.page-title h1
${BREADCRUMB_CURRENT}   css=.breadcrumb .current-item
${PRODUCT_ITEMS}        css=.product-grid .product-item
${PRODUCT_PRICES}       css=.product-grid .product-item .actual-price
${SORT_SELECT}          id=products-orderby
${NOTIFICATION_BAR}     id=bar-notification


*** Keywords ***
Category Page Should Be Open
    [Arguments]    ${category}
    Get Text    ${PAGE_TITLE}    ==    ${category}
    # Breadcrumb is uppercased with CSS, so check textContent (raw text) instead of visible text.
    Get Property    ${BREADCRUMB_CURRENT}    textContent    ==    ${category}

Product Count Should Be
    [Arguments]    ${expected}
    Get Element Count    ${PRODUCT_ITEMS}    ==    ${expected}

Sort Products By
    [Documentation]    Selecting a sort option reloads the page with a new URL, so wait for it.
    [Arguments]    ${option}
    ${old_url}=    Get Url
    Select Options By    ${SORT_SELECT}    label    ${option}
    Get Url    !=    ${old_url}
    Get Selected Options    ${SORT_SELECT}    label    ==    ${option}

Product Prices Should Be In Ascending Order
    ${elements}=    Get Elements    ${PRODUCT_PRICES}
    ${prices}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        ${price}=    Convert To Number    ${text}
        Append To List    ${prices}    ${price}
    END
    ${sorted}=    Evaluate    sorted($prices)
    Should Be Equal    ${prices}    ${sorted}    Prices not ascending: ${prices}

Add Product To Cart
    [Arguments]    ${product}
    Click    css=.product-item:has(.product-title a:text-is("${product}")) .product-box-add-to-cart-button

Added To Cart Notification Should Be Shown
    Get Text    ${NOTIFICATION_BAR}    contains    The product has been added to your shopping cart
