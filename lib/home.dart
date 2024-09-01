import 'dart:convert';

import 'package:apiclass/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UsersModel> dataList = [];
  // var dataList1;
  getUsers() async {
    String baseUrl = "https://jsonplaceholder.typicode.com/";
    String endPoint = "users";
    var url = Uri.parse(baseUrl + endPoint+"?ai=2");
    // var response = await http.post(url,body :jsonEncode({}));
    var response = await http.get(url );
    if (response.statusCode == 200) {
      var responsedata = jsonDecode(response.body);
      for (var datalis in responsedata) {
        setState(() {
          dataList.add(UsersModel.fromJson(datalis));
        });
      }
    } else {
      print("something went wrong");
    }
    print(dataList);
    print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ElevatedButton(
            onPressed: () {
              getUsers();
            },
            child: Text("Get USer Data"),
          ),
        ),
        body: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("${dataList[index].address == null ? '' :dataList[index].address!.geo!.lat}"),
              );
            }),
            );
  }
}
