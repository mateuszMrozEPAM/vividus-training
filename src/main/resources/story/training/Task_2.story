GivenStories: story/demo/Homepage_Demo.story

Scenario: Log in as a Good User

Given I am on main application page
When I wait until element located by `caseSensitiveText(Swag Labs)` appears
Then `${current-page-url}` is equal to `https://www.saucedemo.com/`
When I add `standard_user` to field located by `id(user-name)`
When I add `secret_sauce` to field located by `id(password)`
When I click on element located by `name(login-button)`
When I wait until element located by `caseSensitiveText(Products)` appears
Then `${current-page-url}` is equal to `https://www.saucedemo.com/inventory.html`
When I wait until number of elements located by `xpath(//div[@class='inventory_item'])` is equal to 6
When I take screenshot