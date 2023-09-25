import 'package:applicatio01statemanagment/bloc/cart_bloc.dart';
import 'package:applicatio01statemanagment/bloc/data_bloc.dart';
import 'package:applicatio01statemanagment/bloc/data_state.dart';
import 'package:applicatio01statemanagment/screens/detailscreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/data_event.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MyCataLog extends StatefulWidget {
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
    }).catchError((e) => print(e));
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
      print(e);
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
                  Card(elevation: 2,
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
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 80.0,
                            width: MediaQuery.of(context).size.width,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: [
                                Card(
                                  child: SizedBox(
                                    width: 60,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                            child:
                                                Image.asset('asset/apple.png'),
                                          ),
                                          //SizedBox(height:90,child: Image.asset('asset/apple.png')),
                                          const Text(
                                            'mobile',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 8.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: SizedBox(
                                    width: 60,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                            child: Image.asset(
                                                'asset/laptop.jpeg'),
                                          ),
                                          //SizedBox(height:90,child: Image.asset('asset/laptop.jpeg')),
                                          const Text(
                                            'laptops',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 8.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: SizedBox(
                                    width: 60,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                            ),
                                            child:
                                                Image.asset('asset/mkup.jpeg'),
                                          ),
                                          // SizedBox(height:90,child: Image.asset('asset/mkup.jpeg')),
                                          const Text(
                                            'Beauity',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 8.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: SizedBox(
                                    width: 60,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                            child:
                                                Image.asset('asset/homeD.jpeg'),
                                          ),
                                          //SizedBox(height:90,child: Image.asset('asset/homeD.jpeg')),
                                          const Text(
                                            'decoration',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 8.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: SizedBox(
                                    width: 60,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                            ),
                                            child:
                                                Image.asset('asset/veg2.jpeg'),
                                          ),
                                          // SizedBox(height:90,child: Image.asset('asset/veg2.jpeg')),
                                          const Text(
                                            'vegitables',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 8.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: SizedBox(
                                    width: 60,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                            ),
                                            child: Image.asset(
                                              'asset/ele0'
                                              '.jpeg',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const Text(
                                            'electronics',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 8.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              //topRight: Radius.circular(25.0),
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
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${state.productList[index].title}',
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            '${state.productList[index].price}',
                                            softWrap: true,
                                          ),
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
                                      borderRadius: BorderRadius.only(
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
                                                        productDetail: state
                                                            .productList[index],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: SizedBox(
                                                  height: 200,
                                                  width: 200,
                                                  child: Image.network(
                                                    state.productList[index]
                                                        .thumbnail,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                                width: 200,
                                                child: Text(
                                                  '${state.productList[index].title}',
                                                  style:
                                                      TextStyle(fontSize: 15),
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
                                                          '${state.productList[index].price}'),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 100.0),
                                                      child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              shape:
                                                                  StadiumBorder(),
                                                              elevation: 2,
                                                              backgroundColor:
                                                                  Colors
                                                                      .blueGrey),
                                                          onPressed: () {
                                                            cbloc.add(AddToCartEvent(
                                                                state.productList[
                                                                    index]));
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                              content: Text(
                                                                  'Item Added Succesfully'),
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
                                                          child: Icon(
                                                            Icons.add,
                                                            color: Colors.black,
                                                          )),
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
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 100.0),
                                                          child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  shape:
                                                                      const StadiumBorder(),
                                                                  elevation: 2,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .blueGrey),
                                                              onPressed: () {
                                                                cbloc.add(
                                                                    AddToCartEvent(
                                                                        e));
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        const SnackBar(
                                                                  content: Text(
                                                                      'Item Added Succesfully'),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10.0))),
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                ));
                                                              },
                                                              child: const Icon(
                                                                Icons.add,
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
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 100.0),
                                                          child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  shape:
                                                                      const StadiumBorder(),
                                                                  elevation: 2,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .blueGrey),
                                                              onPressed: () {
                                                                cbloc.add(
                                                                    AddToCartEvent(
                                                                        e));
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        const SnackBar(
                                                                  content: Text(
                                                                      'Item Added Succesfully'),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10.0))),
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                ));
                                                              },
                                                              child: const Icon(
                                                                Icons.add,
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
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 100.0),
                                                          child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  shape:
                                                                      const StadiumBorder(),
                                                                  elevation: 2,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .blueGrey),
                                                              onPressed: () {
                                                                cbloc.add(
                                                                    AddToCartEvent(
                                                                        e));
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        const SnackBar(
                                                                  content: Text(
                                                                      'Item Added Succesfully'),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10.0))),
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                ));
                                                              },
                                                              child: const Icon(
                                                                Icons.add,
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
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 100.0),
                                                          child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  shape:
                                                                      const StadiumBorder(),
                                                                  elevation: 2,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .blueGrey),
                                                              onPressed: () {
                                                                cbloc.add(
                                                                    AddToCartEvent(
                                                                        e));
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        const SnackBar(
                                                                  content: Text(
                                                                      'Item Added Successfully'),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10.0))),
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                ));
                                                              },
                                                              child: const Icon(
                                                                Icons.add,
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
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 100.0),
                                                          child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  shape:
                                                                      const StadiumBorder(),
                                                                  elevation: 2,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .blueGrey),
                                                              onPressed: () {
                                                                cbloc.add(
                                                                    AddToCartEvent(
                                                                        e));
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        const SnackBar(
                                                                  content: Text(
                                                                      'Item Added Successfully'),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10.0))),
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                ));
                                                              },
                                                              child: const Icon(
                                                                Icons.add,
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
        listener: (BuildContext context, state) {},
      ),
    );
  }
}

/*
   '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 GridView.builder(
                            itemCount: state.productList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2 / 3,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 10),
                            itemBuilder: (BuildContext context, int indd) {
                             return Column(
                                 children: [
                                   Expanded(
                                     child: GestureDetector(
                                       onTap: () {
                                         Navigator.pushReplacement(
                                           context,
                                           MaterialPageRoute(
                                             builder: (context) => DetailPage(
                                               productDetail:
                                               state.productList[indd],
                                             ),
                                           ),
                                         );
                                       },
                                       child: Container(
                                         child: Image.network(
                                           state.productList[indd].thumbnail,
                                           fit: BoxFit.cover,
                                         ),
                                         decoration: BoxDecoration(
                                             borderRadius:
                                             BorderRadius.circular(15)),
                                       ),
                                     ),
                                   ),
                                   Row(
                                     children: [
                                       Flexible(
                                         child: Column(
                                           children: [
                                             Text(
                                               state.productList[indd].title,
                                               softWrap: true,
                                               style:
                                               TextStyle(color: Colors.black),
                                             ),
                                             Align(
                                               alignment: Alignment.topLeft,
                                               child: Text(
                                                 '${state.productList[indd].price}',
                                                 softWrap: true,
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),
                                       Padding(
                                         padding: EdgeInsets.only(left: 50.0),
                                         child: ElevatedButton(
                                           style: ElevatedButton.styleFrom(
                                               backgroundColor: Colors.grey),
                                           onPressed: () {
                                             cbloc.add(AddToCartEvent(
                                                 state.productList[indd]));
                                             ScaffoldMessenger.of(context)
                                                 .showSnackBar(const SnackBar(
                                               content:
                                               Text('Item Added Succesfully'),
                                               shape: RoundedRectangleBorder(
                                                   borderRadius: BorderRadius.all(
                                                       Radius.circular(10.0))),
                                               duration: Duration(seconds: 1),
                                             ));
                                           },
                                           child: const Text(
                                             'ADD',
                                             style: TextStyle(color: Colors.black),
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ]);

                            },

                          ),
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

 return Column(
                                  children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailPage(
                                              productDetail:
                                                  state.productList[indd],
                                              ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      child: Image.network(
                                        state.productList[indd].thumbnail,
                                        fit: BoxFit.cover,
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        children: [
                                          Text(
                                            state.productList[indd].title,
                                            softWrap: true,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              '${state.productList[indd].price}',
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 50.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey),
                                        onPressed: () {
                                          cbloc.add(AddToCartEvent(
                                              state.productList[indd]));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content:
                                                Text('Item Added Succesfully'),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            duration: Duration(seconds: 1),
                                          ));
                                        },
                                        child: const Text(
                                          'ADD',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]);


bottomNavigationBar: SizedBox(
      height: 50.0,
      child: Row(
        children: [
          InkWell(onTap: (){
            print('hii i clicked');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyCataLog()));
          },child: SizedBox(width:90,child: Image.asset('asset/icons8-aliexpress-48.png'))),
          GestureDetector(onTap: (){
            print('cart is clicked');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyCart()));
          },child: SizedBox(width: 140,child: Image.asset('asset/icons8-cart-50.png'),)),
          InkWell(onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserDetail()));
          },child: SizedBox(width: 130,child: Image.asset('asset/icons8-account-50.png'),))

        ],
      ),
    ),


GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20
                              ),
                              itemCount: cat.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(cat[index]),
                                );
                              }
                              ),


appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
            color: Colors.black,
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => BlocPage()))),
        actions: [

          IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyCart(widget.userName)));
              },
              icon: Icon(Icons.shopping_cart))
        ],
      ),
==========
Consumer<DataProvider>(
          builder: (context,data,child){
            var ind = data.products.length;
            if(data.products.isNotEmpty){
              return SingleChildScrollView(physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    CarouselSlider(items:
                    [
                      Container(
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage(data.products[ind].images[ind]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                    ],
                        options: CarouselOptions(
                          height: 280,
                          viewportFraction: 0.8,
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                        ),
                        ),
                    ListView.builder(physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.products.length,
                      itemBuilder: (context,int index){
                      return Column(
                        children: [
                          SizedBox(height: 20,),
                          Text(data.products[index].title),
                          SizedBox(height: 20,),
                          Text(data.products[index].thumbnail),
                          SizedBox(height: 20,),
                          Text(data.products[index].rating.toString()),
                          SizedBox(height: 20,),
                          Text(data.products[index].quantity.toString()),
                          SizedBox(height: 20,),
                          Text(data.products[index].category.toString()),
                        ],
                      );
                    },),
                  ],
                ),
            );
          } else
            return
              Center(
                  child: CircularProgressIndicator()
              );


          },
        ),
 */
/*
Consumer<DataProvider>(
      builder: (context, data, child) {
        if (data.products.isNotEmpty) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Product',
                style: TextStyle(color: Colors.black),
              ),
              leading: BackButton(
                  color: Colors.black,
                  onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ProviderPage()))),
              actions: [
                IconButton(color: Colors.black,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyCart()));
                    },
                    icon: Icon(Icons.shopping_cart))
              ],
            ),
          );
        } else
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
      },
    );
 */
/*

 Container(
              child: Expanded(
                child: ListView(shrinkWrap: true,
                  children:[
                    Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.blue,
                            Colors.white,
                          ]),
                    ),
                    child: Column(
                      children: [
                        Container(height: 400,
                          child: PageView.builder(
                            pageSnapping: true,
                            controller: _pageControllerp,
                            itemCount: data.products.length,
                            itemBuilder: (context, int index) {
                              return Expanded(
                                child: Column(
                                  children: [
                                    for(final image in data.products[0].images)
                                      Image(fit: BoxFit.fill,
                                        image: NetworkImage(
                                            image),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2 / 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 10),
                              itemCount: data.products.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => DetailPage(
                                                        productDetail:
                                                            data.products[index],
                                                      )));
                                        },
                                        child: Image.network(
                                          data.products[index].thumbnail,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                             Colors.blueAccent,
                                              Colors.white,
                                            ]),
                                      ),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data.products[index].title,
                                                  softWrap: true,
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                                Text(
                                                  '${data.products[index].price}',
                                                  softWrap: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 50.0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.grey),
                                              onPressed: () {
                                                data.addToCart(data.products[index]);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text('Item Added Succesfully'),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10.0))),
                                                  duration: Duration(seconds: 1),
                                                ));
                                              },
                                              child: Text(
                                                'ADD',
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                              ),
                        ),
                      ],
                    ),
                  ),
                  ],
                ),
              ),
            ),
 */

/*
  GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: myProducts.length,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(15)),
                child: Text(myProducts[index]["name"]),
              );
            }),

   */
// body: ListView.builder(itemCount:data.products.length,
//     itemBuilder: (context,int index){
//   return Card(
//     child: Column(
//       children: [
//         SizedBox(
//           height: 100,
//        width: 100,
//        child: Image.network(data.products[index].thumbnail),),
//         Row(
//           children: [
//             Text(data.products[index].title,style: TextStyle(color: Colors.red,fontSize: 15),),
//             SizedBox(width: 20.0,),
//             Text('${data.products[index].price}'),
//           ],
//         ),
//       ],
//     ),
//   );
// List<Product> cart = [];
// return ListTile(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)),side: BorderSide(width: 5.0)),
//   leading: CircleAvatar(child: Text('${data.products[index].id}')),
//   title: Text(data.products[index].title),
//   subtitle: Text('${data.products[index].price}'),
//   trailing: IconButton(onPressed: (){
//     data.addToCart(data.products[index]);
//     // provider.addToCart(data.products[index]);
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item Added Succesfully'),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
//       duration: Duration(seconds: 2),));
//     // cart.add(data.products[index]);
//
//   },icon: Icon(Icons.add_shopping_cart_outlined),),
// );
//         }
//     ),
//   );
// }
// );

//}

/*
 /*
                       margin: EdgeInsets.all(8.0),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10.0),
                                     image: Stack(
                                       children: [

                                       ],
                                     )
                       DecorationImage(
                                       image: NetworkImage(state.productList[index].thumbnail),
                                       fit: BoxFit.cover,
                           ),
                        */
 */
