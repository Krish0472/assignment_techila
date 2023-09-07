
// import 'package:applicatio01statemanagment/models/product.dart';
// import 'package:applicatio01statemanagment/providers/providers/provider_page.dart';
// import 'package:applicatio01statemanagment/screens/mycatacalog.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class DetailPage extends StatefulWidget{
//   Product productDetail;
//   DetailPage({required this.productDetail});
// @override
//   State<StatefulWidget> createState() {
//     return DetilPageState();
//   }
// }
//
// class DetilPageState extends State<DetailPage> {
//   late PageController _pageController;
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(viewportFraction: 0.8);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           leading: BackButton(onPressed: (){
//             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyCataLog()));
//           },),
//           title: Text('Detail-Page'),
//         ),
//         body:
//              Column(
//                children: [
//                 SizedBox(height:400 ,
//                   width: MediaQuery.of(context).size.width,
//                   child: PageView.builder(
//                     pageSnapping: true,
//                     controller:_pageController,
//                     itemCount: widget.productDetail.images.length,
//                     itemBuilder: (context,int index){
//                     return Container(
//                       height: 400,
//                       margin: EdgeInsets.all(8.0),
//                       child: Image(image: NetworkImage(widget.productDetail.images[index]),fit: BoxFit.cover,
//                       ),
//                     );
//                     },
//                     // child: Image(
//                     //   image: NetworkImage(data.products[index].thumbnail),fit: BoxFit.fill,),
//                   ),
//                 ),
//                  Divider(),
//              ListView(
//                shrinkWrap: true,
//                children: [
//                  Padding(
//                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
//                    child: Text('${widget.productDetail.title}',
//                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
//                    ),
//                  ),
//
//                  Padding(
//                    padding: EdgeInsets.symmetric(horizontal: 8.0),
//                    child: Text('Description:${widget.productDetail.description}'),
//                  ),
//
//                  Padding(
//                    padding: EdgeInsets.all(8.0),
//                    child: Text('Price:${widget.productDetail.price}',
//
//                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
//                    ),
//                  ),
//
//
//                ],
//
//              ),
//              //     Column(
//              //       children: [
//              //         ListTile(
//              //           title:Text('${widget.productDetail.title}'),
//              //         subtitle: Text('Description:${widget.productDetail.description}',style: TextStyle(fontWeight: FontWeight.bold),),
//              //         ),
//              //         ListTile(
//              //           title: Text('Brand:${widget.productDetail.brand}'),
//              //           subtitle: Text('Rating:${widget.productDetail.rating}'),
//              //
//              //         ),
//              //       ],
//              //     ),
//              //
//              //
//              //
//              //
//                          ],
//               ),
//             );
//
//
//
//   }
// }
// /*
// import 'package:clickmart/view/profile/profile_btn.dart';
// import 'package:flutter/material.dart';
//
// class ProductDetailsPage extends StatelessWidget {
//   final String imageUrl;
//   const ProductDetailsPage({super.key, required this.imageUrl});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product Details'),
//         actions: const [
//           ProfileBtn(),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           // Add your onPressed code here!
//         },
//         label: const Text('Add to Cart'),
//         icon: const Icon(Icons.shopping_cart),
//       ),
//       body: ListView(
//         children: [
//           // Product image
//           Image.network(
//             imageUrl,
//             height: MediaQuery.of(context).size.height / 1.8,
//             fit: BoxFit.fill,
//           ),
//
//           // Product title
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
//             child: Text(
//               'Digital Print Poly Cotton Goa Style Tropical Wear Mens Shirt, Half Sleeves, Magic Cotton',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
//             ),
//           ),
//
//           // Product description
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 8.0),
//             child: Text(
//                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget risus lacus. Curabitur a turpis eros. Cras congue dui nec magna aliquet, quis vehicula libero egestas. Nullam at sollicitudin sem. Sed a augue dictum, tempor mi quis, feugiat neque. Aliquam egestas lectus orci, et rhoncus augue suscipit quis. Ut quis porta magna.'),
//           ),
//
//           // Product price
//           const Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               '\$100',
//               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
//             ),
//           ),
//           const SizedBox(
//             height: 30.0,
//           ),
//         ],
//       ),
//     );
//   }
// }
