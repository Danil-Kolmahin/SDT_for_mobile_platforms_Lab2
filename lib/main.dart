import 'package:flutter/material.dart';
import 'myIcons.dart';

import 'mainWidgets/Documents.dart';
import 'mainWidgets/Menu.dart';
import 'mainWidgets/Messages.dart';
import 'mainWidgets/Services.dart';

void main() {
  runApp(MainWidget());
}

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  int pageNumber = 0;
  int documentsPageNumber = 0;

  @override
  Widget build(BuildContext context) {
    const colors = [
      Colors.indigoAccent,
      Colors.pinkAccent,
      Colors.amberAccent,
      Colors.blueGrey
    ];

    const BottomNavBarItems = [
      [Icons.ballot_outlined, Icons.ballot, 'Документи'],
      [Icons.offline_bolt_outlined, Icons.offline_bolt_rounded, 'Послуги'],
      [Icons.notifications_none, Icons.notifications, 'Повідомлення'],
      [Icons.menu, Icons.table_rows_rounded, 'Меню'],
    ];

    callback(int i) => setState(() => documentsPageNumber = i);
    var mainWidgets = [
      Documents(callback, colors, documentsPageNumber),
      Services(),
      Messages(),
      Menu()
    ];
    var mainPage = mainWidgets[pageNumber];
    var title = pageNumber == 0 ? '' : BottomNavBarItems[pageNumber][2];
    var myGreyColor = documentsPageNumber != null
        ? colors[documentsPageNumber]
        : Colors.grey[350];
    var myBlueGreyColor = documentsPageNumber != null
        ? colors[documentsPageNumber]
        : Colors.blueGrey[200];

    return MaterialApp(
      theme: ThemeData(
        primaryColor: myBlueGreyColor,
      ),
      title: 'Дія',
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          title: Text(
            title,
            style: TextStyle(
              // shadows: [
              //   Shadow(
              //     color: Colors.red,
              //     blurRadius: 20,
              //   )
              // ],
              color: Colors.black,
            ),
          ),
          backgroundColor: myBlueGreyColor,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              MyFlutterApp.a,
              size: 50,
              color: Colors.black,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(
                  Icons.qr_code_scanner,
                  size: 25,
                  color: Colors.black,
                ),
                onPressed: () => {},
              ),
            ),
          ],
        ),
        body: mainPage,
        backgroundColor: myGreyColor,
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          currentIndex: pageNumber,
          backgroundColor: myGreyColor,
          items: [
            for (var i = 0; i < BottomNavBarItems.length; i++)
              BottomNavigationBarItem(
                  icon: IconButton(
                    icon: Icon(
                      BottomNavBarItems[i][0],
                    ),
                    onPressed: () => setState(() {
                      pageNumber = i;
                      i == 0
                          ? documentsPageNumber = 0
                          : documentsPageNumber = null;
                    }),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      BottomNavBarItems[i][1],
                    ),
                  ),
                  label: BottomNavBarItems[i][2])
          ],
        ),
        // ---------------------------------------------------------------------
        // floatingActionButton: FloatingActionButton(
        //   onPressed: null,
        //   child: Icon(Icons.add),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // ---------------------------------------------------------------------
        // drawer: Drawer(
        //   child: ListView(
        //     children: [
        //       DrawerHeader(
        //         child: Text('Drawer Header'),
        //       ),
        //       ListTile(
        //         title: Text('Item 1'),
        //       ),
        //       ListTile(
        //         title: Text('Item 2'),
        //       ),
        //     ],
        //   ),
        // ),
        // ---------------------------------------------------------------------
      ),
    );
  }
}
