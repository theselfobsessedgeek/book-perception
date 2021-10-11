import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key key, this.uid, this.mainContext}) : super(key: key);
  final String uid;
  final BuildContext mainContext;
  @override
  _FavouritesPageState createState() =>
      _FavouritesPageState(uid: uid, mContext: mainContext);
}

class _FavouritesPageState extends State<FavouritesPage> {
  _FavouritesPageState({
    this.mContext,
    this.uid,
  });

  final String uid;
  final BuildContext mContext;

  void initState() {
    super.initState();
    getFavourites(mContext);
  }

  Stream<List<Widget>> getFavourites(BuildContext context) {
    final path = '$uid/';
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map(
          (snapshot) {
            final data = snapshot.data();
            return data != null
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Card(
                      child: Row(
                        children: [
                          Image.network('${data['imgPath']}'),
                          Column(
                            children: [
                              Text(
                                '${data['title']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                '${data['author']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                : null;
          },
        ).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildContents(context));
  }

  Widget _buildContents(BuildContext context) {
    return StreamBuilder<List<Widget>>(
      stream: getFavourites(mContext),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(children: snapshot.data);
        }
        if (snapshot.hasError) {
          return Center(child: Text('Some error occurred'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
