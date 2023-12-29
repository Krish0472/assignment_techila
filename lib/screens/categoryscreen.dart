// ignore_for_file: use_build_context_synchronously

import 'package:assignment_techila/bloc/data_bloc.dart';
import 'package:assignment_techila/bloc/data_state.dart';
import 'package:assignment_techila/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/cart_bloc.dart';
import '../bloc/data_event.dart';
import '../bloc/wishlist_bloc.dart';
import 'detailscreen.dart';

class Categoryy extends StatefulWidget {
  const Categoryy({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CategoryState();
  }
}

class _CategoryState extends State<Categoryy> {
  late WishListBloc wbloc = BlocProvider.of<WishListBloc>(context);
  late CartBloc cbloc = BlocProvider.of<CartBloc>(context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            String? name = preferences.getString('name');

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomeScreen(name!)));
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocConsumer<DataBloc, DataState>(
          builder: (BuildContext context, state) {
            if (state is SuccessState) {
              return Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: state.productList.length,
                    itemBuilder: (BuildContext context, index) {
                      if (state.productList[index].category == 'laptops') {
                        return ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          child: Card(
                            elevation: 6,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailPage(
                                            productDetail:
                                                state.productList[index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: SizedBox(
                                      height: 120,
                                      width: 100,
                                      child: Image.network(
                                        state.productList[index].thumbnail,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                      child: Text(
                                    state.productList[index].title,
                                    style: const TextStyle(fontSize: 12),
                                    softWrap: true,
                                  )),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        '${state.productList[index].price}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: IconButton(
                                        onPressed: () async {
                                          cbloc.add(AddToCartEvent(
                                              state.productList[index]));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text('item added card'),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            duration: Duration(seconds: 1),
                                          ));
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: IconButton(
                                        onPressed: () {
                                          wbloc.add(AddToWishListEvent(
                                              state.productList[index]));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content:
                                                Text('item add to wishList'),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            duration: Duration(seconds: 1),
                                          ));
                                        },
                                        icon: const Icon(
                                          Icons.favorite_border,
                                          color: Colors.black,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                  )),
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          listener: (BuildContext context, state) {}),
    );
  }
}
