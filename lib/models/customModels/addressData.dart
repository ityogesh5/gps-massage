import 'package:flutter/material.dart';
import 'package:gps_massageapp/serviceUser/profileScreens/editUpdateUserprofile.dart';

class AddressDataClass {
  final String addressKey;
  final String address;
  final String latLngKey;
  final String lat;
  final String lng;
  final String addressTypeKey;
  final String addressType;

  const AddressDataClass({
    @required this.addressKey,
    @required this.address,
    @required this.latLngKey,
    @required this.lat,
    @required this.lng,
    @required this.addressTypeKey,
    @required this.addressType,
  });

  factory AddressDataClass.fromMap(Map<String, dynamic> map) {
    return AddressDataClass(
      addressKey: map['addressKey'] as String,
      address: map['address'] as String,
      lat: map['lat'] as String,
      lng: map['lng'] as String,
      addressType: map['addressType'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'addressKey': this.addressKey,
      'address': this.address,
      'lat': this.lat,
      'lng': this.lng,
      'addressType': this.addressType,
    };
  }
}

