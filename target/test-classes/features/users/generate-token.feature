Feature: Generate user and token

        Background:
                * def baseUrl = 'https://bookstore.toolsqa.com'

        @smoke
        Scenario: Create user and generate token
                * def random = java.util.UUID.randomUUID().toString()
                * def userName = 'user_' + random.substring(0,8)
                * def password = 'Test@12345'

            Given url baseUrl
              And path 'Account/v1/User'
              And request { userName: "#(userName)", password: "#(password)"}
             When method post
             Then status 201
                * def userId = response.userID
                * karate.set('userId', userId)


            Given url baseUrl
              And path 'Account/v1/GenerateToken'
              And request { userName: "#(userName)", password: "#(password)"}
             When method post
             Then status 200
                * karate.set('token', response.token)
