import 'package:ebranch/Components/Components.dart';
import 'package:ebranch/Helpers/Config.dart';
import 'package:ebranch/Helpers/HelperFunctions.dart';
import 'package:ebranch/Helpers/Navigation.dart';
import 'package:ebranch/Providers/HomeProvider.dart';
import 'package:ebranch/Screens/PickLocationMap/PickLocationMapScreen.dart';
import 'package:ebranch/States/HomeStates.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'DrawerScreen.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var addressController = TextEditingController();
  LatLng location;
  String type,address;
  var copounController = TextEditingController();

  var copoun ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "السلة",leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){Navigator.pop(context);})),
      endDrawer: DrawerScreen(),
      body: ChangeNotifierProvider(
        create: (BuildContext context)  => HomeProvider()..getCartData(),
        child: Consumer<HomeProvider>(
          builder: (context, homeProvider,_) {
            if(homeProvider.cartModel==null){
              return Center(child: CircularProgressIndicator());
            }else if(homeProvider.cartModel.data.isEmpty){
              return Center(child: CustomText(text: "لا يوجد منتجات", fontSize: 18));
            }
            if(HomeStates.marketOffersState==MarketOffersState.ERROR){
              return CustomText(text: "حدث خطأ", fontSize: 16);
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        return CartCard(text: homeProvider.cartModel.data[index].name,image: homeProvider.cartModel.data[index].photo,desc: homeProvider.cartModel.data[index].description,price: homeProvider.cartModel.data[index].offer==null?homeProvider.cartModel.data[index].price.toString():(double.parse(homeProvider.cartModel.data[index].price.toString())-(double.parse(homeProvider.cartModel.data[index].price.toString())*(double.parse(homeProvider.cartModel.data[index].offer.toString())/100))).toString(),
                          onIncrement: (){
                          if(homeProvider.quantities[index]!=homeProvider.cartModel.data[index].amount){
                            homeProvider.changeQuantity(index, homeProvider.quantities[index]+1);
                            homeProvider.addToTotal(homeProvider.cartModel.data[index].offer==null?homeProvider.cartModel.data[index].price:(double.parse(homeProvider.cartModel.data[index].price.toString())-(double.parse(homeProvider.cartModel.data[index].price.toString())*(double.parse(homeProvider.cartModel.data[index].offer.toString())/100))));
                            }
                          },
                          onDecrement: (){
                            if(homeProvider.quantities[index]!=1){
                              homeProvider.changeQuantity(index, homeProvider.quantities[index]-1);
                              homeProvider.removeFromTotal(homeProvider.cartModel.data[index].offer==null?homeProvider.cartModel.data[index].price:(double.parse(homeProvider.cartModel.data[index].price.toString())-(double.parse(homeProvider.cartModel.data[index].price.toString())*(double.parse(homeProvider.cartModel.data[index].offer.toString())/100))));
                            }
                          },qty: homeProvider.quantities[index],onTapDeleteItem: () async {
                             Map response = await homeProvider.removeCartItem(homeProvider.cartModel.data[index].id);
                             toast(response['msg'], context);
                             if(response['status']){
                               homeProvider.getCartData();
                             }
                          },
                        );
                      },
                      separatorBuilder: (context,index){
                        return SizedBox(height: 10,);
                      },
                      itemCount:  homeProvider.cartModel.data.length
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: CustomText(text: "الإجمالي : ${homeProvider.total} ريال", fontSize: 16,fontWeight: FontWeight.w600,),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 40,
                            width: 230,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: RadioListTile(value: 0, groupValue: homeProvider.shippingType, onChanged: (value){
                                homeProvider.changeShippingType(value);
                              },title: CustomText(text: "استلام من الفرع", fontSize: 16),activeColor: Config.mainColor,contentPadding: EdgeInsets.zero,),
                            ),
                          ),

                          Container(
                            height: 40,
                            width: 200,
                            margin: EdgeInsets.only(bottom: 10),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: RadioListTile(value: 1, groupValue: homeProvider.shippingType, onChanged: (value){
                                homeProvider.changeShippingType(value);
                              },title: CustomText(text: "توصيل للمنزل", fontSize: 16),
                                // subtitle: CustomText(text: "سعر الشحن ${homeProvider.cartModel.price} ر.س", fontSize: 11,color: Colors.grey,),
                                activeColor: Config.mainColor,contentPadding: EdgeInsets.zero,),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: InkWell(
                      onTap: () async {
                        copoun = await showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: CustomText(text: "اكتب كود الخصم", fontSize: 16),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  TextField(controller: copounController,textAlign: TextAlign.right,),
                                  const SizedBox(height: 20,),
                                  CustomButton(text: "حفظ", onPressed: () {
                                    Navigator.pop(context,copounController.text);
                                  },)
                                ],
                              ),
                            ),
                          );
                        });
                        if(copoun==null){
                          copoun="";
                        }
                        setState(() {});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomText(text: "استخدام كود خصم $copoun", fontSize: 16,color: Config.mainColor,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  if(homeProvider.shippingType==1)
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CustomInput(controller: addressController, hint: "حدد الموقع", readOnly: true ,textInputType: TextInputType.text,onTap: () async {
                      Position position = await determinePosition();
                      List result = await Navigation.mainNavigator(context, PickLocationMapScreen(lat: position.latitude,lang: position.longitude,));
                      address = result[0];
                      location = result[1];
                      if (type != "home") {
                        double dictance = Geolocator.distanceBetween(
                            double.parse(location.latitude.toString()),
                            double.parse(location.longitude.toString()),
                            double.parse(homeProvider.cartModel.lat),
                            double.parse(homeProvider.cartModel.lang));
                        print(dictance);
                        if (dictance >= 40 * 1000) {
                          type = "charger";
                        } else {
                          type = "driver";
                        }
                        print(homeProvider.cartModel.price);
                            setState(() {});
                      }
                      addressController.text = address;
                      print(location);
                    },suffixIcon: Icon(Icons.map),),
                  ),
                  if(type!="home" && location!=null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText(text: "سعر الشحن ${type=="driver"?homeProvider.cartModel.price:homeProvider.cartModel.price2} ر.س", fontSize: 14,color: Config.mainColor,),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  HomeStates.makeOrderState != MakeOrderState.LOADING?CustomButton(text: "ارسال الطلب", verticalPadding: 10,color: Config.mainColor,horizontalPadding: Config.responsiveWidth(context)*0.37,onPressed: () async {
                    print("homeProvider.shippingType  : ${homeProvider.shippingType}");
                    if(homeProvider.shippingType==0){
                      type = "home";
                    }else {
                      if (location == null) {
                        return toast("من فضلك حدد موقعك", context);
                      }
                      print('lat ${homeProvider.cartModel.lat}');
                      print('lat ${homeProvider.cartModel.lang}');

                    }
                    Map formData = {
                      "product_id": homeProvider.productIds.join(","),
                      "amount": homeProvider.quantities.join(","),
                      "price": homeProvider.total.toString(),
                      "type": type.toString(),
                      "address": address.toString(),
                      "lat": location==null?"":location.latitude.toString(),
                      "lang": location==null?"":location.longitude.toString(),
                      "coupon": copoun,
                    };
                    Map response = await homeProvider.makeOrder(formData);
                    toast(response['msg'], context);
                    if(response['status'])
                    homeProvider.getCartData();
                  },):Center(child: CircularProgressIndicator())
                ],
              ),
            );
          }
        )
      ),
    );
  }
}
