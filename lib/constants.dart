import 'package:flutter/material.dart';

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