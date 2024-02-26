import 'package:google_books_api/models/volume_info.dart';

class Book {
  String? id;
  VolumeInfo? volumeInfo;

  Book({this.volumeInfo});

  factory Book.fromjson(Map<String, dynamic> json) {
    var bookParsed = Book();
    bookParsed.id = json['id'];
    bookParsed.volumeInfo = VolumeInfo.fromjson(json['volumeInfo']);

    return bookParsed;
  }
}
