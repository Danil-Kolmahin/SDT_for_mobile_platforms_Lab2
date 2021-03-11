import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; //lib

class Documents extends StatefulWidget {
  final Function callback;
  final color;
  final documentsPageNumber;

  Documents(this.callback, this.color, this.documentsPageNumber);

  @override
  _DocumentsState createState() =>
      _DocumentsState(callback, color, documentsPageNumber);
}

class _DocumentsState extends State<Documents> {
  int _current = 0;
  Function callback;
  var color;
  var documentsPageNumber;

  _DocumentsState(this.callback, this.color, this.documentsPageNumber);

  @override
  Widget build(BuildContext context) {
    const documents = [
      [
        'Студентський \n квиток',
        'КВ24242424 \n\n Дійсний до: \n 01.01.2077 \n\n Форма навчання: \n денна',
        'Національний технічний університет \n України "Київський політехнічний \n інститут імені Ігоря Сікорського',
        'Сімонов \n Валерій \n Павлович',
        'https://gravatar.com/avatar/7e2fd80de2e6c4f49372e1cd6a0d4ae0?s=400&d=robohash&r=x'
      ],
      [
        'Студентський \n квиток',
        'КВ24242424 \n\n Дійсний до: \n 01.01.2077 \n\n Форма навчання: \n денна',
        'Національний технічний університет \n України "Київський політехнічний \n інститут імені Ігоря Сікорського',
        'Сімонов \n Валерій \n Павлович',
        'https://gravatar.com/avatar/e54d32f87a182323d27ef590c72bebe5?s=400&d=robohash&r=x'
      ],
      [
        'Студентський \n квиток',
        'КВ24242424 \n\n Дійсний до: \n 01.01.2077 \n\n Форма навчання: \n денна',
        'Національний технічний університет \n України "Київський політехнічний \n інститут імені Ігоря Сікорського',
        'Сімонов \n Валерій \n Павлович',
        'https://gravatar.com/avatar/d01636c2b2c51dc6f73d904d5b8920ec?s=400&d=robohash&r=x'
      ]
    ];

    return Column(
      children: [
        Expanded(
          child: CarouselSlider.builder(
              options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                    callback(index);
                  });
                },
                disableCenter: true,
                initialPage: _current,
                enableInfiniteScroll: false,
              ),
              itemCount: documents.length,
              itemBuilder: (BuildContext context, int i, int _) => StudentID(
                  documents: documents,
                  i: i,
                  color: color,
                  documentsPageNumber: documentsPageNumber)),
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
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList()),
      ],
    );
  }
}

class StudentID extends StatelessWidget {
  const StudentID({
    Key key,
    @required this.documents,
    @required this.i,
    @required this.color,
    @required this.documentsPageNumber,
  }) : super(key: key);

  final int i;
  final List<List<String>> documents;
  final color;
  final documentsPageNumber;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.blueGrey[200],
      margin: EdgeInsets.all(30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          // textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              documents[i][0],
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(documents[i][1]),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blueGrey[300],
                        width: 1.5,
                      ),
                    ),
                    child: Image.network(
                      documents[i][4],
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
            Text(documents[i][2]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  documents[i][3],
                  style: TextStyle(fontSize: 20),
                ),
                Icon(Icons.more_horiz),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
