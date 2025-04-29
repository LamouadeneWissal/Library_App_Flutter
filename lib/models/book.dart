class Book {
  String title ; 
  String author; 
  int year ; 
  bool isAvailable;
  
  Book(this.title , this.author , this.year , this.isAvailable);

    Book.available(this.title , this.author , this.year): isAvailable = true;



}