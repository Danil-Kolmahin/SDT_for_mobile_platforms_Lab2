import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class Documents extends StatefulWidget {
  final int documentsPageNumber;
  final Function changeDocumentsPageNumber;

  Documents(this.documentsPageNumber, this.changeDocumentsPageNumber);

  @override
  _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  List<MyDocument> documents = [];

  @override
  void initState() {
    parseJson().then((value) => setState(() => documents = value));
    super.initState();
  }

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
                  widget.changeDocumentsPageNumber(index);
                },
                disableCenter: true,
                initialPage: widget.documentsPageNumber,
                enableInfiniteScroll: false,
              ),
              itemCount: documents.length,
              itemBuilder: (BuildContext context, int i, int _) =>
                  StudentCard(documents[i])),
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
                  color: widget.documentsPageNumber == index
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
  final MyDocument document;

  const StudentCard(this.document) : super();

  @override
  _StudentCardState createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard>
    with SingleTickerProviderStateMixin {
  bool isDocument = true;

  AnimationController _controller;
  Animation<double> A;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    A = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((state) {
        if (state == AnimationStatus.forward ||
            state == AnimationStatus.reverse)
          Future.delayed(
              Duration(milliseconds: 250),
              () => setState(() {
                    return isDocument = !isDocument;
                  }));
        // print(state);
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(A.value),
      child: GestureDetector(
        onTap: () => setState(() {
          Provider.of<Function>(context, listen: false)(isDocument ? 1.0 : 0.0);
          isDocument ? _controller.forward() : _controller.reverse();
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
                        widget.document.documentName ?? '',
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(
                        height: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(widget.document.documentStatus ?? ''),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blueGrey[300],
                                  width: 1.5,
                                ),
                              ),
                              child: Image.network(
                                widget.document.imgUrl ?? 'https://gravatar.com/avatar/bce18aaf194be855b91e09589607edeb?s=400&d=robohash&r=x',
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
                      Text(widget.document.studyPlace ?? ''),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.document.userName ?? '',
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(Icons.more_horiz),
                        ],
                      ),
                    ],
                  )
                : Transform(
                    alignment: FractionalOffset.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(pi),
                    child: Column(
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
        ),
      ),
    );
  }
}
