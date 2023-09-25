import 'package:applicatio01statemanagment/bloc/data_bloc.dart';
import 'package:applicatio01statemanagment/bloc/data_state.dart';
import 'package:applicatio01statemanagment/models/product.dart';
import 'package:applicatio01statemanagment/screens/splashscreen.dart';
import 'package:applicatio01statemanagment/screens/userdetail.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

import 'cartscreen.dart';
import 'listscreen.dart';
import 'loginscreen.dart';

class HomeScreen extends StatefulWidget{
  final String userName;
  HomeScreen(this.userName);
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen>{
  int counter =0;

  final TextEditingController _searchController = TextEditingController();
  List<Product> items = [];


  int _selectedIndex = 0;
  List<Widget> itemList =[
    MyCataLog(),
    MyCart(),
    UserDetail()
  ];

  void _onItemTapped(int index) {
    setState(() {
      counter++;
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<DataBloc,DataState>(
        builder:(BuildContext context,state){
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                title: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.black),
                  cursorColor : Colors.white,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                          if(state is SuccessState){
                            setState(() {
                               items = state.productList
                                  .where((item) => item.title.toLowerCase().contains(value.toLowerCase()))
                                   .toList();
                            });
                          }
                          },
                ),
                //Align(alignment: Alignment.topRight,child: Text('${widget.userName}',style: TextStyle(color: Colors.black),)),
                leading: BackButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
                actions: [
                  Stack(
                      children:[ IconButton(icon: const ImageIcon(size: 22,color: Colors.black,
                          AssetImage('asset/icons8-notification-30.png')
                      ),
                          onPressed: () {
                            setState(() {
                              counter=0;
                            });
                          }),
                        counter !=0 ? Positioned(right: 10,top: 10,
                            child: Container(
                              padding: EdgeInsets.all(1),
                              constraints: BoxConstraints(
                                minWidth: 10,
                                minHeight: 8,
                              ),
                              child: Text('$counter',style: TextStyle( color: Colors.red,
                                  fontSize: 12),textAlign: TextAlign.center,),
                            )
                        ): Container()
                      ]
                  ),
                  Column(
                    children: [
                      const CircleAvatar(backgroundColor: Colors.white,
                        child: ImageIcon(AssetImage('asset/icons8-account-30.png')),
                      ),
                      Text(widget.userName.substring(0,7),
                        style: const TextStyle(color: Colors.black),
                      ),

                    ],
                  ),

                ],
              ),
              body:  Center(
                  child: itemList.elementAt(_selectedIndex),
                ),
              bottomNavigationBar: SizedBox(height: 60.0,
                  child: CurvedNavigationBar(color: Colors.white,
                    backgroundColor: Colors.orange,
                    height: 50,
                    index: _selectedIndex,
                    animationDuration: Duration(seconds: 1),
                    onTap: _onItemTapped,
                    items: const [
                      ImageIcon(AssetImage('asset/icons8-homeadvisor-30.png')),
                      Icon(Icons.shopping_cart),
                      ImageIcon(AssetImage('asset/icons8-account-30.png')),
                    ],
                  )
              )
          );
        },
        listener: (BuildContext context, state) {  } ,

      ),
    );


  }
}

/*
Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: TextField(controller: _searchController,
                style: const TextStyle(color: Colors.black),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  void searchContact(String textfieldresult,modelList) async {
                    searchedList.clear();
                    var value = modelList.where((element) =>
                    element.name!.toLowerCase().contains(textfieldresult.toLowerCase()) ||
                        element.name!.toUpperCase().contains(textfieldresult.toUpperCase()));
                    searchedList.addAll(value);
                    return searchedList ;
                  }
                },
              ),
              //Align(alignment: Alignment.topRight,child: Text('${widget.userName}',style: TextStyle(color: Colors.black),)),
              leading: BackButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
              actions: [
                Stack(
                  children:[ IconButton(icon: const ImageIcon(size: 22,color: Colors.black,
                      AssetImage('asset/icons8-notification-30.png')
                  ),
                    onPressed: () {
                      setState(() {
                        counter=0;
                      });
                    }),
                    counter !=0 ? Positioned(right: 10,top: 10,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          constraints: BoxConstraints(
                            minWidth: 10,
                            minHeight: 8,
                          ),
                          child: Text('$counter',style: TextStyle( color: Colors.red,
                              fontSize: 12),textAlign: TextAlign.center,),
                        )
                    ): Container()
                  ]
                ),
                 Column(
                   children: [
                  const CircleAvatar(backgroundColor: Colors.white,
                    child: ImageIcon(AssetImage('asset/icons8-account-30.png')),
                  ),
                  Text(widget.userName.substring(0,7),
                    style: const TextStyle(color: Colors.black),
                  ),

                ],
                 ),

              ],
            ),
          body:  Center(
            child: itemList.elementAt(_selectedIndex),
          ),
        bottomNavigationBar: SizedBox(height: 60.0,
          child: CurvedNavigationBar(color: Colors.white,
            backgroundColor: Colors.black,
            height: 50,
            index: _selectedIndex,
            animationDuration: Duration(seconds: 1),
            onTap: _onItemTapped,
             items: const [
               ImageIcon(AssetImage('asset/icons8-homeadvisor-30.png')),
               Icon(Icons.shopping_cart),
               ImageIcon(AssetImage('asset/icons8-account-30.png')),
             ],
          )
        )
        ),

++++++++++++++++++++++++++++++
BottomNavigationBar(items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: 'Home',
            icon: Image.asset('asset/icons8-homeadvisor-30.png'),
        ),
        BottomNavigationBarItem(
          label: 'cart',
          icon: Image.asset('asset/icons8-cart-30.png'),
        ),
        BottomNavigationBarItem(
          label: 'account',
          icon: Image.asset('asset/icons8-account-30.png'),
        ),
      ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        iconSize: 20,
        onTap: _onItemTapped,
        elevation: 0.0,
        selectedItemColor: Colors.black,
      ),
 */