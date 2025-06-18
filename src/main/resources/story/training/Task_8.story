Meta:
    @group Training
    @requirementId MyTask-0008

Scenario: Navigate to the website homepage
Given I navigate to the SauceDemo website homepage

Scenario: Log In
Given I navigate to the SauceDemo website homepage
When I log in as a user with username: standard_user and password: secret_sauce
When I wait until number of elements located by `xpath(//div[@class='inventory_item'])` is equal to 6

Scenario: Add items to the shopping cart
Given I navigate to the SauceDemo website homepage
When I log in as a user with username: standard_user and password: secret_sauce
When I wait until number of elements located by `xpath(//div[@class='inventory_item'])` is equal to 6
When I click on element located by `xpath(//div[contains(text(), "<itemName>")] )`
Then `${current-page-url}` is equal to `<itemPageId>`
When I click on element located by `xpath(<addToCartButtonId>)`
When I wait until element located by `xpath(//span[contains(@class, "shopping_cart_badge")])` appears
When I change context to element located by `xpath(//span[contains(@class, "shopping_cart_badge")])`
Then text matches `1`
When I click on element located by `xpath(//button[contains(@id, "menu-btn")])`
When I click on element located by `xpath(//a[contains(@id, "reset_sidebar_link")])`
Examples:
|itemName                  |itemPageId                                           | addToCartButtonId                             |
|Sauce Labs Backpack      | https://www.saucedemo.com/inventory-item.html?id=4   |   //button[contains(text(), "Add to cart")]   |
|Sauce Labs Bike Light    | https://www.saucedemo.com/inventory-item.html?id=0  |   //button[contains(text(), "Add to cart")]   |
|Sauce Labs Bolt T-Shirt  | https://www.saucedemo.com/inventory-item.html?id=1  |   //button[contains(text(), "Add to cart")]   |

Scenario: Populate checkout data
Given I initialize story variable `testFirstName` with value `#{generate(Name.firstName)}`
And I initialize story variable `testLastName` with value `#{generate(Name.lastName)}`
And I initialize story variable `testPostalCode` with value `#{generate(bothify '???-#####')}`
Given I navigate to the SauceDemo website homepage
When I log in as a user with username: standard_user and password: secret_sauce
When I wait until number of elements located by `xpath(//div[@class='inventory_item'])` is equal to 6
When I click on element located by `xpath(//button[contains(@id, "sauce-labs-bike-light")])`
When I click on element located by `xpath(//button[contains(@id, "sauce-labs-backpack")])`
When I click on element located by `xpath(//a[@class = 'shopping_cart_link'])`
When I click on element located by `xpath(//button[contains(@id, "checkout")])`
When I add `${testFirstName}` to field located by `xpath(//input[@id = 'first-name'])`
When I add `${testLastName}` to field located by `xpath(//input[@id = 'last-name'])`
When I add `#{toUpperCase(${testPostalCode})}` to field located by `xpath(//input[@id = 'postal-code'])`
When I click on element located by `xpath(//input[@id = 'continue'])`
When I wait until element located by `xpath(//span[contains(text(), "Checkout: Overview")])` appears
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-step-two.html`
When I take screenshot
When I click on element located by `xpath(//button[contains(@id, "menu-btn")])`
When I click on element located by `xpath(//a[contains(@id, "reset_sidebar_link")])`

Scenario: Validate order summary and complete order
Given I initialize story variable `testFirstName` with value `#{generate(Name.firstName)}`
And I initialize story variable `testLastName` with value `#{generate(Name.lastName)}`
And I initialize story variable `testPostalCode` with value `#{generate(bothify '???-#####')}`
Given I navigate to the SauceDemo website homepage
When I log in as a user with username: standard_user and password: secret_sauce
When I wait until number of elements located by `xpath(//div[@class='inventory_item'])` is equal to 6
When I click on element located by `xpath(//button[contains(@id, "sauce-labs-bike-light")])`
When I click on element located by `xpath(//button[contains(@id, "sauce-labs-backpack")])`
When I click on element located by `xpath(//a[@class = 'shopping_cart_link'])`
When I click on element located by `xpath(//button[contains(@id, "checkout")])`
When I add `${testFirstName}` to field located by `xpath(//input[@id = 'first-name'])`
When I add `${testLastName}` to field located by `xpath(//input[@id = 'last-name'])`
When I add `#{toUpperCase(${testPostalCode})}` to field located by `xpath(//input[@id = 'postal-code'])`
When I click on element located by `xpath(//input[@id = 'continue'])`
When I wait until element located by `xpath(//span[contains(text(), "Checkout: Overview")])` appears
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-step-two.html`
When I click on element located by `xpath(//button[@id = 'finish'])`
When I wait until element located by `xpath(//span[contains(text(), "Checkout: Complete!")])` appears
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-complete.html`
When I take screenshot
When I click on element located by `xpath(//button[contains(@id, "menu-btn")])`
When I click on element located by `xpath(//a[contains(@id, "reset_sidebar_link")])`
