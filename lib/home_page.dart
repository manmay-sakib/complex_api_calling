import 'dart:convert';
import 'package:complex_api_calling/models.dart';
import 'package:flutter/material.dart';
import 'models.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserDetails> userDetails = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                itemCount: userDetails.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    margin: EdgeInsets.only(bottom: 10),
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getText(
                          index,
                          'ID: ',
                          userDetails[index].id.toString(),
                        ),
                        getText(
                          index,
                          'Name: ',
                          userDetails[index].name.toString(),
                        ),
                        getText(
                          index,
                          'Email: ',
                          userDetails[index].email.toString(),
                        ),
                        getText(
                          index,
                          'Phone: ',
                          userDetails[index].phone.toString(),
                        ),
                        getText(
                          index,
                          'Website: ',
                          userDetails[index].website.toString(),
                        ),
                        getText(
                          index,
                          'Company Name: ',
                          userDetails[index].company.toString(),
                        ),
                        getText(
                          index,
                          'Address: ',
                          '${userDetails[index].address.suite.toString()}, '
                              '${userDetails[index].address.street.toString()}, ${userDetails[index].address.city.toString()}, - ${userDetails[index].address.zipcode.toString()}, ',
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Text getText(int index, String fieldName, String content) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: fieldName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
          TextSpan(
              text: content,
              style: TextStyle(
                fontSize: 16,
              )),
        ],
      ),
    );
  }

  Future<List<UserDetails>> getData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        userDetails.add(
          UserDetails.fromJson(index),
        );
      }
      return userDetails;
    } else {
      return userDetails;
    }
  }
}
//final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'),);
