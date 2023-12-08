import 'package:assignment_techila/bloc/cart_bloc.dart';
import 'package:assignment_techila/bloc/data_bloc.dart';
import 'package:assignment_techila/bloc/data_state.dart';
import 'package:assignment_techila/models/product.dart';
import 'package:assignment_techila/screens/userdetail.dart';
import 'package:assignment_techila/screens/wishlistscreen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cartscreen.dart';
import 'listscreen.dart';
import 'loginscreen.dart';

class HomeScreen extends StatefulWidget{
  final String userName;
  const HomeScreen(this.userName, {super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen>{
  int counter =0;
  List<Product> items = [];
  int _selectedIndex = 0;
  late List<Widget> itemList;

  @override
  void initState() {
    itemList =[
      MyCataLog(),
      MyCart(),
      WishList(),
    ];


    super.initState();
  }
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
                leading: BackButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => const LoginPage()));
                  },
                ),
                actions: [
                  Stack(
                      children:[ IconButton(icon: const ImageIcon(size: 22,color: Colors.black, AssetImage('asset/icons8-notification-30.png')),
                          onPressed: () {setState(() {counter=0;});}),
                        counter !=0 ? Positioned(right: 10,top: 10,
                            child: Container(
                              padding: const EdgeInsets.all(1),
                              constraints: const BoxConstraints(
                                minWidth: 10,
                                minHeight: 8,
                              ),
                              child: Text('$counter',style: const TextStyle( color: Colors.red,
                                  fontSize: 12),textAlign: TextAlign.center,),
                            )
                        ): Container()
                      ]
                  ),
                  Column(
                    children: [
                       CircleAvatar(backgroundColor: Colors.white,
                        child: IconButton(icon: const ImageIcon(AssetImage('asset/icons8-account-30.png')),
                          onPressed: () { 
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserDetail(widget.userName)));
                          },
                        ),
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
                    animationDuration: const Duration(seconds: 1),
                    onTap: _onItemTapped,
                    items:  [
                      const ImageIcon(AssetImage('asset/icons8-homeadvisor-30.png')),
                      BlocConsumer<CartBloc,DataState>(
                        builder: (BuildContext context,state){
                          return Stack(
                                children:[
                                  const Icon(Icons.shopping_cart),
                                  Positioned(
                                      left: 16,bottom: 12,
                                      child: Container(
                                        padding: const EdgeInsets.all(1),
                                        constraints: const BoxConstraints(
                                          minWidth: 10,
                                          minHeight: 8,
                                        ),
                                        child: Text('${state.productListCart.length}',style: const TextStyle( color: Colors.red,
                                            fontSize: 10),textAlign: TextAlign.center,),
                                      )
                                  )
                                ]
                            );

                          },
                        listener: (BuildContext context, DataState state) {  },

                      ),
                      const Icon(Icons.favorite_border)
                    ],
                  )
              )
          );
        },
        listener: (BuildContext context, state) {} ,

      ),
    );


  }
}

