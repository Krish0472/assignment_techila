import 'package:applicatio01statemanagment/providers/providers/provider_page.dart';
import 'package:applicatio01statemanagment/screens/mycart.dart';
import 'package:applicatio01statemanagment/screens/mycatacalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';


class DetailPage extends StatefulWidget{
  Product productDetail;
  DetailPage({required this.productDetail});
@override
  State<StatefulWidget> createState() {
    return DetilPageState();
  }
}
class DetilPageState extends State<DetailPage> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context,data,child){
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
    },
    );
  }

}



