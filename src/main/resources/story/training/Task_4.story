Scenario: Navigate to the website homepage
Given I navigate to the SauceDemo website homepage

Scenario: Log in as a User
Given I navigate to the SauceDemo website homepage
When I log in as a user with username: standard_user and password: secret_sauce and COMPARE_AGAINST baselinePicture with diff percentage: 5

Scenario: Log in as a broken User
Given I navigate to the SauceDemo website homepage
When I log in as a user with username: problem_user and password: secret_sauce and COMPARE_AGAINST baselinePicture with diff percentage: 11