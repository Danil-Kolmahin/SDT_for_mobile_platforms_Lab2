import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen/screen.dart';

import 'constants.dart';
import 'myIcons.dart';
import 'mainWidgets/Documents.dart';
import 'mainWidgets/Menu.dart';
import 'mainWidgets/Messages.dart';
import 'mainWidgets/Services.dart';
import 'package:fake_action/State.dart';

void main() => runApp(MainWidget());

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  int pageNumber = 0;
  int documentsPageNumber = 0;
  double initialBrightness;
  double brightness;

  void callback(int i) => setState(() => documentsPageNumber = i);

  void setBrightness(b) {
    Screen.setBrightness(b);
    setState(() {
      brightness = b;
    });
  }

  void initPlatformState() async {
    double newBrightness = await Screen.brightness;
    setBrightness(newBrightness);
    setState(() {
      initialBrightness = newBrightness;
    });
  }

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    var mainWidgets = [
      Documents(documentsPageNumber, callback),
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StateModel()),
        Provider<Function>(
            create: (context) => (newBrightness) => newBrightness == 1.0
                ? setBrightness(1.0)
                : setBrightness(initialBrightness))
      ],
      child: MaterialApp(
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
                color: Colors.black,
              ),
            ),
            backgroundColor: myBlueGreyColor,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<StateModel>(builder: (context, cart, child) {
                return IconButton(
                    icon: Icon(
                      MyFlutterApp.a,
                      size: 50,
                      color: Colors.black,
                    ),
                    onPressed: () => cart.changeBrightness(2.0));
              }),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<StateModel>(builder: (context, cart, child) {
                  return IconButton(
                      icon: Icon(
                        Icons.qr_code_scanner,
                        size: 25,
                        color: Colors.black,
                      ),
                      onPressed: () => cart.changeBrightness(1.0));
                }),
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
        ),
      ),
    );
  }
}
