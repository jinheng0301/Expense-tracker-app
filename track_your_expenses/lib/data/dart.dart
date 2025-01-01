import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, dynamic>> myTransactionsData = [
  {
    'icon': const FaIcon(
      FontAwesomeIcons.burger,
      color: Colors.white,
    ),
    'color': Colors.red[700],
    'name': 'Food',
    'totalAmount': '- RM200.0',
    'date': 'Today',
  },
  {
    'icon': const FaIcon(
      FontAwesomeIcons.bagShopping,
      color: Colors.white,
    ),
    'color': Colors.purple[700],
    'name': 'Shopping',
    'totalAmount': '- RM200.0',
    'date': 'Today',
  },
  {
    'icon': const FaIcon(
      FontAwesomeIcons.heartbeat,
      color: Colors.white,
    ),
    'color': Colors.green,
    'name': 'Health',
    'totalAmount': '- RM200.0',
    'date': 'Yesterday',
  },
  {
    'icon': const FaIcon(
      FontAwesomeIcons.plane,
      color: Colors.white,
    ),
    'color': Colors.yellow,
    'name': 'Travel',
    'totalAmount': '- RM200.0',
    'date': 'Today',
  },
];
