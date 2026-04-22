# Tera's Library Database

A personal MySQL database built to catalog and manage a personal book collection of over 1,000 books. The primary goal is to prevent duplicate purchases while also tracking reading history, ratings, and book details.

---

## Why I Built This

With a collection of over a thousand books, it became difficult for my husband and I to keep track of what we already owned. This database solves that problem by providing a searchable catalog with full book details, series tracking, and a reading log.

---

## Features

- Track books by title, ISBN, publisher, publication year, and format (hardback/paperback)
- Support for multiple authors per book
- Support for multiple genres per book
- Series tracking with book order within a series
- Reading log with start date, finish date, rating, and notes
- Re-read tracking — the same book can be logged multiple times
- Analytical queries for reading habits and collection stats

---

## Database Schema

| Table | Description |
|-------|-------------|
| `books` | Core book records — ISBN, title, publisher, publication year, format, series |
| `authors` | Author names with unique constraint |
| `book_authors` | Junction table linking books to one or more authors, with author order |
| `genres` | Genre names with unique constraint |
| `book_genres` | Junction table linking books to one or more genres |
| `publishers` | Publisher names with unique constraint |
| `series` | Series names with unique constraint |
| `reading_log` | Log of each time a book was read, including dates, rating, and notes |

---

## Key Design Decisions

**Many-to-many for genres:** Books often span multiple genres (e.g., Young Adult + Dystopian + Science Fiction). Rather than storing a single genre on the book, a `book_genres` junction table allows each book to have as many genres as needed.

**Many-to-many for authors:** Some books have co-authors. The `book_authors` junction table handles this, including an `author_order` column to preserve the order authors are listed on the cover.

**Series as a separate table:** Series names are stored in their own table and linked to books via a foreign key, along with a `series_number` column to track the order within a series. Books not part of a series simply have a NULL `series_id`.

**Reading log supports re-reads:** Each read of a book is stored as a separate row in `reading_log`, so books read multiple times are tracked naturally without any special handling.

**Iterative development:** The schema evolved over time. The database originally stored `genre_id` and `author_id` directly on the `books` table. As the collection grew it became clear that both needed to support multiple values, so both were migrated to junction tables. This process is documented in the project's SQL file.

---

## Sample Queries

**See all books ordered by title:**
```sql
SELECT 
    b.isbn,
    b.title,
    GROUP_CONCAT(DISTINCT a.author_name ORDER BY ba.author_order SEPARATOR ', ') AS authors,
    b.book_type,
    GROUP_CONCAT(DISTINCT g.genre_name ORDER BY g.genre_name SEPARATOR ', ') AS genres,
    p.publisher_name,
    b.publication_year,
    s.series_name,
    b.series_number
FROM books b
LEFT JOIN book_authors ba ON b.isbn = ba.book_isbn
LEFT JOIN authors a ON ba.author_id = a.author_id
JOIN publishers p ON b.publisher_id = p.publisher_id
LEFT JOIN series s ON b.series_id = s.series_id
LEFT JOIN book_genres bg ON b.isbn = bg.book_isbn
LEFT JOIN genres g ON bg.genre_id = g.genre_id
GROUP BY b.isbn, b.title, b.book_type, p.publisher_name, 
         b.publication_year, s.series_name, b.series_number
ORDER BY b.title;
```

**Books I have not read yet:**
```sql
SELECT 
    b.title,
    GROUP_CONCAT(DISTINCT a.author_name ORDER BY ba.author_order SEPARATOR ', ') AS authors,
    s.series_name,
    b.series_number
FROM books b
LEFT JOIN book_authors ba ON b.isbn = ba.book_isbn
LEFT JOIN authors a ON ba.author_id = a.author_id
LEFT JOIN series s ON b.series_id = s.series_id
LEFT JOIN reading_log rl ON b.isbn = rl.book_isbn
WHERE rl.log_id IS NULL
GROUP BY b.isbn, b.title, b.book_type, s.series_name, b.series_number
ORDER BY s.series_name, b.series_number, b.title;
```

**Books read more than once:**
```sql
SELECT 
    b.title,
    GROUP_CONCAT(DISTINCT a.author_name ORDER BY ba.author_order SEPARATOR ', ') AS authors,
    COUNT(rl.log_id) AS times_read,
    MAX(rl.date_finished) AS last_finished
FROM reading_log rl
JOIN books b ON rl.book_isbn = b.isbn
LEFT JOIN book_authors ba ON b.isbn = ba.book_isbn
LEFT JOIN authors a ON ba.author_id = a.author_id
GROUP BY b.isbn, b.title
HAVING COUNT(rl.log_id) > 1
ORDER BY times_read DESC;
```

**Most read genres:**
```sql
SELECT 
    g.genre_name,
    COUNT(DISTINCT b.isbn) AS book_count
FROM books b
LEFT JOIN book_genres bg ON b.isbn = bg.book_isbn
LEFT JOIN genres g ON bg.genre_id = g.genre_id
WHERE g.genre_name IS NOT NULL
GROUP BY g.genre_name
ORDER BY book_count DESC;
```

---

## Technologies Used

- MySQL 8.0

---

## Project Status

Active — books and reading log entries are added on an ongoing basis.
