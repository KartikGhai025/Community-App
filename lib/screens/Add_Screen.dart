import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tango/providers/cityProvider.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({Key? key}) : super(key: key);

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Consumer<CityProvider>(
          builder: ((context, cp, child) =>
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                    Colors.redAccent, Colors.pinkAccent,
                  ])
                ),
                padding: const EdgeInsets.all(10.0),
                margin: EdgeInsets.all(20),
                //height: MediaQuery.of(context).size.height * 50,
                // width: MediaQuery.of(context).size.width * 50,

             //   color: Colors.pinkAccent,
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            //   BackButton(),
                          ],
                        ),
                        SizedBox(
                          height: 200,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            onChanged: (value) {
                              cp.grpName = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Enter Dashing Group Name.',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                              ),
                            ),
                          ),
                        ),
                        SelectState(
                          dropdownColor: Colors.pinkAccent,
                          style: TextStyle(color: Colors.white),
                          //   dropdownColor: Colors.lightBlue,
                          onCountryChanged: (value) {
                            setState(() {
                              //countryValue = value;
                              cp.selectCountry(value);
                            });
                          },
                          onStateChanged: (value) {
                            setState(() {
                              //stateValue = value;
                              cp.selectState(value);
                            });
                          },
                          onCityChanged: (value) {
                            setState(() {
                              //cityValue = value;
                              cp.selectCity(value);
                              cp.isSelected = true;
                            });
                          },
                        ),
                        // TextButton(
                        //     onPressed: () async {
                        //       late List<dynamic> updatedGrps;
                        //       await FirebaseFirestore.instance
                        //           .collection('messages')
                        //           .doc(cp.grpName)
                        //           .get()
                        //           .then((snapshot) {
                        //         updatedGrps = snapshot.data()!['group'];
                        //         print(updatedGrps);
                        //        // updatedGrps.add(cp.grpName);
                        //       });
                        //
                        //     },
                        //     child: Text("Check")),
                        MaterialButton(
                          child: Text("create group"),
                          color: Colors.white,
                          shape:  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80.0)
                                  ),
                          onPressed: cp.isSelected
                              ? () async {
                                  bool isNull = false;
                                  late List<dynamic> updatedGrps;
                                  await FirebaseFirestore.instance
                                      .collection('messages')
                                      .doc(cp.city)
                                      .get()
                                      .then((snapshot) {

                                    updatedGrps = snapshot.data()!['group'];
                                    updatedGrps.add(cp.grpName);
                                  });
                                  print(updatedGrps);
                                  //
                                  FirebaseFirestore.instance
                                      .collection('messages')
                                      .doc(cp.city)
                                      .update({"group": updatedGrps});

                                  cp.isSelected = false;
                                  Navigator.pushReplacementNamed(
                                      context, 'landingscreen');
                                }
                              : null,
                        )
                      ],
                    ),
                  ],
                ),
              )),
        ));
  }
}
