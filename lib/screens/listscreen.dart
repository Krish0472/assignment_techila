import 'package:assignment_techila/bloc/cart_bloc.dart';
import 'package:assignment_techila/bloc/data_bloc.dart';
import 'package:assignment_techila/bloc/data_state.dart';
import 'package:assignment_techila/bloc/wishlist_bloc.dart';
import 'package:assignment_techila/screens/detailscreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/data_event.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


class MyCataLog extends StatefulWidget {
  const MyCataLog({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyCataLogState();
  }
}

class _MyCataLogState extends State<MyCataLog> {
  int currentIndex = 0;
  String? address;
  String? _address1;
  Position? _currentPosition;
  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')));
      return false;
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> getPostion() async {
    final hasPermission = await _handlePermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng(_currentPosition!);
    // ignore: invalid_return_type_for_catch_error
    }).catchError((e) => debugPrint(e));
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        address = '${place.postalCode}';
        _address1 = '${place.locality}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
  @override
  void initState() {
    getPostion();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final cbloc = BlocProvider.of<CartBloc>(context);
    final wbloc= BlocProvider.of<WishListBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<DataBloc, DataState>(
        builder: (BuildContext context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SuccessState) {

            return Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)),
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  Card(
                    child: Row(
                      children: [
                        Image.asset('asset/icons8-location-30.png',height: 20,width: 20,),
                        Text(
                          'Deliver to ${_address1.toString()}',
                          style: const TextStyle(
                              fontSize: 10.0, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            address.toString(),
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              bottomRight: Radius.circular(25.0),
                            ),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Image.asset(
                                  'asset/banner1.jpg',
                                  fit: BoxFit.fill,
                                )),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          CarouselSlider.builder(
                            itemCount: state.productList.length,
                            itemBuilder: (BuildContext context, int index, _) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: AspectRatio(
                                  aspectRatio: 16 / 14,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(25.0),
                                      //topRight: Radius.circular(25.0),
                                      bottomRight: Radius.circular(25.0),
                                    ),
                                    child: Image(
                                      image: NetworkImage(
                                          state.productList[index].thumbnail),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                                enlargeCenterPage: true,
                                autoPlay: true,
                                height: 300,
                                viewportFraction: 0.8,
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 3000),
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                }),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('Best Seller'),
                            ),
                          ),
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey)),
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: 3,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 110,
                                            width: 90,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Image.network(
                                                state.productList[index]
                                                    .thumbnail,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 35.0,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(state.productList[index].title,),
                                          const SizedBox(width: 10.0,),
                                          Text('${state.productList[index].price}',softWrap: true,),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15, left: 4),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('Best-SmartPhones'),
                            ),
                          ),
                          SizedBox(
                            height: 280,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: state.productList.length,
                                itemBuilder: (BuildContext context, index) {
                                  if (state.productList[index].category ==
                                      'smartphones') {
                                    return ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                      child: Card(
                                        elevation: 6,
                                        child: SizedBox(
                                          width: 200,
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailPage(productDetail: state.productList[index],),
                                                    ),
                                                  );
                                                },
                                                child: SizedBox(
                                                  height: 200,
                                                  width: 200,
                                                  child: Image.network(
                                                    state.productList[index].thumbnail, fit: BoxFit.cover,),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                                width: 200,
                                                child: Text(state.productList[index].title, style: const TextStyle(fontSize: 15),),
                                              ),
                                              SizedBox(
                                                height: 40,
                                                width: 200,
                                                child: Row(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                          '${state.productList[index].price}'),
                                                    ),

                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 65.0),
                                                      child: IconButton(
                                                          onPressed: () async{
                                                            cbloc.add(AddToCartEvent(state.productList[index]));
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                              content: Text(
                                                                  'item added card'),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10.0))),
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          1),
                                                            ));
                                                          },
                                                          icon: const Icon(
                                                            Icons.add,
                                                            color: Colors.black,
                                                          )),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 7.0),
                                                      child: IconButton(
                                                          onPressed: () {
                                                            wbloc.add(AddToWishListEvent(state.productList[index]));
                                                              ScaffoldMessenger
                                                                  .of(context)
                                                                  .showSnackBar(
                                                                  const SnackBar(
                                                                    content: Text(
                                                                        'item add to wishList'),
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(
                                                                                10.0))),
                                                                    duration:
                                                                    Duration(
                                                                        seconds:
                                                                        1),
                                                                  ));


                                                          },
                                                          icon: const Icon(
                                                            Icons.favorite_border,
                                                            color: Colors.black,
                                                          )
                                                      ),
                                                    ),


                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return null;
                                }),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15, left: 4),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('Best-laptops '),
                            ),
                          ),
                          SizedBox(
                            height: 280,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: state.productList
                                  .map((e) => e.category != "laptops"
                                      ? const SizedBox()
                                      : ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20)),
                                          child: Card(
                                            elevation: 6,
                                            child: SizedBox(
                                              width: 200,
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailPage(
                                                            productDetail: e,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: SizedBox(
                                                      height: 200,
                                                      width: 200,
                                                      child: Image.network(
                                                        e.thumbnail,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                    width: 200,
                                                    child: Text(
                                                      e.title,
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 200,
                                                    child: Row(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              '${e.price}'),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(left: 65.0),
                                                          child: IconButton(
                                                              onPressed: () {
                                                                cbloc.add(AddToCartEvent(e));
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                        const SnackBar(
                                                                  content: Text('item add to cart successfully'),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10.0))),
                                                                  duration:
                                                                      Duration(seconds: 1),
                                                                ));
                                                              },
                                                              icon: const Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              left: 5.0),
                                                          child: IconButton(
                                                              onPressed: () {
                                                                wbloc.add(AddToWishListEvent(e));
                                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                    content: Text('item added to wishlist'),
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.all(
                                                                            Radius.circular(10.0))),
                                                                    duration:
                                                                    Duration(
                                                                        seconds:
                                                                        1),
                                                                  ));



                                                              },
                                                              icon: const Icon(
                                                                Icons.favorite_border,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))
                                  .toList(),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15, left: 4),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('home-decoration'),
                            ),
                          ),
                          SizedBox(
                            height: 280,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: state.productList
                                  .map((e) => e.category != "home-decoration"
                                      ? const SizedBox()
                                      : ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20)),
                                          child: Card(
                                            elevation: 6,
                                            child: SizedBox(
                                              width: 200,
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailPage(
                                                            productDetail: e,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: SizedBox(
                                                      height: 200,
                                                      width: 200,
                                                      child: Image.network(
                                                        e.thumbnail,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                    width: 200,
                                                    child: Text(
                                                      e.title,
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 200,
                                                    child: Row(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              '${e.price}'),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(left: 65.0),
                                                          child: IconButton(
                                                              onPressed: () {
                                                                cbloc.add(AddToCartEvent(e));
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                    const SnackBar(
                                                                      content: Text('item add to cart successfully'),
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10.0))),
                                                                      duration:
                                                                      Duration(seconds: 1),
                                                                    ));
                                                              },
                                                              icon: const Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              left: 5.0),
                                                          child: IconButton(
                                                              onPressed: () {

                                                                  wbloc.add(AddToWishListEvent(e));
                                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                    content: Text('item added to wishlist'),
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.all(
                                                                            Radius.circular(10.0))),
                                                                    duration:
                                                                    Duration(
                                                                        seconds:
                                                                        1),
                                                                  )
                                                                  );
                                                                  },
                                                              icon: const Icon(
                                                                Icons.favorite_border,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))
                                  .toList(),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15, left: 4),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('groceries'),
                            ),
                          ),
                          SizedBox(
                            height: 280,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: state.productList
                                  .map((e) => e.category != "groceries"
                                      ? const SizedBox()
                                      : ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20)),
                                          child: Card(
                                            elevation: 6,
                                            child: SizedBox(
                                              width: 200,
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailPage(
                                                            productDetail: e,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: SizedBox(
                                                      height: 200,
                                                      width: 200,
                                                      child: Image.network(
                                                        e.thumbnail,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                    width: 200,
                                                    child: Text(
                                                      e.title,
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 200,
                                                    child: Row(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              '${e.price}'),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(left: 65.0),
                                                          child: IconButton(
                                                              onPressed: () {
                                                                cbloc.add(AddToCartEvent(e));
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                    const SnackBar(
                                                                      content: Text('item add to cart successfully'),
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10.0))),
                                                                      duration:
                                                                      Duration(seconds: 1),
                                                                    ));
                                                              },
                                                              icon: const Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              left: 5.0),
                                                          child: IconButton(
                                                              onPressed: () {

                                                                  wbloc.add(AddToWishListEvent(e));
                                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                    content: Text('item added to wishlist'),
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.all(
                                                                            Radius.circular(10.0))),
                                                                    duration:
                                                                    Duration(
                                                                        seconds:
                                                                        1),
                                                                  ));
                                                                  },
                                                              icon: const Icon(
                                                                Icons.favorite_border,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))
                                  .toList(),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15, left: 4),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('fragrances'),
                            ),
                          ),
                          SizedBox(
                            height: 280,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: state.productList
                                  .map((e) => e.category != "fragrances"
                                      ? const SizedBox()
                                      : ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20)),
                                          child: Card(
                                            elevation: 6,
                                            child: SizedBox(
                                              width: 200,
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailPage(
                                                            productDetail: e,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: SizedBox(
                                                      height: 200,
                                                      width: 200,
                                                      child: Image.network(
                                                        e.thumbnail,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                    width: 200,
                                                    child: Text(
                                                      e.title,
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 200,
                                                    child: Row(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              '${e.price}'),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(left: 65.0),
                                                          child: IconButton(
                                                              onPressed: () {
                                                                cbloc.add(AddToCartEvent(e));
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                    const SnackBar(
                                                                      content: Text('item add to cart successfully'),
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10.0))),
                                                                      duration:
                                                                      Duration(seconds: 1),
                                                                    ));
                                                              },
                                                              icon: const Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              left: 5.0),
                                                          child:  IconButton(
                                                                onPressed: () {
                                                                  wbloc.add(AddToWishListEvent(e));
                                                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                          content: Text('item added to wishlist'),
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.all(
                                                                                  Radius.circular(10.0))),
                                                                          duration:
                                                                          Duration(
                                                                              seconds:
                                                                              1),
                                                                        ));
                                                                        },
                                                                icon: const Icon(Icons.favorite_border, color: Colors.black,),
                                                              ),
                                                            ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))
                                  .toList(),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15, left: 4),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('skincare'),
                            ),
                          ),
                          SizedBox(
                            height: 280,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: state.productList
                                  .map((e) => e.category != "skincare"
                                      ? const SizedBox()
                                      : ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20)),
                                          child: Card(
                                            elevation: 6,
                                            child: SizedBox(
                                              width: 200,
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailPage(
                                                            productDetail: e,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: SizedBox(
                                                      height: 200,
                                                      width: 200,
                                                      child: Image.network(
                                                        e.thumbnail,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                    width: 200,
                                                    child: Text(
                                                      e.title,
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 200,
                                                    child: Row(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              '${e.price}'),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(left: 65.0),
                                                          child: IconButton(
                                                              onPressed: () {
                                                                cbloc.add(AddToCartEvent(e));
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                    const SnackBar(
                                                                      content: Text('item add to cart successfully'),
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10.0))),
                                                                      duration:
                                                                      Duration(seconds: 1),
                                                                    ));
                                                              },
                                                              icon: const Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              left: 5.0),
                                                          child: IconButton(
                                                              onPressed: () {
                                                                wbloc.add(AddToWishListEvent(e));
                                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                  content: Text('item added to wishlist'),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.all(
                                                                          Radius.circular(10.0))),
                                                                  duration:
                                                                  Duration(
                                                                      seconds:
                                                                      1),
                                                                ));
                                                              },
                                                              icon: const Icon(
                                                                Icons.favorite_border,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))
                                  .toList(),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(10.0)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        listener: (BuildContext context, state) {

        },
      ),
    );
  }
}


