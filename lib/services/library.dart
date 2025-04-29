import '../models/book.dart';

class Library {
  final List<Book> _books = [];

  void addBook(Book book) {
    _books.add(book);
  }

  void borrowBook(String title) {
    for (var book in _books) {
      if (book.title == title && book.isAvailable) {
        book.isAvailable = false;
        break;
      }
    }
  }

  List<Book> getAvailableBooks() {
    return _books.where((b) => b.isAvailable).toList();
  }

  List<Book> getBorrowedBooks() {
    return _books.where((b) => !b.isAvailable).toList();
  }

  // Surcharge opérateur + pour fusionner deux bibliothèques
  Library operator +(Library other) {
    var newLibrary = Library();
    newLibrary._books.addAll(_books);
    newLibrary._books.addAll(other._books);
    return newLibrary;
  }
}
