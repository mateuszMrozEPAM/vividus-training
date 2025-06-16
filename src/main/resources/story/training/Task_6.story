Meta:
    @group Training
    @requirementId MyTask-0006

Lifecycle:
Examples:
/story/input/User.table

Scenario: Navigate to the website homepage
Given I navigate to the SauceDemo website homepage
 
Scenario: Log In
Given I navigate to the SauceDemo website homepage
When I log in as a user with username: <userName> and password: secret_sauce
When I wait until number of elements located by `xpath(//div[@class='inventory_item'])` is equal to 6

Scenario: Add item to the shopping cart
Given I navigate to the SauceDemo website homepage
When I log in as a user with username: standard_user and password: secret_sauce
When I wait until number of elements located by `xpath(//div[@class='inventory_item'])` is equal to 6
When I click on element located by `xpath(//div[contains(text(), "<itemName>")] )`
Then `${current-page-url}` is equal to `<itemPageId>`
When I click on element located by `xpath(<addToCartButtonId>)`
When I wait until element located by `xpath(//span[contains(@class, "shopping_cart_badge")])` appears
When I change context to element located by `xpath(//span[contains(@class, "shopping_cart_badge")])`
Then text matches `<addedItems>`
Examples:
|itemName                  |itemPageId                                           | addToCartButtonId                             |  addedItems  |
|Sauce Labs Backpack      | https://www.saucedemo.com/inventory-item.html?id=4   |   //button[contains(text(), "Add to cart")]   |  1           |
|Sauce Labs Bike Light    | https://www.saucedemo.com/inventory-item.html?id=0  |   //button[contains(text(), "Add to cart")]   |   2           |
|Sauce Labs Bolt T-Shirt  | https://www.saucedemo.com/inventory-item.html?id=1  |   //button[contains(text(), "Add to cart")]   |   3           |
 
Scenario: Validate the num of items in the shopping cart
Given I navigate to the SauceDemo website homepage
When I log in as a user with username: standard_user and password: secret_sauce
When I wait until number of elements located by `xpath(//div[@class='inventory_item'])` is equal to 6
When I click on element located by `xpath(//button[contains(@id, "sauce-labs-bike-light")])`
When I click on element located by `xpath(//button[contains(@id, "sauce-labs-backpack")])`
When I wait until element located by `xpath(//span[contains(@class, "shopping_cart_badge")])` appears
When I click on element located by `xpath(//a[contains(@class, "shopping_cart_link")])`
When I wait until number of elements located by `xpath(//div[@class = 'cart_item'])` is equal to 1
 
Scenario: Log Out
Given I navigate to the SauceDemo website homepage
When I log in as a user with username: standard_user and password: secret_sauce
When I wait until number of elements located by `xpath(//div[@class='inventory_item'])` is equal to 6
When I click on element located by `xpath(//button[contains(@id, "sauce-labs-bike-light")])`
When I click on element located by `xpath(//button[contains(@id, "menu-btn")])`
When I click on element located by `xpath(//a[contains(@id, "reset_sidebar_link")])`
When I click on element located by `xpath(//a[contains(@id, "logout_sidebar_link")])`
When I wait until element located by `xpath(//input[contains(@value, "Login")])` appears
Then `${current-page-url}` is equal to `https://www.saucedemo.com/`
