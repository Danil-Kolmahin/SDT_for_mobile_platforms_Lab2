import 'package:flutter/material.dart';

import '../constants.dart';

class Services extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20.0),
      itemCount: ServicesContent.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          child: Opacity(
            opacity: ServicesContent[index].length == 1 ? 0.5 : 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ServicesContent[index][0],
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto',
                  ),
                ),
                ServicesContent[index].length == 1
                    ? Text(
                        'В розробці',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Roboto',
                        ),
                      )
                    : Icon(ServicesContent[index][1]),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Opacity(
        opacity: 0.5,
        child: const Divider(
          thickness: 1.5,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
