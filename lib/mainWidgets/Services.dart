import 'package:flutter/material.dart';

class Services extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const MenuContent = [
      [
        'Штрафи за порушення ПДР',
        Icons.arrow_forward,
      ],
      [
        'Виконавчі провадження',
        Icons.arrow_forward,
      ],
      [
        'Запис до листа очікування \n вакцинації на COVID-19',
        Icons.arrow_forward,
      ],
      ['Заміна посвідчення водія'],
      ['Шеринг техпаспорту'],
      ['Податки'],
      ['Смарт Дія'],
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(20.0),
      itemCount: MenuContent.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          child: Opacity(
            opacity: MenuContent[index].length == 1 ? 0.5 : 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  MenuContent[index][0],
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto',
                  ),
                ),
                MenuContent[index].length == 1
                    ? Text(
                        'В розробці',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Roboto',
                        ),
                      )
                    : Icon(MenuContent[index][1]),
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
