package features.books;

import com.intuit.karate.junit5.Karate;

public class BooksRunner {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("books").relativeTo(getClass());
    }
}
