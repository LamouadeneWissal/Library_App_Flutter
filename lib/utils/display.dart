import '../models/book.dart';

void displayBooks(List <Book> books) {
  for (var book in books){
    print("Titre : ${book.title}, Auteur : ${book.author}, Annee : ${book.year}");
  }
}