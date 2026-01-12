Feature: Users

        Background:
                * def baseUrl = 'https://bookstore.toolsqa.com'
                * def basePath = 'Account/v1'
                * def auth = callonce read('classpath:features/users/generate-token.feature')
                * def userId = auth.userId
                * def token = auth.token

        @smoke
        Scenario: Create Fails user
                * def bodyRequest = read('classpath:features/users/usersData/create-fail-user.json')

            Given url baseUrl
              And path basePath + '/User'
              And request bodyRequest
             When method post
             Then status 400
             And match response.message == "Passwords must have at least one non alphanumeric character, one digit ('0'-'9'), one uppercase ('A'-'Z'), one lowercase ('a'-'z'), one special character and Password must be eight characters or longer."

        @smoke
        Scenario: Delete user

            Given url baseUrl
              And path basePath + '/User'
              And param UUID = userId
             When method delete
             Then status 200