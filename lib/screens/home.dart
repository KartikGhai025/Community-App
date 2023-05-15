import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/screens/cityPicker.dart';

import '../providers/cityProvider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: Duration(milliseconds: 100),
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.black,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.group),
                text: 'Groups',
              ),
              Tab(
                icon: Icon(Icons.event),
                text: 'Events',
              ),
              // Tab(icon: Icon(Icons.logout),
              //   text: 'Logout',),
            ],
          ),
        ),
        body: TabBarView(
          children: [GroupsScreen(), Text('Events')],
        ),
      ),
    );
  }
}

class GroupsScreen extends StatefulWidget {
  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  String? countryValue;
  String? stateValue;
  String? cityValue;

  @override
  Widget build(BuildContext context) {
    CollectionReference msg = FirebaseFirestore.instance.collection('messages');

    return Consumer<CityProvider>(
        builder: ((context, city, child) => Scaffold(
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.location_city),
                onPressed: () {
                 selectCity(city, context);
                },
              ),
              body: FutureBuilder<DocumentSnapshot>(
                future: msg.doc(city.city).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return Column(children: [
                      Text("No Group Exist in ${city.city}"),
                      MaterialButton(
                          child: Text('Create Your Group'),
                          onPressed: () {
                            city.selectGroup('New Group');
                            setState(() {
                              msg.doc(city.city).set({
                                'group': ["New Group"]
                              });
                            });
                            Navigator.pushNamed(context, 'chatscreen');
                          })
                    ]);
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    //  for (var i in data['group'])
                    return groupLists(data['group'], context, city);
                    //Text("Full Name: ${data['City']} ${data['group']}");
                  }

                  return Text("loading");
                },
              ),
            )));
  }

  selectCity(CityProvider cp, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      barrierColor: Colors.blue.withOpacity(0.2),
      backgroundColor: Colors.white,
      elevation: 1000,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SelectState(
                //   dropdownColor: Colors.lightBlue,
                onCountryChanged: (value) {
                  setState(() {
                    countryValue = value;
                      cp.selectCountry(value);
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    stateValue = value;
                       cp.selectState(value);
                  });
                },
                onCityChanged: (value) {
                  setState(() {
                    cityValue = value;
                    cp.selectCity(value);
                  });
                },
              ),
              InkWell(
                  onTap: () {
                    print('country selected is $countryValue');
                    print('country selected is $stateValue');
                    print('country selected is $cityValue');
                  },
                  child: Text(' Check'))
            ],
          ),
        );
      },
    );
  }

  Widget groupLists(List groups, BuildContext context, CityProvider city) {
    return ListView(
      children: [
        for (var i in groups)
          InkWell(
            onTap: () {
              city.selectGroup(i);
              Navigator.pushNamed(context, 'chatscreen');
            },
            child: Container(
              margin: EdgeInsets.only(left: 5, right: 5, bottom: 1, top: 4),
              padding: const EdgeInsets.only(left: 8.0),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(5.0)),
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.group),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text("$i"),
                ],
              ),
            ),
          )
      ],
    );
  }
}
