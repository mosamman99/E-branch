import 'dart:convert';

import 'package:ebranch/Components/Components.dart';
import 'package:ebranch/Helpers/Config.dart';
import 'package:ebranch/Helpers/HelperFunctions.dart';
import 'package:ebranch/Helpers/Navigation.dart';
import 'package:ebranch/Models/AuthModels/UserModel.dart';
import 'package:ebranch/Screens/AuthScreens/LoginScreen.dart';
import 'package:ebranch/Screens/AuthScreens/ProfileScreen.dart';
import 'package:ebranch/Screens/HomeScreens/Merchant/ChatsListScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Providers/HomeProvider.dart';
import 'ContactUsScreen.dart';
import 'HomeScreen.dart';
import 'NotificationScreen.dart';
import 'OrdersScreens/OrdersScreen.dart';
import 'TermsScreen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  String newMsg = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProfileData();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 250,
                color: Colors.white,
              ),
              Container(
                height: 250,
                color: Config.mainColor,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20,),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Image.asset("images/logo.png",fit: BoxFit.cover,width: 180,height: 180,),
                    ),
                    const SizedBox(height: 7,),
                    CustomText(text: "${nameController.text}", fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,),
                    CustomText(text: "${emailController.text}", fontSize: 11,color: Colors.white,),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: Config.responsiveHeight(context)-250,
            width: double.infinity,
            color: Config.mainColor,
            child: SingleChildScrollView(
              child: Container(
                color: Colors.black.withOpacity(0.1),
                child: Column(
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigation.removeUntilNavigator(context, HomeScreen());
                        },
                        title: CustomText(text:"الرئيسية", fontSize: 14,color: Colors.white,),
                        leading: Image.asset("images/home.png",height: 25,width: 25,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigator.pop(context);
                          Navigation.mainNavigator(context, ProfileScreen());
                        },
                        title: CustomText(text:"الشخصية", fontSize: 14,color: Colors.white,),
                        leading: Icon(Icons.person,color: Colors.white),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigator.pop(context);
                          Navigation.mainNavigator(context, OrdersScreen());
                        },
                        title: CustomText(text:"الطلبات", fontSize: 14,color: Colors.white,),
                        leading: Image.asset("images/orders.png",height: 25,width: 25,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigator.pop(context);
                          Navigation.mainNavigator(context, NotificationScreen());
                        },
                        title: CustomText(text:"الاشعارات", fontSize: 14,color: Colors.white,),
                        leading: Icon(Icons.notifications_sharp,color: Colors.white,),
                      ),
                    ),

                    Container(height: 0.5,width: double.infinity,color: Colors.white,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: () async {
                          await setSavedString("newMsg", "");
                          newMsg = "";
                          Navigator.pop(context);
                          Navigation.mainNavigator(context, ChatsListScreen());
                        },
                        title: CustomText(text:"المحادثات", fontSize: 14,color: Colors.white,),
                        leading: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Icon(Icons.chat,color: Colors.white,),
                            if(newMsg=="true")
                            CircleAvatar(
                              radius: 6,
                              backgroundColor: Colors.red,
                            )
                          ],
                        ),
                      ),
                    ),

                    Container(height: 0.5,width: double.infinity,color: Colors.white,),

                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigation.mainNavigator(context, ContactUsScreen());
                        },
                        title: CustomText(text:"اتصل بنا", fontSize: 14,color: Colors.white,),
                        leading: Icon(Icons.people,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),

                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigation.mainNavigator(context, TermsScreen(type: "terms"));
                        },
                        title: CustomText(text:"الشروط والأحكام", fontSize: 14,color: Colors.white,),
                        leading: Image.asset("images/terms.png",height: 25,width: 25,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),

                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigation.mainNavigator(context, TermsScreen(type: "privcy"));
                        },
                        title: CustomText(text:"سياسة الخصوصية", fontSize: 14,color: Colors.white,),
                        leading: Image.asset("images/terms.png",height: 25,width: 25,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),

                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigation.mainNavigator(context, TermsScreen(type: "about"));
                        },
                        title: CustomText(text:"معلومات عننا", fontSize: 14,color: Colors.white,),
                        leading: Image.asset("images/terms.png",height: 25,width: 25,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),


                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: () async {
                          SharedPreferences pre = await SharedPreferences.getInstance();
                          pre.clear();
                          Navigation.removeUntilNavigator(context, LoginScreen());
                        },
                        title: CustomText(text:"خروج", fontSize: 14,color: Colors.white,),
                        leading: Icon(Icons.logout,color: Colors.white,),
                      ),
                    ),

                    Container(height: 0.5,width: double.infinity,color: Colors.white,),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  fetchProfileData() async {
    Map<String,dynamic> mapResponse = jsonDecode(await getSavedString("userData", ""));
    Data model = Data.fromJson(mapResponse);
    print(model);
    nameController.text = "الاسم بالكامل : ${model.name.toString()}";
    emailController.text = "البريد الالكتروني : ${model.email.toString()}";

      await Provider.of<HomeProvider>(context,listen: false).getChatsList();
    for( var element in Provider.of<HomeProvider>(context,listen: false).allCatsModel.data){
      print(element.seenUser);
      if(element.seenUser == 0){
        await setSavedString("newMsg", "true");
        newMsg = "true";
        break ;
      }
    }

    setState(() {});
  }
}
