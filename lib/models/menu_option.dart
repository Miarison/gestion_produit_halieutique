// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuOption {

     Icon icon;
     String menu;

     MenuOption({required this.icon,required this.menu});

}
final options = [
  MenuOption(
    icon: const Icon(Icons.ten_mp,size: 30.0),
    menu: 'Fournisseur',
  ),
  MenuOption(
    icon: const Icon(Icons.airport_shuttle_outlined, size: 30.0),
    menu: 'Marchandises',
  ),
  MenuOption(
    icon: const Icon(Icons.add_shopping_cart, size: 30.0),
    menu: 'Achats',
  ),
  MenuOption(
    icon: const Icon(Icons.assignment_rounded, size: 30.0),
    menu: 'Ventes',
  ),
  MenuOption(
    icon: const Icon(Icons.account_balance, size: 30.0),
    menu: 'Mouvement',
  ),
  MenuOption(
    icon: const Icon(Icons.fastfood, size: 30.0),
    menu: 'Stocks',
  ),
];