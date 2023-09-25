import 'package:applicatio01statemanagment/bloc/cart_bloc.dart';
import 'package:applicatio01statemanagment/bloc/data_event.dart';
import 'package:applicatio01statemanagment/bloc/data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detailscreen.dart';
import 'listscreen.dart';

class MyCart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyCartState();
  }
}

class _MyCartState extends State<MyCart> {

  late bool isDisable;
  late CartBloc cbloc = BlocProvider.of<CartBloc>(context);


  @override
  void initState(){
    isDisable = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: BlocConsumer<CartBloc, DataState>(
          builder: (BuildContext context, state) {
            return Column(
                children: [
              Expanded(
                child: SizedBox(height: 490,
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.productListCart.length,
                    itemBuilder: (context, int index) {
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: BehindMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                cbloc.add(
                                    RemoveProduct(state.productListCart[index]));
                              },
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              label: 'delete',
                            ),
                          ],
                        ),
                        startActionPane: ActionPane(
                          motion: BehindMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                            productDetail:
                                            state.productListCart [index])
                                    )
                                );
                              },
                              backgroundColor: Colors.green,
                              icon: Icons.details,
                              label: 'Detils',
                            )
                          ],
                        ),
                        child: ListTile(
                          leading: SizedBox(
                              height: 100,
                              width: 60,
                              child: Image(
                                  image: NetworkImage(
                                      state.productListCart[index].thumbnail),
                                  fit: BoxFit.fill)),
                          title: Row(
                            children: [
                              const SizedBox(width: 30.0,),
                              Flexible(
                                child:
                                Text(state.productListCart[index].title,style: const TextStyle(fontWeight: FontWeight.bold),),
                              ), ],
                          ),
                          subtitle: Row(
                            children: [
                              const SizedBox(width: 30.0,),
                              Flexible(
                                child: Text(
                                  'Total:${state.productListCart[index].price.toDouble() * state.productListCart[index].quantity!.toDouble()}',style: const TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              const Padding(padding: EdgeInsets.only(left: 2.0)),
                              IconButton(
                                  onPressed: () {
                                    if (state.productListCart[index].quantity != 0) {
                                      cbloc.add(DecreaseProductQuantity(state.productListCart[index].id));
                                    } else{
                                      cbloc.add(
                                          RemoveProduct(state.productListCart[index]));
                                      isDisable = true;
                                    }
                                  },
                                  icon: const Icon(Icons.remove)),
                              const Padding(
                                padding: EdgeInsets.only(left: 1.0),
                              ),
                              Text(
                                'Qty:${state.productListCart[index].quantity}',style: TextStyle(fontWeight: FontWeight.bold),),
                              const Padding(padding: EdgeInsets.only(left: 2.0)),
                              IconButton(
                                  onPressed: () {
                                    cbloc.add(IncrementProductQuantity(state.productListCart[index].id));
                                  },
                                  icon: const Icon(Icons.add)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.0,
                child: Row(
                  children: [
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Total Bill',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )),
                    Expanded(
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            '\u{20B9}${context.read<CartBloc>().state.totalBill}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),
            ]
            );
          },
          listener: (BuildContext context, state) {},
        ),
      ),
    );

  }
}

/*
Consumer<DataProvider>(builder: (context, data, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(color: Colors.black,
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyCataLog())),
          ),
          title: Text('Shopping Cart',style: TextStyle(color: Colors.black),),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.lightBlueAccent, Colors.white]
              )
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.productList.length,
                  itemBuilder: (context, int index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              data.delFromCart(data.productList[index]);
                            },
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                            label: 'delete',
                          ),
                        ],
                      ),
                      startActionPane: ActionPane(
                        motion: BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                          productDetail:
                                              data.products[index])));
                            },
                            backgroundColor: Colors.green,
                            icon: Icons.details,
                            label: 'Detils',
                          )
                        ],
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            side: BorderSide(color: Colors.black, width: 3.0)),
                        leading: SizedBox(
                            height: 45,
                            width: 45,
                            child: Image(
                                image: NetworkImage(
                                    data.productList[index].thumbnail),
                                fit: BoxFit.fill)),
                        title: Row(
                          children: [
                            Flexible(
                                child: Text(data.productList[index].title)),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Flexible(
                              child: Text(
                                  'total:${data.productList[index].price.toDouble() * data.productList[index].quantity!.toDouble()}'),
                            ),
                            Padding(padding: EdgeInsets.only(left: 2.0)),
                            IconButton(
                                onPressed: () {
                                  if (data.productList[index].quantity != 0) {
                                    data.qtyRemove(data.productList[index].id);
                                  } else {
                                    isDisable = true;
                                    data.delFromCart(data.productList[index]);
                                  }
                                },
                                icon: Icon(Icons.remove)),
                            Padding(
                              padding: EdgeInsets.only(left: 2.0),
                            ),
                            Text('qty:${data.productList[index].quantity}'),
                            Padding(padding: EdgeInsets.only(left: 2.0)),
                            IconButton(
                                onPressed: () {
                                  data.addQuantity(data.productList[index].id);
                                },
                                icon: Icon(Icons.add)),
                          ],
                        ),
                        trailing: Checkbox(
                          value: data.isChecked,
                          onChanged: (value1) {
                            data.toggleCheckbox();
                            //debugPrint(value1 as String?);
                          },
                        ),
                        // trailing: IconButton(onPressed: (){
                        //   data.delFromCart(data.productList[index]);
                        //   //provider.delFromCart(data.productList[index]);
                        //  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyCataLog()));
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete Successfully'),
                        //     duration: Duration(seconds: 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),));
                        //   },icon: Icon(Icons.delete_forever_sharp),),
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Container(
                color: Colors.black12,
                height: 50,
                child: Row(
                  children: [
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Total Bill',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )),
                    Expanded(
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            '\u{20B9}${provider.totalAmount}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    );
 */

/*
import 'package:applicatio01statemanagment/models/product.dart';
import 'package:applicatio01statemanagment/screens/loginscreen.dart';
import 'package:applicatio01statemanagment/screens/detailscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import '../providers/providers/provider_page.dart';
import 'listscreen.dart';

class MyCart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyCartState();
  }
}

class _MyCartState extends State<MyCart> {
  late bool isDisable;
  late SlidableController _slidableController;
  late DataProvider provider;
  @override
  void initState() {
    isDisable = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<DataProvider>(context);
    return Consumer<DataProvider>(builder: (context, data, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(color: Colors.black,
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyCataLog())),
          ),
          title: Text('Shopping Cart',style: TextStyle(color: Colors.black),),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.lightBlueAccent, Colors.white]
              )
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.productList.length,
                  itemBuilder: (context, int index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              data.delFromCart(data.productList[index]);
                            },
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                            label: 'delete',
                          ),
                        ],
                      ),
                      startActionPane: ActionPane(
                        motion: BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                          productDetail:
                                              data.products[index])));
                            },
                            backgroundColor: Colors.green,
                            icon: Icons.details,
                            label: 'Detils',
                          )
                        ],
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            side: BorderSide(color: Colors.black, width: 3.0)),
                        leading: SizedBox(
                            height: 45,
                            width: 45,
                            child: Image(
                                image: NetworkImage(
                                    data.productList[index].thumbnail),
                                fit: BoxFit.fill)),
                        title: Row(
                          children: [
                            Flexible(
                                child: Text(data.productList[index].title)),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Flexible(
                              child: Text(
                                  'total:${data.productList[index].price.toDouble() * data.productList[index].quantity!.toDouble()}'),
                            ),
                            Padding(padding: EdgeInsets.only(left: 2.0)),
                            IconButton(
                                onPressed: () {
                                  if (data.productList[index].quantity != 0) {
                                    data.qtyRemove(data.productList[index].id);
                                  } else {
                                    isDisable = true;
                                    data.delFromCart(data.productList[index]);
                                  }
                                },
                                icon: Icon(Icons.remove)),
                            Padding(
                              padding: EdgeInsets.only(left: 2.0),
                            ),
                            Text('qty:${data.productList[index].quantity}'),
                            Padding(padding: EdgeInsets.only(left: 2.0)),
                            IconButton(
                                onPressed: () {
                                  data.addQuantity(data.productList[index].id);
                                },
                                icon: Icon(Icons.add)),
                          ],
                        ),
                        trailing: Checkbox(
                          value: data.isChecked,
                          onChanged: (value1) {
                            data.toggleCheckbox();
                            //debugPrint(value1 as String?);
                          },
                        ),
                        // trailing: IconButton(onPressed: (){
                        //   data.delFromCart(data.productList[index]);
                        //   //provider.delFromCart(data.productList[index]);
                        //  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyCataLog()));
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete Successfully'),
                        //     duration: Duration(seconds: 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),));
                        //   },icon: Icon(Icons.delete_forever_sharp),),
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Container(
                color: Colors.black12,
                height: 50,
                child: Row(
                  children: [
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Total Bill',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )),
                    Expanded(
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            '\u{20B9}${provider.totalAmount}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

 */