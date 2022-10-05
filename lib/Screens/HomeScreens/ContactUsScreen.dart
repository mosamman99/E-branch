import 'package:ebranch/Components/Components.dart';
import 'package:ebranch/Helpers/Config.dart';
import 'package:ebranch/Helpers/HelperFunctions.dart';
import 'package:ebranch/Providers/HomeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();
  var msgController = TextEditingController();

  var _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "تواصل معنا"),
      body: Form(
        key: _formState,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomInput(controller: nameController, hint: "الاسم بالكامل", textInputType: TextInputType.text,suffixIcon: Icon(Icons.person,color: Config.mainColor,),),
                const SizedBox(height: 15,),
                CustomInput(controller: emailController, hint: "البريد الإلكتروني", textInputType: TextInputType.emailAddress,suffixIcon: Icon(Icons.email,color: Config.mainColor,),),
                const SizedBox(height: 15,),
                CustomInput(controller: phoneNumberController, hint: "رقم الهاتف", textInputType: TextInputType.phone,suffixIcon: Icon(Icons.phone,color: Config.mainColor,),),
                const SizedBox(height: 30,),
                CustomInput(controller: msgController, hint: "الرسالة", textInputType: TextInputType.text,suffixIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 85),
                  child: Icon(Icons.chat,color: Config.mainColor,),
                ),maxLines: 4,),
                const SizedBox(height: 50,),
                CustomButton(text: "ارسال",onPressed: () async {
                  if(_formState.currentState.validate()) {
                    Map response= await context.read<HomeProvider>().contactUs({"name": nameController.text,"email": emailController.text,"phone": phoneNumberController.text,"messages":msgController.text});
                    toast(response['msg'], context);
                   if(response['status']){
                     nameController.text="";
                     emailController.text="";
                     phoneNumberController.text="";
                     msgController.text="";
                   }
                  }
                },)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
