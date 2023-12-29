// ignore_for_file: use_build_context_synchronously

import 'package:assignment_techila/screens/cartscreen.dart';
import 'package:assignment_techila/screens/userdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Payment extends StatefulWidget{
  const Payment({super.key});

  @override
  State<StatefulWidget> createState() {
   return _PaymentState();
  }

}

class _PaymentState extends State<Payment>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation:0,
        backgroundColor: Colors.white,
        leading: BackButton(onPressed: ()async{
          final SharedPreferences  preferences = await SharedPreferences.getInstance();
          String? name = preferences.getString('name');

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserDetail(name!)));
      },
      color: Colors.black,),
      ),
      body: Column(
        children: [
          CreditCardWidget(
          isHolderNameVisible: true,
          cardHolderName: 'krishna singh',
          cardNumber: '124554211234',
          expiryDate: '09/28',
          cvvCode: '090',
          showBackView: true,
          onCreditCardWidgetChange: (creditCardBrand) {  },
          bankName: 'Axis Bank',
          backgroundImage: 'asset/card_bg.png',
          isChipVisible: true,
          cardType: CardType.visa,
          height: 230,
          isSwipeGestureEnabled: true,
          obscureCardNumber: true,



        ),
          const SizedBox(height: 300,),
          ElevatedButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyCart()));
          }, child: const Text('Back To Cart '))
       ] ),
    );
  }
}