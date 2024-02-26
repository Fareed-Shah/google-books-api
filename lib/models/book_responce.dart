import 'package:google_books_api/models/book.dart';

class BookResponce {
  int? totalItems;
  List<Book>? items;

  BookResponce({this.totalItems, this.items});

  factory BookResponce.fromJson(Map<String, dynamic> json) {
    var bookrResponce = BookResponce();
    bookrResponce.totalItems = json['totalItems'];
    bookrResponce.items = [];

    for (var bookJson in (json['items'] as List<dynamic>)) {
      var bookMap = bookJson as Map<String, dynamic>;
      bookrResponce.items?.add(Book.fromjson(bookMap));
    }

    return bookrResponce;
  }
}
