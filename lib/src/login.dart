
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import 'login_controller.dart';
class login extends StatefulWidget {
  static String id = 'login';

  @override
  _loginState createState() => _loginState();

}

class _loginState extends State<login> {
  final controller = Get.put(LoginController());

  Widget build(BuildContext context){
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 100),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Bienvenido',
                      style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),


          Container(
            margin: EdgeInsets.only(top: 270),
            padding: EdgeInsets.symmetric(horizontal: 45),
            child: Obx((){
              if(controller.googleAccount.value == null){
                return _bottonRegisterGoogle();
              }else{
                return buildProfileView();
              }
            }),
          ),


        ],
      ),
    ));
  }


  Column buildProfileView() {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage:
          Image.network(controller.googleAccount.value?.photoUrl ?? '')
              .image,
          radius: 30,
        ),
        Text(controller.googleAccount.value?.displayName ?? '',
            style: Get.textTheme.headline5),
        Text(controller.googleAccount.value?.email ?? '',
            style: Get.textTheme.headline6),
        ActionChip(
          label: Text('Logout'),
          onPressed: () {return controller.logout();},
          avatar: Icon(Icons.logout),
        ),
      ],
    );
  }

  Widget _bottonRegister(){
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(Icons.login, color: Colors.white,),
                  ),

                  Text('Iniciar sesión',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.greenAccent,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return controller.login();
              }));
            },
          );
        }
    );
  }

  Widget _bottonRegisterGoogle(){
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: FaIcon(FontAwesomeIcons.google, color: Colors.red,),
                  ),

                  Text('Registrarse con Google',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.black, width: 1)
            ),
            color: Colors.white,
            onPressed: (){
              return controller.login();
            },
          );
        }
    );
  }
}