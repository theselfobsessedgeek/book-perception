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
  // ignore: unused_element
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

  // var favourite;
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
                            children: [Text('${data['title']}')],
                          )
                        ],
                      ),
                      // name: data['name'],
                      // ratePerHour: data['ratePerHour'],
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












// class FavoritesPage extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference _productss = FirebaseFirestore.instance.collection('users/$uid/books');
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Kindacode.com'),
//       ),
//       // Using StreamBuilder to display all products from Firestore in real-time
//       body: StreamBuilder(
//         stream: _productss.snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
//           if (streamSnapshot.hasData) {
//             return ListView.builder(
//               itemCount: streamSnapshot.data.docs.length,
//               itemBuilder: (context, index) {
//                 final DocumentSnapshot documentSnapshot =
//                 streamSnapshot.data.docs[index];
//                 return Card(
//                   margin: EdgeInsets.all(10),
//                   child: ListTile(
//                     title: Text(documentSnapshot['name']),
//                     subtitle: Text(documentSnapshot['author']),
//                   ),
//                 );
//               },
//             );
//           }
//
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//
//     );
//   }
// }
//
