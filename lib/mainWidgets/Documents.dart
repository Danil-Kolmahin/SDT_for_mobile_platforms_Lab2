import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class Documents extends StatelessWidget {
  final int documentsPageNumber;
  final Function changeDocumentsPageNumber;

  Documents(this.documentsPageNumber, this.changeDocumentsPageNumber);

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
                  changeDocumentsPageNumber(index);
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

class _StudentCardState extends State<StudentCard>
    with SingleTickerProviderStateMixin {
  bool isDocument = true;

  AnimationController _controller;
  Animation<double> A;
  // Animation<double> B;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    A = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(_controller)
    // B = Tween<double>(
    //   begin: pi / 2,
    //   end: pi,
    // ).animate(_controller)
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
