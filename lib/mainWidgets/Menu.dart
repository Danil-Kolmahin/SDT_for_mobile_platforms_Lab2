import 'package:flutter/material.dart';

import '../constants.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20.0),
      itemCount: MenuContent.length + 1,
      itemBuilder: (BuildContext context, int index) {
        return index == MenuContent.length
            ? Text(
                'Version 2.0.27',
                textAlign: TextAlign.center,
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(MenuContent[index][0]),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      MenuContent[index][1],
                      style: TextStyle(
                        fontSize: 19,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              );
      },
      separatorBuilder: (BuildContext context, int index) => [
                2,
                4,
                7
              ].firstWhere((element) => index == element, orElse: () => null) !=
              null
          ? Opacity(
              opacity: 0.5,
              child: const Divider(
                thickness: 1.5,
                color: Colors.blueGrey,
              ),
            )
          : Row(),
    );
  }
}
