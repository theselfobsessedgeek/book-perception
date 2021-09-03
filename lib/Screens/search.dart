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

  List<Widget> booksResult = [Text("No books to show")];
  void _displayStuff(String value,BuildContext context) async{
    if(value == ' '){
      return null;
    }

    books = await queryBooks(
      value,
      maxResults: 10,
      printType: PrintType.books,
      orderBy: OrderBy.relevance,
      reschemeImageLinks: true,
    );

    booksResult.clear();
    var i=0;
    books.forEach((book) {
      final info = book.info;
      setState(() {
        booksResult.insert(i,
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          child: SearchCard(title: info.title.toString(),
            author: info.authors.toString(),
            imgPath: info.imageLinks['smallThumbnail'].toString(),
            context: context,
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
                  onSubmitted: (String value) => _displayStuff(value,context),


                    //_displayStuff(value,context),
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
