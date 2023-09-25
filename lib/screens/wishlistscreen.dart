import 'package:flutter/material.dart';

class WishList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _WishListState();
  }
}

class _WishListState extends State<WishList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Align(alignment: Alignment.center,child: Text('hii, i m wishList ')),
    );
  }
}