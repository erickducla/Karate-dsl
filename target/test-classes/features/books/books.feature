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
                * print 'Total de livros disponíveis:', response.books.length

                * def firstISBN = response.books[0].isbn
                * print 'ISBN do primeiro livro:', firstISBN
                * karate.set('isbnCreated', firstISBN)

                * def bodyFile = read('classpath:features/books/booksData/create-books.json')
                * set bodyFile.userID = userID
                * set bodyFile.collectionOfIsbns[0].isbn = firstISBN
                * print 'Body final para criar livro:', bodyFile

            Given url baseUrl
              And path basePath + '/Books'
              And header Authorization = 'Bearer ' + token
              And request bodyFile
             When method post
             Then status 201
                * print 'Livro adicionado ao usuário com sucesso:', bodyFile.collectionOfIsbns[0].isbn


        @smoke
        Scenario: List book by ISBN
            Given url baseUrl
              And path basePath + '/Book'
              And param ISBN = isbnCreated
              And header Authorization = 'Bearer ' + token
             When method get
             Then status 200
                * print 'Livro encontrado:', response.title

        @smoke
        Scenario: Update existing book
                * def updateISBN = '9781449331818'
            Given url baseUrl
              And path basePath + '/Book'
              And param ISBN = isbnCreated
              And header Authorization = 'Bearer ' + token
              And request { userID: "#(userID)", isbn: "#(updateISBN)" }
             When method put
             Then status 200
                * print 'Livro atualizado:', response.title

        @smoke
        Scenario: List all books
            Given url baseUrl
              And path basePath + '/Books'
              And header Authorization = 'Bearer ' + token
             When method get
             Then status 200
                * print 'Total de livros retornados:', response.books.length

        @smoke
        Scenario: List invalid ISBN book
                * def invalidIsbn = '3782n39n93'

            Given url baseUrl
              And path basePath + '/Book'
              And param ISBN = invalidIsbn
              And header Authorization = 'Bearer ' + token
             When method get
             Then status 400
                * print 'Resposta da API:', response

        @smoke
        Scenario: Create a new book with no userId
            Given url baseUrl
              And path basePath + '/Books'
              And header Authorization = 'Bearer ' + token
              And request { collectionOfIsbns:[{isbn:"9781449325862"}]}
             When method post
             Then status 400
                * print 'Livro adicionado ao usuário com sucesso:', bodyFile.collectionOfIsbns[0].isbn



