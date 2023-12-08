import 'package:assignment_techila/bloc/cart_bloc.dart';
import 'package:assignment_techila/bloc/data_bloc.dart';
import 'package:assignment_techila/bloc/data_event.dart';
import 'package:assignment_techila/bloc/data_state.dart';
import 'package:assignment_techila/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product.dart';

class DetailPage extends StatefulWidget {
  final Product productDetail;
  const DetailPage({super.key, required this.productDetail});
  @override
  State<StatefulWidget> createState() {
    return DetilPageState();
  }
}

class DetilPageState extends State<DetailPage> {
  late PageController _pageController;
  late String name;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
      builder: (BuildContext context, state) {
        if (state is SuccessState) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.black,
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      name = prefs.getString('name')!;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(name.substring(0, 7))));
                    },
                  ),
                  pinned: true,
                  expandedHeight: 350,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: SizedBox(
                        height: 250,
                        child: PageView.builder(
                          pageSnapping: true,
                          controller: _pageController,
                          itemCount: widget.productDetail.images.length,
                          itemBuilder: (context, int index) {
                            return ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
                              child: Card(
                                elevation: 4,
                                child: Image(
                                  image: NetworkImage(
                                      widget.productDetail.images[index]),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 8.0),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productDetail.title.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            height: 30,
                            child: Text('Brand:${widget.productDetail.brand}')),
                        //Text('Price:\u{20B9}${widget.productDetail.price.toString()}'),
                        SizedBox(
                          height: 35.0,
                          child: Row(
                            children: [
                              Text(
                                '\u{20B9}${widget.productDetail.price.toString()}',
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        ExpansionTile(
                          title: const Text('Description',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          children: [
                            SizedBox(
                                height: 50,
                                child: Text(
                                  widget.productDetail.description.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),
                                ))
                          ],
                        ),
                        ExpansionTile(
                          title: const Text('discountPercentage',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  widget.productDetail.discountPercentage
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 55,
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                            minimumSize: const Size(400, 50), //////// HERE
                          ),
                          onPressed: () {
                            context
                                .read<CartBloc>()
                                .add(AddToCartEvent(widget.productDetail));
                            //data.addToCart(widget.productDetail);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text('Item Added To Cart successfully'),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ));
                          },
                          child: const Text(
                            'add to cart',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

/*
ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.black45,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          minimumSize: Size(400, 40), //////// HERE
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyCart()));
                        },
                        child: Text('Go To Cart',style: TextStyle(color: Colors.black),),
                      )
 */

/*
return  Scaffold(backgroundColor: Colors.black12,
        body: SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(backgroundColor: Colors.grey,
                    leading: BackButton(color: Colors.black,onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyCataLog()));
                      },
                  ),
                    title: Text('Detail Page',style: TextStyle(color: Colors.black),),
                    pinned: true,
                    expandedHeight: 250,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        height: 250,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [Colors.grey,Colors.black])),
                        child: PageView.builder(
                          pageSnapping: true,
                          controller: _pageController,
                          itemCount: widget.productDetail.images.length,
                          itemBuilder: (context, int index) {
                            return Container(
                              decoration: BoxDecoration(color: Colors.black12),
                                  margin: EdgeInsets.all(8.0),
                                  child: Image(image: NetworkImage(
                                  widget.productDetail.images[index]),
                                    fit: BoxFit.fill,
                                  ),
                               );
                             },
                           ),
                         ),
                       ),
                      ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(top: 8.0),
                      decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.grey,Colors.white])),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Text(widget.productDetail.description.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                          SizedBox(height: 10,),
                          Text('Price:\u{20B9}${widget.productDetail.price.toString()}'),
                          SizedBox(height: 8.0,),
                          Text('Discounted Price Percentage ${widget.productDetail.discountPercentage}%'),
                          SizedBox(height: 150.0,
                            child: Container(
                              child: Row(
                                children: [
                                  SizedBox(height: 30,
                                    child: Text('Rating:${widget.productDetail.rating}'),),
                                  Padding(padding: EdgeInsets.only(left: 8.0)),
                                  SizedBox(height:30,child: Text('Brand:${widget.productDetail.brand}')),
                                  Padding(padding: EdgeInsets.only(left: 8.0)),
                                  Flexible(child: SizedBox(height:30,child: Text('Catagory:${widget.productDetail.category}'))),
                                ],
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.black45,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              minimumSize: Size(400, 40), //////// HERE
                            ),
                            onPressed: () {
                              data.addToCart(widget.productDetail);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),content: Text('Item Added To Cart successfully'),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)
                                )
                                ),
                              )
                              );
                            },
                            child: Text('Add To Cart',style: TextStyle(color: Colors.black),),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.black45,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              minimumSize: Size(400, 40), //////// HERE
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyCart()));
                            },
                            child: Text('Go To Cart',style: TextStyle(color: Colors.black),),
                          )


                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context,int index) {
                     // int ind = widget.productDetail.images.length;
                    return Column(
                      children: [
                      const SizedBox(
                        height:50,child: Column(
                        children: [
                        Text('Review Here'),
                          Text('FeedBack Here'),
                          Text('Details'),

                        ],
                      ),
                      ),
                 for(final image in widget.productDetail.images)
                   Image(
                        image: NetworkImage(
                            image),
                      ),
                    ],
                    );
                  }, childCount: 1),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
 */

/*
SliverList(
                delegate: SliverChildBuilderDelegate((context,int index) {
                  // int ind = widget.productDetail.images.length;
                  return Column(
                    children: [
                      const SizedBox(
                        height:50,child: Column(
                        children: [
                          Text('Review Here'),
                          Text('FeedBack Here'),
                          Text('Details'),

                        ],
                      ),
                      ),
                      for(final image in widget.productDetail.images)
                        Image(
                          image: NetworkImage(
                              image),
                        ),
                    ],
                  );
                }, childCount: 1),
              ),
 */
