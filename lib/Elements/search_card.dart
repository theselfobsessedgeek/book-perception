import 'package:book_perception/Screens/search.dart';
import 'package:book_perception/Services/database_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchCard extends StatelessWidget {
  SearchCard({this.title, this.imgPath, this.author, this.context});
  final String title;
  final String imgPath;
  final String author;
  final BuildContext context;
  Future<void> _addToFav(BuildContext context) async {
    final database = Provider.of<Database>(context, listen: false);
    await database.addToFav({
      'title': '$title',
      'imgPath': '$imgPath',
      'author': '$author',
    });
    print("book added");
  }

  Widget build(BuildContext contextt) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Card(
        child: Row(
          children: [
            Image.network(imgPath),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      author,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: Icon(Icons.add_outlined),
                        onPressed: () => _addToFav(context),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.brown),
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
