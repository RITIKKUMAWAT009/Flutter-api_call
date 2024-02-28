import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:news/constants/constant.dart';

import '../model/article.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Article> articles = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body:Container(alignment: Alignment.topLeft,
        child: Column(
          children: [Expanded(
            child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      var article=articles[index];
                      return Column(
                        children:[
                          Padding(padding: EdgeInsets.all(10),child: Container(child: Column(
                            children: [
                              article.title.isNotEmpty?Align(alignment: Alignment.topLeft,child: Text(article.title,style:const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)):Text("no titile"),
                              SizedBox(height: 20,),
                              article.urlToImg.isNotEmpty? Image.network(article.urlToImg):Text("url not present"),
                              SizedBox(height: 40,),
                              Text(article.description,softWrap: true,style: TextStyle(fontSize:16),),
                              SizedBox(height: 40,)
                            ],
                          ),

                          ),)

                        ]
                      );
                    },
                  ),
          ),
       Flex(
         direction: Axis.horizontal,
         children:[ Expanded(
           child: BottomAppBar(height: 70,shadowColor: Colors.blue.shade300,surfaceTintColor: Colors.blue,elevation: 10,child:ElevatedButton(onPressed: (){apiCall();}, child: Text("get news",style: TextStyle(color: Colors.black),),style: ButtonStyle(backgroundColor:MaterialStateColor.resolveWith((states) => Colors.blue.shade200)),
           ),),
         ),
      ] ),

          ])
        ),
      );


  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("Daily News"),
      backgroundColor: Colors.blue,
      elevation: 5,
      centerTitle: true,
    );
  }
void apiCall() async {
    var response = await http.get(Uri.parse(BASE_URL_NEWS+END_POINT_NEWSDATA));
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jsonData = json.decode(response.body);

      if (jsonData['articles'] != null) {
        for (var articleData in jsonData['articles']) {
          articles.add(Article.fromJson(articleData));

        }
        setState(() {
          articles;
        });


      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}

