
import 'package:flutter/material.dart' show IconData, Widget;
class Menu{
  final String   route; 
  final IconData icon;
  final String   name;
  final Widget   view;

  Menu({
    required this.route,
    required this.icon,
    required this.name,
    required this.view
  });
}