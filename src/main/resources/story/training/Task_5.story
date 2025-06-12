Scenario: Navigate to the website homepage
Given I navigate to the SauceDemo website homepage

Scenario: Log in as Locked User
Given I navigate to the SauceDemo website homepage
When I log in as a user with username: locked_out_user and password: secret_sauce
When I wait until number of elements located by `xpath(//div[@class='inventory_item'])` is equal to 6
 