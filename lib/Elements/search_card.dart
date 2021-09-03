import 'package:flutter/material.dart';


class SearchCard extends StatelessWidget {


  SearchCard({
    this.title,
    this.imgPath,
    this.author,
  });
  final String title;
  final String imgPath;
  final String author;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Image.network(imgPath),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,

                ),
                  maxLines: 5,
                  overflow: TextOverflow.fade,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(author,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 10,

                  ),
                ),

              ),
            ],
          ),
        ],
      ),
    );
  }
}
