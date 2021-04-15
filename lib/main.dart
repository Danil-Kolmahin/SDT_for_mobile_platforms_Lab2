import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'myIcons.dart';
import 'mainWidgets/Documents.dart';
import 'mainWidgets/Menu.dart';
import 'mainWidgets/Messages.dart';
import 'mainWidgets/Services.dart';

void main() => runApp(MainWidget());

class MainWidget extends StatefulWidget {
  final arr = ['/documents', '/services', '/messages', '/menu'];

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  int pageNumber = 0;
  int documentsPageNumber = 0;
  double initialBrightness;
  double brightness;

  bool isBlack = true;

  void changeDocumentsPageNumber(int i) =>
      setState(() => documentsPageNumber = i);

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
    _takeThemeColor();
  }

  Future<void> _takeThemeColor() async {
    final prefs = await SharedPreferences.getInstance();
    final takenIsBlack = prefs.getBool('themeColorIsBlack');
    setState(() => isBlack = takenIsBlack ?? true);
  }

  Future<void> _changeThemeColor(bool newIsBlack) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('themeColorIsBlack', newIsBlack);
    setState(() => isBlack = newIsBlack);
  }

  void onPressed(i, context) => setState(() {
        Navigator.of(context).pushReplacementNamed(widget.arr[i]);
        pageNumber = i;
        i == 0 ? documentsPageNumber = 0 : documentsPageNumber = null;
      });

  @override
  Widget build(BuildContext context) {
    var myBlueGreyColor = documentsPageNumber != null
        ? colors[documentsPageNumber]
        : Colors.blueGrey[200];

    return MultiProvider(
      providers: [
        Provider<Function>(
            create: (context) => (newBrightness) => newBrightness == 1.0
                ? setBrightness(1.0)
                : setBrightness(initialBrightness))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: myBlueGreyColor,
        ),
        title: 'Дія',
        initialRoute: '/documents',
        routes: {
          '/documents': (BuildContext context) => BuildScaffold(
              pageNumber,
              documentsPageNumber,
              isBlack,
              _changeThemeColor,
              onPressed,
              Documents(documentsPageNumber, changeDocumentsPageNumber)),
          '/services': (BuildContext context) => BuildScaffold(
              pageNumber,
              documentsPageNumber,
              isBlack,
              _changeThemeColor,
              onPressed,
              Services()),
          '/messages': (BuildContext context) => BuildScaffold(
              pageNumber,
              documentsPageNumber,
              isBlack,
              _changeThemeColor,
              onPressed,
              Messages()),
          '/menu': (BuildContext context) => BuildScaffold(
              pageNumber,
              documentsPageNumber,
              isBlack,
              _changeThemeColor,
              onPressed,
              Menu()),
        },
        // home: BuildScaffold(pageNumber,
        //     documentsPageNumber, isBlack, _changeThemeColor, onPressed,
        //     Documents(documentsPageNumber, changeDocumentsPageNumber)),
      ),
    );
  }
}

class BuildScaffold extends StatelessWidget {
  final pageNumber;
  final documentsPageNumber;
  final isBlack;
  final _changeThemeColor;
  final onPressed;
  final mainPage;

  BuildScaffold(this.pageNumber, this.documentsPageNumber, this.isBlack,
      this._changeThemeColor, this.onPressed, this.mainPage);

  @override
  Widget build(BuildContext context) {
    var title = pageNumber == 0 ? '' : BottomNavBarItems[pageNumber][2];
    var myGreyColor = documentsPageNumber != null
        ? colors[documentsPageNumber]
        : Colors.grey[350];
    var myBlueGreyColor = documentsPageNumber != null
        ? colors[documentsPageNumber]
        : Colors.blueGrey[200];
    Color themeColor = isBlack ? Colors.black : Colors.white;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        title: Text(
          title,
          style: TextStyle(
            color: themeColor,
          ),
        ),
        backgroundColor: myBlueGreyColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(
              MyFlutterApp.a,
              size: 50,
              color: themeColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.qr_code_scanner,
                size: 25,
                color: themeColor,
              ),
              onPressed: () => _changeThemeColor(!isBlack),
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
        selectedItemColor: themeColor,
        unselectedItemColor: themeColor,
        currentIndex: pageNumber,
        backgroundColor: myGreyColor,
        items: [
          for (var i = 0; i < BottomNavBarItems.length; i++)
            BottomNavigationBarItem(
                icon: IconButton(
                  icon: Icon(
                    BottomNavBarItems[i][0],
                  ),
                  onPressed: () => onPressed(i, context),
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
    );
  }
}
