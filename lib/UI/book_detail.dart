import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_books_api/models/book.dart';
import 'package:http/http.dart' as http;

class BookDetail extends StatefulWidget {
  final Book book;

  BookDetail({required this.book});

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  late Book _book;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _book = widget.book;
    _getbookDetail();
  }

  _getbookDetail() async {
    setState(() {
      isLoading = true;
    });

    try {
      var url =
          Uri.parse("https://www.googleapis.com/books/v1/volumes/${_book.id}");
      var responce = await http.get(url);
      var json = jsonDecode(responce.body);
      setState(() {
        _book = Book.fromjson(json);
      });
    } catch (e) {
      setState(() {
        _book = widget.book;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_book.volumeInfo?.title ?? ""),
      ),
      body: Center(
        child: Image.network(_book.volumeInfo?.imageLinks?.thumbnail ?? ""),
      ),
    );
  }
}
