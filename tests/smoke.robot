*** Settings ***
Documentation       Smoke tests for the Tricentis Demo Web Shop. No user account needed.
Resource            ../resources/common.resource
Resource            ../resources/pages/header.resource
Resource            ../resources/pages/search.resource
Resource            ../resources/pages/category.resource
Resource            ../resources/pages/cart.resource

Suite Setup         Start Browser
Suite Teardown      Stop Browser
Test Setup          Open Shop As New Guest
Test Tags           smoke


*** Test Cases ***
Home Page Loads
    Get Title    ==    Demo Web Shop
    Logo Should Be Visible
    Top Menu Should Contain    Books    Computers    Electronics    Apparel & Shoes
    ...    Digital downloads    Jewelry    Gift Cards
    Get Element Count    css=.home-page-product-grid .product-item    >    0
    Cart Quantity Should Be    0

Search Finds Matching Products
    Search For    computer
    Search Results Count Should Be    4
    Every Search Result Should Contain    computer

Search With No Matches Shows Message
    Search For    zzzqqq
    No Results Message Should Be Shown

Category Page Can Be Sorted By Price
    Open Category From Top Menu    Books
    Category Page Should Be Open    Books
    Product Count Should Be    6
    Sort Products By    Price: Low to High
    Product Prices Should Be In Ascending Order

Guest Can Add Book To Cart
    Open Category From Top Menu    Books
    Add Product To Cart    Computing and Internet
    Added To Cart Notification Should Be Shown
    Cart Quantity Should Be    1
    Open Cart
    Cart Page Should Be Open
    Cart Should Contain Only    Computing and Internet
