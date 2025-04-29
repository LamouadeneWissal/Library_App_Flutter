import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/library.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final Library _library = Library();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Add some initial books
    _library.addBook(Book.available('Le Petit Prince', 'Antoine de Saint-Exupéry', 1943));
    _library.addBook(Book('Unavailable Book', 'Unknown', 2000, false));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Book> get availableBooks => _library.getAvailableBooks();
  List<Book> get borrowedBooks => _library.getBorrowedBooks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📚 My Library App'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Available Books'),
            Tab(text: 'Borrowed Books'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBooksList(availableBooks, availableTab: true),
          _buildBooksList(borrowedBooks, availableTab: false),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBookDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBooksList(List<Book> books, {required bool availableTab}) {
    if (books.isEmpty) {
      return const Center(child: Text('No books here yet 🥲'));
    }
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        var book = books[index];
        return ListTile(
          leading: Icon(availableTab ? Icons.book : Icons.bookmark_remove),
          title: Text(book.title),
          subtitle: Text('Author: ${book.author} (${book.year})'),
          trailing: IconButton(
            icon: Icon(
              availableTab ? Icons.check_circle_outline : Icons.undo,
              color: availableTab ? Colors.green : Colors.blue,
            ),
            onPressed: () {
              setState(() {
                book.isAvailable = !book.isAvailable;
              });
            },
          ),
        );
      },
    );
  }

  void _showAddBookDialog() {
    String title = '';
    String author = '';
    int year = DateTime.now().year;
    bool isAvailable = true;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Book 📖'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  onChanged: (value) => title = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Author'),
                  onChanged: (value) => author = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Year'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => year = int.tryParse(value) ?? DateTime.now().year,
                ),
                SwitchListTile(
                  title: const Text('Available?'),
                  value: isAvailable,
                  onChanged: (value) {
                    setState(() {
                      isAvailable = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text('Add Book'),
              onPressed: () {
                setState(() {
                  if (isAvailable) {
                    _library.addBook(Book.available(title, author, year));
                  } else {
                    _library.addBook(Book(title, author, year, false));
                  }
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
