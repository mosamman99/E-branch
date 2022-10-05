import 'dart:convert';

import 'package:ebranch/Components/Components.dart';
import 'package:ebranch/Helpers/HelperFunctions.dart';
import 'package:ebranch/Models/AuthModels/UserModel.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var idController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProfileData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "الملف الشخصي"),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(height: 15,),
            Image.asset("images/logo.png",width: 180,height: 180,),
            const SizedBox(height: 15,),
           CustomInput(controller: idController, hint: "", textInputType: TextInputType.text,readOnly: true,),
            const SizedBox(height: 15,),
           CustomInput(controller: nameController, hint: "", textInputType: TextInputType.text,readOnly: true,),
            const SizedBox(height: 15,),
           CustomInput(controller: emailController, hint: "", textInputType: TextInputType.emailAddress,readOnly: true,),
            const SizedBox(height: 15,),
           CustomInput(controller: phoneController, hint: "", textInputType: TextInputType.phone,readOnly: true,),
            const SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }

   fetchProfileData() async {
      Map<String,dynamic> mapResponse = jsonDecode(await getSavedString("userData", ""));
      Data model = Data.fromJson(mapResponse);
      print(model);
      idController.text = "الكود الخاص بك : ${model.id.toString()}";
      nameController.text = "${model.name.toString()}  : الاسم بالكامل";
      emailController.text = "${model.email.toString()}  : البريد الالكتروني";
      phoneController.text = "${model.phone.toString()}  :  رقم الهاتف";
   }
}
