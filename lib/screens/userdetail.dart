import 'package:applicatio01statemanagment/screens/homescreen.dart';
import 'package:applicatio01statemanagment/screens/paymentscreen.dart';
import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {
  String name;
  UserDetail(this.name, {super.key});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 35,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(widget.name)));
                    },
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 190,
                width: 410,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35.0),
                    //topRight: Radius.circular(25.0),
                    bottomRight: Radius.circular(35.0),
                  ),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.black,
                        ),
                        Positioned(
                          child: Center(
                              child: Text(
                            'welcome ${widget.name.substring(0, 7)}',
                            style: const TextStyle(color: Colors.white),
                          )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                          width: 410,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 70,
                                width: 120,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 3,
                                    child: Column(children: [
                                      Padding(
                                          padding: EdgeInsets.only(top: 12.0),
                                          child: Icon(
                                            Icons.favorite_border,
                                            size: 20,
                                          )),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text('likes'),
                                      )
                                    ]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 70,
                                width: 110,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 3,
                                    child: Column(children: [
                                      Padding(
                                          padding: EdgeInsets.only(top: 12.0),
                                          child: Icon(
                                            Icons.payment,
                                            size: 20,
                                          )),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text('payments'),
                                      )
                                    ]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 70,
                                width: 120,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 3,
                                    child: Column(children: [
                                      Padding(
                                          padding: EdgeInsets.only(top: 12.0),
                                          child: Icon(
                                            Icons.settings,
                                            size: 20,
                                          )),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text('setting'),
                                      )
                                    ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 75,
                          width: 410,
                          child: Card(
                              elevation: 3,
                              color: Colors.white,
                              child: ListTile(
                                leading: const ImageIcon(
                                    AssetImage('asset/icons8-account-30.png')),
                                title: const Text('Your Profile'),
                                trailing: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                    )),
                              )),
                        ),
                        SizedBox(
                          height: 75,
                          width: 410,
                          child: Card(
                              elevation: 3,
                              color: Colors.white,
                              child: ListTile(
                                leading: const Icon(
                                  Icons.star_border_outlined,
                                  size: 20,
                                ),
                                title: const Text('Your Rating'),
                                trailing: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                    )),
                              )),
                        ),
                        SizedBox(
                          height: 290,
                          width: 410,
                          child: Card(
                              elevation: 0,
                              color: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Orders Details',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  Card(
                                    elevation: 1,
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.card_travel_outlined,
                                        size: 20,
                                      ),
                                      title: const Text('Your Orders'),
                                      trailing: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 20,
                                          )),
                                    ),
                                  ),
                                  Card(
                                    elevation: 1,
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.favorite_border,
                                        size: 20,
                                      ),
                                      title: const Text('favorite Orders'),
                                      trailing: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 20,
                                          )),
                                    ),
                                  ),
                                  Card(
                                    elevation: 1,
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.help,
                                        size: 20,
                                      ),
                                      title: const Text('help'),
                                      trailing: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 20,
                                          )),
                                    ),
                                  ),
                                  Card(
                                    elevation: 1,
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.location_city,
                                        size: 20,
                                      ),
                                      title: const Text('address book'),
                                      trailing: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 20,
                                          )),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: 225,
                          width: 410,
                          child: Card(
                            elevation: 3,
                            color: Colors.grey.shade100,
                            child: Column(
                              children: [
                                const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Payments Details',
                                      style: TextStyle(fontSize: 18),
                                    )),
                                Card(
                                  elevation: 1,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.credit_score,
                                      size: 20,
                                    ),
                                    title: const Text('saved cards'),
                                    trailing: IconButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Payment()));
                                        },
                                        icon: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                        )),
                                  ),
                                ),
                                Card(
                                  elevation: 1,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.credit_card_outlined,
                                      size: 20,
                                    ),
                                    title: const Text('add new card'),
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                        )),
                                  ),
                                ),
                                Card(
                                  elevation: 1,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.credit_card_outlined,
                                      size: 20,
                                    ),
                                    title: const Text('delete card'),
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 290,
                          width: 410,
                          child: Card(
                            elevation: 1,
                            color: Colors.grey.shade100,
                            child: Column(
                              children: [
                                const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'More',
                                      style: TextStyle(fontSize: 18),
                                    )),
                                Card(
                                  elevation: 1,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.feedback_sharp,
                                      size: 20,
                                    ),
                                    title: const Text('feedback'),
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                        )),
                                  ),
                                ),
                                Card(
                                  elevation: 1,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.account_box_outlined,
                                      size: 20,
                                    ),
                                    title: const Text('about'),
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                        )),
                                  ),
                                ),
                                Card(
                                  elevation: 1,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.report,
                                      size: 20,
                                    ),
                                    title: const Text('report'),
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                        )),
                                  ),
                                ),
                                Card(
                                  elevation: 1,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.logout_outlined,
                                      size: 20,
                                    ),
                                    title: const Text('logout'),
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
