import 'package:assignment_techila/bloc/cart_bloc.dart';
import 'package:assignment_techila/bloc/data_event.dart';
import 'package:assignment_techila/bloc/data_state.dart';
import 'package:assignment_techila/screens/paymentscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'detailscreen.dart';


class MyCart extends StatefulWidget {
  const MyCart({super.key});

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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: BlocConsumer<CartBloc, DataState>(
          builder: (BuildContext context, state) {
            return Column(
                children: [
              Expanded(
                child: SizedBox(height: 490,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.productListCart.length,
                    itemBuilder: (context, int index) {
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const BehindMotion(),
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
                          motion: const BehindMotion(),
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
                                'Qty:${state.productListCart[index].quantity}',style: const TextStyle(fontWeight: FontWeight.bold),),
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
              SizedBox(height: 30.0,
                child: Row(
                  children: [
                    const Align(
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
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),
                   SizedBox(
                      height: 40.0,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                        ),
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Payment()));
                        },
                        child: const Text('Proceed To check out')),
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
