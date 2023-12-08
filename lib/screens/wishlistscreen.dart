import 'package:applicatio01statemanagment/bloc/data_event.dart';
import 'package:applicatio01statemanagment/bloc/wishlist_bloc.dart';
import 'package:applicatio01statemanagment/bloc/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart_bloc.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WishListState();
  }
}

class _WishListState extends State<WishList> {
  late WishListBloc wbloc = BlocProvider.of<WishListBloc>(context);
  late CartBloc cbloc = BlocProvider.of<CartBloc>(context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WishListBloc, WishListState>(
        // buildWhen: (previous, current) => current is loadSuccess,
        // listenWhen: (previous, current) => current is !loadSuccess,
        builder: (BuildContext context, state) {
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            childAspectRatio: 2 / 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 10),
                    itemCount: state.wishListProduct.length,
                    itemBuilder: (BuildContext context, index) {
                      return Card(
                        elevation: 2,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Column(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                      height: 200,
                                      width: 250,
                                      child: Image.network(
                                          state
                                              .wishListProduct[index].thumbnail,
                                          fit: BoxFit.cover))),
                              Row(children: [
                                Flexible(
                                    child: Text(
                                  state.wishListProduct[index].title,
                                )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: IconButton(
                                      onPressed: () {
                                        cbloc.add(AddToCartEvent(
                                            state.wishListProduct[index]));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              'item add to cart successfully'),
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
                                  padding: const EdgeInsets.only(left: 4),
                                  child: IconButton(
                                      onPressed: () {
                                        wbloc.add(RemoveProductFromWishList(
                                            state.wishListProduct[index]));
                                      },
                                      icon: const Icon(Icons.delete)),
                                )
                              ])
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          );
        },
        listener: (BuildContext context, WishListState state) {},
      ),
    );
  }
}
