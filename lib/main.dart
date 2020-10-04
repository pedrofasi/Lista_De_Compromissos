import 'package:flutter/material.dart';
import 'package:mvc_app/views/item_list.view.dart';

void main() {
  runApp(MaterialApp(
    title: 'Lista',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.white
    ),
    home: ItemListView(),
  ));
}