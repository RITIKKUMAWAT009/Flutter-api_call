import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../constants/constant.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var usernameController=TextEditingController();
  var passwordController=TextEditingController();

  List<dynamic> articles=[];
  Color color=Colors.black26;
  int counter=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Api call"),

      ),
      body:  Container(
        child:
              Flex(direction: Axis.vertical,
                 children: [
                   SizedBox(height: 40),
                 buildTextField("username","Enter username",false,usernameController,Icons.person,color),
                   SizedBox(height: 40),
      buildTextField("password","Enter password",true,passwordController,Icons.password,color),
                   SizedBox(height: 40),
                   ElevatedButton(onPressed: (){
                     login();
                   }, child: Text("Login"),style: ButtonStyle(
                       backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue)
                   ),
                   )
              ],
              ),
      ),
    );
  }

Future<void> login()async {  // "http://192.168.60.36:8081/login"

  try{
    if(usernameController.text.isNotEmpty&& passwordController.text.isNotEmpty){
  setState(() {
    color=Colors.black26;
  });
      var response = await http.post(
        Uri.parse(BASE_URL+END_POINT),
        headers:{
          'Content-Type': 'application/json',
      'Access-Control-Allow-Methods':'GET, POST, OPTIONS',
       'Access-Control-Allow-Headers':'DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range' ,
       'Access-Control-Expose-Headers':'Content-Length,Content-Range' ,
        },
          body:json.encode( {
          "userName":usernameController.text,
          "password":passwordController.text,
        })
      );
      print(response.statusCode);
      print(response.body.toString());
    } else{
      setState(() {
        color=Colors.red;
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
    }
    }catch(error){
    print("Error: $error");
  }
  }

  TextField buildTextField(String lableText,String hintText,bool secureText,var controllerInput,IconData sufIcon,Color color) {
    return TextField(
      controller: controllerInput,
      decoration: InputDecoration(suffixIconColor:color,
        labelStyle: TextStyle(color: Colors.black26),
        suffixIcon: IconButton(icon:Container(child: Icon(sufIcon),),onPressed: ()=>{
        },),
        hintText:hintText,
        hintStyle: TextStyle(color:color),
        border:OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(10))
        ),
      ),
      obscureText:secureText,
    );
  }
  }



