

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Candy{
  String name;
  Candy({required this.name});
  //from Map 
  Candy.fromMap(Map<String, dynamic> map)
      : assert(map['name'] != null),
        name = map['name'];
  //to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
  //toString
  @override
  String toString() => "Candy<$name>";
}

class CandiesOnlineCubit extends Cubit<List<Candy>>{
  //nguon du lieu la collection candies o firebase
  // stream subscription 
  late StreamSubscription? _candiesSubscription;
  CandiesOnlineCubit() : super([]){
    _candiesSubscription = FirebaseFirestore.instance
        .collection('candies')
        .snapshots()
        .listen((event) {
      //event la 1 list document
      //convert document to candy
      List<Candy> candies = event.docs.map((e) => Candy.fromMap(e.data())).toList();
      emit(candies);
    });
    
  } 
}