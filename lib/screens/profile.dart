 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cityProvider.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CityProvider>(
      builder: (context,value,child) {
        return Container(
          child: Column(children: [
            Text(value.country)
            ,
            Text(value.state),
            Text(value.city)
          ],),
        );
      }
    );
  }
}
