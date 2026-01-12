Feature: Books

        Background:
                # Base URL e basePath
                * def baseUrl = 'https://bookstore.toolsqa.com'
                * def basePath = 'BookStore/v1'

                # Chama create-user + generate-token apenas uma vez
                * def auth = callonce read('classpath:features/users/generate-token.feature')
                * def token = auth.token
                * def userID = auth.userId
                * print 'Token:', token
                * print 'UserID:', userID

        @smoke
        Scenario: Create a new book using ISBN do primeiro livro existente
                Given url baseUrl
                And path basePath + '/Books'
                And header Authorization = 'Bearer ' + token
                When method get
                Then status 200
               

                * def firstISBN = response.books[0].isbn
                

                * def bodyFile = {'userId': '#(userID)', "collectionOfIsbns": [{"isbn": '#(firstISBN)'}]}

                Given path basePath + '/Books'
                And header Authorization = 'Bearer ' + token
                And request bodyFile
                When method post
                Then status 201


        @smoke
        Scenario: List book by ISBN
                Given url baseUrl
                And path basePath + '/Books'
                And header Authorization = 'Bearer ' + token
                When method get
                Then status 200
                

                * def firstISBN = response.books[0].isbn
                

                Given path basePath + '/Book'
                And param ISBN = firstISBN
                And header Authorization = 'Bearer ' + token
                When method get
                Then status 200
                

        @smoke
        Scenario: Update existing book
                Given url baseUrl
                And path basePath + '/Books'
                And header Authorization = 'Bearer ' + token
                When method get
                Then status 200
                

                * def firstISBN = response.books[0].isbn
                

                * def secondIsbn = response.books[1].isbn
                

                Given path basePath + '/Books', firstISBN
                And header Authorization = 'Bearer ' + token
                And request { userId: "#(userID)", isbn: "#(secondIsbn)" }
                When method put
                Then status 200
                

        @smoke
        Scenario: List all books
                Given url baseUrl
                And path basePath + '/Books'
                And header Authorization = 'Bearer ' + token
                When method get
                Then status 200
                

        @smoke
        Scenario: List invalid ISBN book
                * def invalidIsbn = '3782n39n93'

                Given url baseUrl
                And path basePath + '/Book'
                And param ISBN = invalidIsbn
                And header Authorization = 'Bearer ' + token
                When method get
                Then status 400
                

        @smoke
        Scenario: Create a new book with invalid userId
                * def invalidUserId = 'abc'
                * def invalidIsbn = '9xc862'

                Given url baseUrl
                And path basePath + '/Books'
                And header Authorization = 'Bearer ' + token
                And request {userId: '#(invalidUserId)', collectionOfIsbns:[{isbn:"#(invalidIsbn)"}]}
                When method post
                Then status 401



