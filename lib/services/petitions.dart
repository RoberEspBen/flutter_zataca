import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zataca/models/myRegister.dart';

class Petitions extends ChangeNotifier{

  Future<List<MyRegister>?> getHttp() async {
    try {
      final res = await Dio().get('https://jsonplaceholder.typicode.com/posts?_start=0&_limit=20');
      var ret = parseRegisters(res.data);
      return ret;
    } catch (e) {
      print(e);
    }
    //return null;
  }

  List<MyRegister>? parseRegisters(response) => 
    List<MyRegister>.from(response.map((x) => MyRegister.fromMap(x)));
}