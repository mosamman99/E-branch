import 'dart:convert';

import 'package:ebranch/Components/Components.dart';
import 'package:ebranch/Helpers/Config.dart';
import 'package:ebranch/Helpers/HelperFunctions.dart';
import 'package:ebranch/Helpers/Navigation.dart';
import 'package:ebranch/Models/AuthModels/UserModel.dart';
import 'package:ebranch/Providers/AuthProvider.dart';
import 'package:ebranch/Screens/HomeScreens/HomeScreen.dart';
import 'package:ebranch/Screens/HomeScreens/Merchant/MerchantScreen.dart';
import 'package:ebranch/States/AuthStates.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ForgotPassScreen.dart';
import 'SignUpScreen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();

  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "تسجيل الدخول"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40,),
                Image.asset("images/logo.png",width: 180,height: 180,),
                const SizedBox(height: 50,),
                CustomInput(controller: phoneNumberController, hint: "رقم الهاتف", textInputType: TextInputType.phone,suffixIcon: Icon(Icons.phone,color: Config.mainColor,),),
                const SizedBox(height: 15,),
                CustomInput(controller: passwordController, hint: "كلمة المرور", textInputType: TextInputType.text,obscureText: true,suffixIcon: Icon(Icons.lock,color: Config.mainColor,),),
                const SizedBox(height: 30,),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigation.mainNavigator(context, SignUpScreen());
                      },
                        child: CustomText(text: "تسجيل", fontSize: 16,fontWeight: FontWeight.w600,)),
                    Spacer(),
                    InkWell(
                      onTap: (){
                        Navigation.mainNavigator(context, ForgotPassScreen());
                      },
                        child: CustomText(text: "نسيت كلمة المرور ؟", fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 50,),
                Consumer<AuthProvider>(
                  builder: (context, authProvider,child) {
                    return States.registerState==RegisterState.LOADING?Center(child: CircularProgressIndicator()):CustomButton(text: "دخول",onPressed: () async {
                      String fcm = await getToken();

                      Map<String,dynamic> formData ={
                        "phone": phoneNumberController.text,
                        "password": passwordController.text,
                        "token": fcm,
                        "type": "user"
                      };
                      UserModel userModel = await authProvider.login(formData);
                      if(userModel.status){
                        setSavedString("jwt", userModel.data.apiToken);
                        setSavedString(
                            "userData", jsonEncode(userModel.data));
                        toast("تم التسجيل بنجاح", context);
                        Navigation.removeUntilNavigator(context, HomeScreen());
                      }else{
                        toast(userModel.msg, context);
                      }
                    },);
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
