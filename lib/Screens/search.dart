import 'package:book_perception/Elements/search_card.dart';
import 'package:book_perception/Services/database_firestore.dart';
import 'package:books_finder/books_finder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key, this.mContext}) : super(key: key);

  final mContext;

  @override
  _SearchPageState createState() => _SearchPageState(contextMain: mContext);
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  dynamic books;
  _SearchPageState({this.contextMain});

  final contextMain;
  final _firebaseAuth = FirebaseAuth.instance;

  User user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  Future<void> initUser() async {
    while (user == null) user = _firebaseAuth.currentUser;
    setState(() {});
  }

  List<Widget> booksResult = [Text("No books to show")];

  void _displayStuff(String value, BuildContext context) async {
    if (value == ' ') {
      return null;
    }
    books = await queryBooks(
      value,
      maxResults: 10,
      printType: PrintType.books,
      orderBy: OrderBy.relevance,
      reschemeImageLinks: true,
    );
    var i = 0;
    books.forEach((book) {
      final info = book.info;
      setState(() {
        booksResult.insert(
            i,
            SizedBox(
              width: MediaQuery.of(contextMain).size.width * 0.15,
              child: Provider<Database>(
                create: (_) => FirestoreDatabase(uid: user.uid),
                child: SearchCard(
                  title: info.title.toString(),
                  author: info.authors[0],
                  imgPath: info.imageLinks['smallThumbnail'].toString(),
                  context: contextMain,
                ),
              ),
            ));
      });
      i++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            onSubmitted: (String value) {
              setState(() {
                booksResult.clear();
                setState(() {});
                _displayStuff(value, contextMain);
              });
            },
            decoration: InputDecoration(
                focusColor: Colors.black,
                labelStyle: TextStyle(color: Colors.black),
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                labelText: 'Search'),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: booksResult,
            ),
          )
        ],
      ),
    );
  }
}
