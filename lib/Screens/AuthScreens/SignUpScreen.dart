import 'dart:convert';

import 'package:ebranch/Components/Components.dart';
import 'package:ebranch/Helpers/Config.dart';
import 'package:ebranch/Helpers/HelperFunctions.dart';
import 'package:ebranch/Helpers/Navigation.dart';
import 'package:ebranch/Models/AuthModels/CitiesModel.dart' as cities;
import 'package:ebranch/Models/AuthModels/CountriesModel.dart' as countries;
import 'package:ebranch/Models/AuthModels/UserModel.dart';
import 'package:ebranch/Providers/AuthProvider.dart';
import 'package:ebranch/Screens/HomeScreens/HomeScreen.dart';
import 'package:ebranch/States/AuthStates.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmationController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var countryController = TextEditingController();

  GlobalKey _formKey = GlobalKey<FormState>();

  var addressController = TextEditingController();
  @override
  initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      // countriesModel = await Provider.of<AuthProvider>(context,listen: false).getCountries();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "تسجيل الدخول"),
      body: Consumer<AuthProvider>(
        builder: (context, AuthProvider authProvider,child) {



          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40,),
                    Image.asset("images/logo.png",width: 180,height: 180,),
                    const SizedBox(height: 50,),
                    CustomInput(controller: nameController, hint: "الاسم بالكامل", textInputType: TextInputType.text,suffixIcon: Icon(Icons.person,color: Config.mainColor,),),
                    const SizedBox(height: 15,),
                    CustomInput(controller: passwordController, hint: "كلمة المرور", textInputType: TextInputType.text,obscureText: true,suffixIcon: Icon(Icons.lock,color: Config.mainColor,),),
                    const SizedBox(height: 15,),
                    CustomInput(controller: passwordConfirmationController, hint: "تأكيد كلمة المرور", textInputType: TextInputType.text,obscureText: true,suffixIcon: Icon(Icons.lock,color: Config.mainColor,),),
                    const SizedBox(height: 15,),
                    CustomInput(controller: emailController, hint: "البريد الإلكتروني", textInputType: TextInputType.emailAddress,suffixIcon: Icon(Icons.email,color: Config.mainColor,),),
                    const SizedBox(height: 15,),
                    CustomInput(controller: phoneNumberController, hint: "رقم الهاتف", textInputType: TextInputType.phone,suffixIcon: Icon(Icons.phone,color: Config.mainColor,),),
                    const SizedBox(height: 15,),
                    CustomInput(controller: addressController, hint: "العنوان", textInputType: TextInputType.text,suffixIcon: Icon(Icons.home,color: Config.mainColor,),),
                    // Container(
                    //   width: double.infinity,
                    //   height: 55,
                    //   padding: EdgeInsets.symmetric(horizontal: 10),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(13),
                    //     border: Border.all(color: Config.mainColor)
                    //   ),
                    //   alignment: Alignment.centerRight,
                    //   child: Directionality(
                    //     textDirection: TextDirection.rtl,
                    //     child: DropdownButton<countries.Data>(
                    //       value: countriesValue,
                    //       underline: SizedBox(),
                    //       hint: CustomText(text: "اختر الدولة", fontSize: 14),
                    //       onChanged: (countries.Data newValue) async {
                    //         setState(()  {
                    //           countriesValue = newValue;
                    //         });
                    //         citiesValue = null;
                    //         citiesModel = await authProvider.getCities(newValue.id);
                    //       },
                    //       items: countriesModel.data
                    //           .map((countries.Data value) {
                    //         return DropdownMenuItem<countries.Data>(
                    //           value: value,
                    //           child: Container(
                    //             width: Config.responsiveWidth(context)*0.79,
                    //             child: Text(value.name),
                    //           ),
                    //         );
                    //       }).toList(),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 15,),
                    // Consumer<AuthProvider>(
                    //   builder: (context, citiesProvider,child) {
                    //     if(States.citiesState == CitiesState.LOADING){
                    //       return Center(child: CircularProgressIndicator());
                    //     }
                    //
                    //     if(States.citiesState == CitiesState.ERROR){
                    //       return Center(child: CustomText(text: "حدث خطأ", fontSize: 16,fontWeight: FontWeight.w600,));
                    //     }
                    //
                    //     return Container(
                    //       width: double.infinity,
                    //       height: 55,
                    //       padding: EdgeInsets.symmetric(horizontal: 10),
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(13),
                    //           border: Border.all(color: Config.mainColor)
                    //       ),
                    //       alignment: Alignment.centerRight,
                    //       child: Directionality(
                    //         textDirection: TextDirection.rtl,
                    //         child: DropdownButton<cities.Data>(
                    //           value: citiesValue,
                    //           icon: citiesModel==null?SizedBox():Icon(Icons.arrow_drop_down),
                    //           underline: SizedBox(),
                    //           hint: CustomText(text: "اختر المدينة", fontSize: 14),
                    //           onChanged: (cities.Data newValue) {
                    //             setState(() {
                    //               citiesValue = newValue;
                    //             });
                    //             print(citiesValue);
                    //           },
                    //           items: citiesModel==null?[]:citiesModel.data
                    //               .map((cities.Data value) {
                    //             return DropdownMenuItem<cities.Data>(
                    //               value: value,
                    //               child: Container(
                    //                 width: Config.responsiveWidth(context)*0.79,
                    //                 child: Text(value.name,textAlign: TextAlign.right,),
                    //               ),
                    //             );
                    //           }).toList(),
                    //         ),
                    //       ),
                    //     );
                    //   }
                    // ),
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        CustomText(text: "تسجيل", fontSize: 16,fontWeight: FontWeight.w600,),
                        Spacer(),
                        CustomText(text: "نسيت كلمة المرور ؟", fontSize: 14),
                      ],
                    ),
                    const SizedBox(height: 50,),
                    States.registerState==RegisterState.LOADING?Center(child: CircularProgressIndicator()):CustomButton(text: "دخول",onPressed: () async {
                      if(passwordController.text!=passwordConfirmationController.text){
                        toast("كلمة المرور غير متطابقة", context);
                        return;
                      }
                      String fcm = await getToken();
                      Map formData = {
                        "name": nameController.text,
                        "email": emailController.text,
                        "phone": phoneNumberController.text,
                        "password": passwordController.text,
                        "address": addressController.text,
                        "type": "user",
                        "token": fcm
                      };
                      UserModel userModel = await authProvider.register(formData);
                      if(userModel.status){
                        setSavedString("jwt", userModel.data.apiToken);
                        setSavedString(
                            "userData", jsonEncode(userModel.data));
                        toast("تم التسجيل بنجاح", context);
                        Navigation.removeUntilNavigator(context, HomeScreen());
                      }else{
                        toast(userModel.msg, context);
                      }
                    },)
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}