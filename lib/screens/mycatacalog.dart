

import 'package:applicatio01statemanagment/bloc/car_bloc.dart';
import 'package:applicatio01statemanagment/bloc/data_bloc.dart';
import 'package:applicatio01statemanagment/bloc/data_event.dart';
import 'package:applicatio01statemanagment/bloc/data_state.dart';
import 'package:applicatio01statemanagment/screens/login_page.dart';
import 'package:applicatio01statemanagment/providers/providers/provider_page.dart';
import 'package:applicatio01statemanagment/screens/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:provider/provider.dart';
import 'mycart.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyCataLog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyCataLogState();
  }
}

class _MyCataLogState extends State<MyCataLog> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   // final bloc = BlocProvider.of<DataBloc>(context);
    final cbloc = BlocProvider.of<CartBloc>(context);
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
                MaterialPageRoute(builder: (context) => BlocPage()))),
        actions: [
          IconButton(color: Colors.black,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyCart()));
              },
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: SafeArea(
       child: BlocConsumer<DataBloc , DataState>(
         builder: (BuildContext context, state) {
           if(state is LoadingState){
             return Center(
               child: CircularProgressIndicator(),
             );
           }
           if(state is SuccessState){
             return Container(
               child: SingleChildScrollView(
                 physics: AlwaysScrollableScrollPhysics(),
                 child: Column(
                   children: [
                     SizedBox(height: 60.0,
                       child: ListView.builder(
                           scrollDirection: Axis.horizontal,
                           itemCount: state.productList.length,
                           itemBuilder: (context ,pos){
                             return Initicon(elevation: 2,backgroundColor: Colors.white,text: state.productList[pos].title,);
                           }),
                     ),
                     CarouselSlider.builder(
                         itemCount: state.productList.length,
                         itemBuilder: (BuildContext context,int index,_){
                           return Container(
                             child: Stack(
                               children: [
                                 Positioned(child: Image(image: NetworkImage(state.productList[index].thumbnail),
                                     fit: BoxFit.cover,),
                                 ),
                                 Positioned(bottom:10,child: Text(state.productList[index].title)),

                               ],

                             ),
                           );
                         },
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
                         options: CarouselOptions(
                               height: 300,
                               viewportFraction: 0.8,
                               autoPlayAnimationDuration: Duration(milliseconds: 800),
                             ),
                     ),
                     GridView.builder(physics: NeverScrollableScrollPhysics(),
                             shrinkWrap: true,
                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                             crossAxisCount: 2,
                             childAspectRatio: 2 / 3,
                             crossAxisSpacing: 5,
                             mainAxisSpacing: 10
                         ),
                         itemBuilder: (BuildContext context ,int indd){
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
                                             )));
                                   },
                                   child: Image.network(
                                     state.productList[indd].thumbnail,
                                     fit: BoxFit.fill,
                                   ),
                                 ),
                               ),

                           Container(
                           decoration: const BoxDecoration(
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
                           Text(state.productList[indd].title, softWrap: true, style: TextStyle(color: Colors.black),),
                           Text('${state.productList[indd].price}', softWrap: true,),
                           ],
                           ),
                           ),
                           Padding(
                           padding: EdgeInsets.only(left: 50.0),
                           child: ElevatedButton(
                           style: ElevatedButton.styleFrom(
                           backgroundColor: Colors.grey),
                           onPressed: () {
                             cbloc.add(AddToCartEvent(state.productList[indd]));

                             //print('Add To cart is called ${state.productList[indd].title}');


                          // state.addToCart(data.products[index]);
                           ScaffoldMessenger.of(context)
                               .showSnackBar(const SnackBar(
                           content: Text('Item Added Succesfully'),
                           shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.all(
                           Radius.circular(10.0))),
                           duration: Duration(seconds: 1),
                           ));
                           },
                           child: const Text('ADD', style: TextStyle(color: Colors.black),),),),],),),]);},
                       itemCount: state.productList.length,
                         ),
                   ],
                 ),
               ),

             );
           }
           return Container(child: Center(child: CircularProgressIndicator(),),);
         },
         listener: (BuildContext context, state) {
         },),
      ),

    );
  }
}

/*
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
