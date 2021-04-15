import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

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

const ServicesContent = [
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

class MyDocument {
  String documentName;
  String documentStatus;
  String studyPlace;
  String userName;
  String imgUrl;

  MyDocument(
      {this.documentName,
      this.documentStatus,
      this.studyPlace,
      this.userName,
      this.imgUrl});

  factory MyDocument.fromJson(Map<String, dynamic> json) {
    return MyDocument(
      documentName: json['documentName'],
      documentStatus: json['documentStatus'],
      studyPlace: json['studyPlace'],
      userName: json['userName'],
      imgUrl: json['imgUrl'],
    );
  }
}

Future<List<MyDocument>> parseJson() async {
  final response = await get('http://192.168.1.104:3000');
  List<dynamic> responseJson = json.decode(utf8.decode(response.bodyBytes));
  return responseJson
      .map<MyDocument>((json) => MyDocument.fromJson(json))
      .toList();
}