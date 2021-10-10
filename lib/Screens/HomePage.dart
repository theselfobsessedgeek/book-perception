import 'package:book_perception/Screens/search.dart';
import 'package:book_perception/auth.dart';
import 'package:book_perception/database_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Favorites Page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  Future<void> _signOut() async {
    await widget.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    Widget _body = FavouritesPage(
      uid: user.uid,
      mainContext: context,
    );
    String name =
        (user.displayName != null) ? user.displayName : "Anonymous User";
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.brown,
                ),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "$name",
                      style: GoogleFonts.allura(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ))),
            ListTile(
                leading: Icon(Icons.search),
                title: const Text('Search'),
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => Provider<Database>(
                            create: (_) => FirestoreDatabase(uid: user.uid),
                            child: SearchPage()),
                      ),
                    );
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => SearchPage(),
                    ),
                  );
                  print("pressed");

                  Navigator.pop(context);
                }),
            ListTile(
              leading: Icon(Icons.star),
              title: const Text('Favourites'),
              onTap: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => FavouritesPage(
                          uid: user.uid,
                          mainContext: context,
                        ),
                      ));
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Book Perception",
          style: GoogleFonts.satisfy(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Colors.brown[500],
        actions: <Widget>[
          TextButton(
            onPressed: _signOut,
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor: Colors.yellow[50],
      body: _body,
    );
  }
}
