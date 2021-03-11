import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const MenuContent = [
      [Icons.wb_incandescent_outlined, 'Функції та підказки'],
      [Icons.help_outline, 'Питання та відповіді'],
      [Icons.message_outlined, 'Служба підтримки'],
      [Icons.content_copy, 'Копіювати номер пристрою'],
      [Icons.settings_outlined, 'Налаштування'],
      [Icons.info_outline, 'Про Дію'],
      [Icons.ios_share, 'Розповісти друзям'],
      [Icons.star_outline, 'Оцінити застосунок'],
      [Icons.exit_to_app, 'Вийти'],
    ];

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
