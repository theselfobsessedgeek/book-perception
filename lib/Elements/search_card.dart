import 'package:flutter/material.dart';


class SearchCard extends StatelessWidget {


  SearchCard({
    this.title,
    this.imgPath,
    this.author,
    this.context
  });
  final String title;
  final String imgPath;
  final String author;
  final BuildContext context;
  Widget build(BuildContext contexmt) {
    return Card(

      child: Row(
        children: <Widget>[
          Image.network(imgPath),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0),
                child: SizedBox(
                  width:MediaQuery.of(context).size.width * 0.65,
                  child: Text(title,
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
                  child: Text(author,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 10,

                    ),
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
