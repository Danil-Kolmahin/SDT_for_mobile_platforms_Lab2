import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class Documents extends StatelessWidget {
  final int documentsPageNumber;
  final Function callback;

  Documents(this.documentsPageNumber, this.callback);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CarouselSlider.builder(
              options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  Provider.of<Function>(context, listen: false)(0.0);
                  callback(index);
                },
                disableCenter: true,
                initialPage: documentsPageNumber,
                enableInfiniteScroll: false,
              ),
              itemCount: documents.length,
              itemBuilder: (BuildContext context, int i, int _) =>
                  StudentCard(i)),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: documents.map((url) {
              int index = documents.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: documentsPageNumber == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList()),
      ],
    );
  }
}

class StudentCard extends StatefulWidget {
  final int i;

  const StudentCard(this.i) : super();

  @override
  _StudentCardState createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  bool isDocument = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        Provider.of<Function>(context, listen: false)(isDocument ? 1.0 : 0.0);
        return isDocument = !isDocument;
      }),
      child: Card(
        elevation: 10,
        color: Colors.blueGrey[200],
        margin: EdgeInsets.all(30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: isDocument
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      documents[widget.i][0],
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(documents[widget.i][1]),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blueGrey[300],
                                width: 1.5,
                              ),
                            ),
                            child: Image.network(
                              documents[widget.i][4],
                              width: 100,
                              height: 200,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.blueGrey[300],
                    ),
                    Text(documents[widget.i][2]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          documents[widget.i][3],
                          style: TextStyle(fontSize: 20),
                        ),
                        Icon(Icons.more_horiz),
                      ],
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('коди діятимуть 3 хв'),
                      ],
                    ),
                    Image.asset('./assets/QRCode.png'),
                    Image.asset('./assets/barcode.png')
                  ],
                ),
        ),
      ),
    );
  }
}
