import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class CityProvider extends ChangeNotifier{
String country="India";
String state ="Mp";
String city= "Guna";
String grpName= "Avengers";

void selectGroup(String val){
  this.grpName= val;

  notifyListeners();

}

void selectCity(String newcity){
  this.city= newcity;

  notifyListeners();

}
void selectCountry(String val){
  this.country= val;

  notifyListeners();

}
void selectState(String val){
  this.state= val;

  notifyListeners();

}
  //CityProvider({required super.create});

}