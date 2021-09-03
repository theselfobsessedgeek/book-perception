import 'package:book_perception/Elements/search_card.dart';
import 'package:books_finder/books_finder.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  dynamic books;

  List<Widget> booksResult = [Text(" ")];
  void _displayStuff(String value) async{
    books = await queryBooks(
      value,
      maxResults: 10,
      printType: PrintType.books,
      orderBy: OrderBy.relevance,
      reschemeImageLinks: true,
    );
    var i=0;
    books.forEach((book) {
      final info = book.info;
      setState(() {
        booksResult.insert(i,
        Expanded(
          child: SearchCard(title: info.title.toString(),
            author: info.authors.toString(),
            imgPath: info.imageLinks['smallThumbnail'].toString(),
          ),
        )
        );
      });
      i++;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.brown[200],
                title: TextField(
                  controller: _searchController,
                  onSubmitted: (String value)=>_displayStuff(value),
                  decoration: InputDecoration(
                    focusColor:Colors.white,
                    labelStyle: TextStyle(
                      color: Colors.white
                    ) ,
                      icon: Icon(Icons.search,
                      color: Colors.white,
                      ),
                      labelText: 'Search'
                  ),
                ),
              ),
              SliverList(delegate: SliverChildListDelegate(booksResult))
            ],
            ),
    );
  }
}
