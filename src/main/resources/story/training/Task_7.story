Meta:
    @group Training
    @requirementId MyTask-0007

Scenario: Initialize variables
Given I initialize story variable `testFirstName` with value `#{generate(regexify '[a-zA-Z]{5}'))}`
And I initialize story variable `testLastName` with value `#{generate(regexify '[a-zA-Z]{5}'))}`
And I initialize story variable `testPostalCode` with value `#{generate(bothify '???-#####')}`
And I initialize story variable `savedMessage` with value `#{loadResource(/data/message.txt)}`

Scenario: Navigate to the website homepage
Given I navigate to the SauceDemo website homepage

Scenario: Log In
When I log in as a user with username: standard_user and password: secret_sauce
When I wait until number of elements located by `xpath(//div[@class='inventory_item'])` is equal to 6

Scenario: Add item to the shopping cart
When I click on element located by `xpath(//div[contains(text(), "<itemName>")] )`
Then `${current-page-url}` is equal to `<itemPageId>`
When I click on element located by `xpath(//button[@id = 'back-to-products'])`
When I click on element located by `xpath(<addToCartButtonId>)`
When I wait until element located by `xpath(//span[contains(@class, "shopping_cart_badge")])` appears
When I change context to element located by `xpath(//span[contains(@class, "shopping_cart_badge")])`
Then text matches `<addedItemsCount>`
When I refresh page
Examples:
|itemName                  |itemPageId                                           | addToCartButtonId                                        |  addedItemsCount |
|Sauce Labs Backpack      | https://www.saucedemo.com/inventory-item.html?id=4   |   //button[@id = 'add-to-cart-sauce-labs-backpack']      |  1               |
|Sauce Labs Bike Light    | https://www.saucedemo.com/inventory-item.html?id=0  |   //button[@id = 'add-to-cart-sauce-labs-bike-light']     |   2               |
|Sauce Labs Bolt T-Shirt  | https://www.saucedemo.com/inventory-item.html?id=1  |   //button[@id = 'add-to-cart-sauce-labs-bolt-t-shirt']   |   3               |

Scenario: Populate checkout data
When I click on element located by `xpath(//a[@class = 'shopping_cart_link'])`
When I click on element located by `xpath(//button[contains(@id, "checkout")])`
When I add `${testFirstName}` to field located by `xpath(//input[@id = 'first-name'])`
When I add `${testLastName}` to field located by `xpath(//input[@id = 'last-name'])`
When I add `#{toUpperCase(${testPostalCode})}` to field located by `xpath(//input[@id = 'postal-code'])`
When I take screenshot

Scenario: Complete checkout process
When I click on element located by `xpath(//input[@id = 'continue'])`
When I wait until element located by `xpath(//span[contains(text(), "Checkout: Overview")])` appears
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-step-two.html`
When I take screenshot
When I click on element located by `xpath(//button[@id = 'finish'])`
When I wait until element located by `xpath(//span[contains(text(), "Checkout: Complete!")])` appears
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-complete.html`
When I save text of element located by `xpath(//h2[@class = 'complete-header'])` to scenario variable `messageText`
Then `${messageText}` is equal to `${savedMessage}`
When I take screenshot
