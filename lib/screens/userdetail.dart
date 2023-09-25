import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetail extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _UserDetailState();
  }
}

class _UserDetailState extends State<UserDetail>{
  String name ='';
  void getName() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    name = pref.getString('name')!;
    print(name);
  }


  @override
  Widget build(BuildContext context) {
    getName();
    print(name);
   return Scaffold(
     body: Container(
       height:MediaQuery.of(context).size.height,
       width: MediaQuery.of(context).size.width,
       padding: EdgeInsets.all(12.0),
       child:  Column(
         children: [
           SizedBox(
             height: 190,width: 410,
             child: ClipRRect(
               borderRadius:  const BorderRadius.only(
                 topLeft: Radius.circular(35.0),
                 //topRight: Radius.circular(25.0),
                 bottomRight: Radius.circular(35.0),
               ),
               child: Card(color: Colors.white,elevation: 5,
                 child: Stack(
                   children: [
                     Container(color: Colors.white,),
                       Positioned(child:Center(child: Text(name,style: TextStyle(color: Colors.black),)), )
                   ],
                 ),
               ),
             ),
           ),
           Expanded(
             child: SingleChildScrollView(
               physics: AlwaysScrollableScrollPhysics(),
               child: Column(
                 children: [
                   SizedBox(
                     height: 100,width: 410,
                     child: Row(
                       children: [
                         SizedBox(height: 70,width: 110,
                           child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(20)),
                           child: Card(
                             color: Colors.blue,
                             elevation: 3,
                             child: Text('hey'),
                           ),),
                         ),

                         SizedBox(height: 70,width: 110,
                           child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(20)),
                             child: Card(
                               color: Colors.orange,
                               elevation: 3,
                               child: Text('hello'),
                             ),),
                         ),
                         SizedBox(height: 70,width: 110,
                           child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(20)),
                             child: Card(
                               color: Colors.yellowAccent,
                               elevation: 3,
                               child: Text('welcom'),
                             ),),
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
             ),
           ),

           SizedBox(height: 90,width: 410,
             child: Card(elevation: 3,
               color: Colors.green,
               child: Row(
               children: [
                 Text('how r you'),
                 Padding(
                   padding: const EdgeInsets.only(left: 219),
                   child: IconButton(onPressed: (){},
                       icon: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 16,)),
                 )
               ],
           ),
             ),
           ),
           SizedBox(height: 90,width: 410,
             child: Card(elevation: 3,
               color: Colors.red,
               child: Row(
                 children: [
                   Text('how r you'),
                   Padding(
                     padding: const EdgeInsets.only(left: 219),
                     child: IconButton(onPressed: (){},
                         icon: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 16,)),
                   )
                 ],
               ),
             ),
           ),
           SizedBox(height: 90,width: 410,
             child: Card(elevation: 3,
               color: Colors.pinkAccent,
               child: Row(
                 children: [
                   Text('how r you'),
                   Padding(
                     padding: const EdgeInsets.only(left: 219),
                     child: IconButton(onPressed: (){},
                         icon: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 16,)),
                   ),
                   
                 ],
               ),
             ),
           ),
           SizedBox(height: 90,width: 410,
             child: Card(elevation: 3,
               color: Colors.green,
               child: Row(
                 children: [
                   Text('how r you'),
                   Padding(
                     padding: const EdgeInsets.only(left: 219),
                     child: IconButton(onPressed: (){},
                         icon: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 16,)),
                   )
                 ],
               ),
             ),
           ),
           SizedBox(height: 90,width: 410,
             child: Card(elevation: 3,
               color: Colors.brown,
               child: Row(
                 children: [
                   Text('how r you'),
                   Padding(
                     padding: const EdgeInsets.only(left: 219),
                     child: IconButton(onPressed: (){},
                         icon: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 16,)),
                   )
                 ],
               ),
             ),
           ),

         ],
       ),
     ),
   );
  }

}

/*
 Text(name.substring(0,7),style: TextStyle(color: Colors.black),),
 */