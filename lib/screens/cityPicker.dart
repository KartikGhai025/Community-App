import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/providers/cityProvider.dart';

class PickCity extends StatefulWidget {
  @override
  _PickCityState createState() => _PickCityState();
}

class _PickCityState extends State<PickCity> {
  String? countryValue;
  String? stateValue;
  String? cityValue;
  @override
  Widget build(BuildContext context) {
    return Consumer<CityProvider>(
      builder: ((context, cityProvidersModel, child) =>
          Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.location_city),
              onPressed: () {
                selectCity(cityProvidersModel, context);
              },
            ),
            appBar: AppBar(
              title: Text('Country State and City Picker'),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 600,
            ),
          )),
    );
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
}
