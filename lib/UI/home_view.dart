import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_books_api/models/book_responce.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  BookResponce? responce;
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _getbooks();
  }

  _getbooks() async {
    try {
      var url =
          Uri.parse('https://www.googleapis.com/books/v1/volumes?q=flutter');
      var responce = await http.get(url);
      var decodedJson = jsonDecode(responce.body) as Map<String, dynamic>;

      setState(() {
        this.responce = BookResponce.fromJson(decodedJson);
      });
    } catch (e) {
      print(e);
    }
  }

  onSearchPressed(String bookName) async {
    setState(() {
      isLoading = true;
    });
    try {
      var url =
          Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$bookName');
      var responce = await http.get(url);
      var decodedJson = jsonDecode(responce.body) as Map<String, dynamic>;

      setState(() {
        this.responce = BookResponce.fromJson(decodedJson);
      });
    } catch (e) {
      responce = null;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("gogole books Api"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(15.0),
                    child: TextField(
                      controller: searchController,
                      decoration:
                          const InputDecoration(hintText: "Search Book's Here"),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      onSearchPressed(searchController.text);
                    },
                    child: const Text('Search'))
              ],
            ),
            if (!isLoading)
              Expanded(
                child: ListView.builder(
                    itemCount: responce?.items?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            responce?.items![index].volumeInfo?.title ?? ""),
                        subtitle: Text(responce
                                ?.items![index].volumeInfo?.authors?.first ??
                            ""),
                        leading: Image.network(responce?.items![index]
                                .volumeInfo?.imageLinks?.thumbnail ??
                            ""),
                      );
                    }),
              ),
            if (isLoading) const Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}
