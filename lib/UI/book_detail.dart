import 'package:flutter/material.dart';
import 'package:google_books_api/models/book.dart';

class BookDetail extends StatefulWidget {
  final Book book;

  BookDetail({required this.book});

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.book.volumeInfo?.title ?? ""),
      ),
      body: Center(
        child:
            Image.network(widget.book.volumeInfo?.imageLinks?.thumbnail ?? ""),
      ),
    );
  }
}
