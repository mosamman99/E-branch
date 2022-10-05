import 'package:ebranch/Components/Components.dart';
import 'package:ebranch/Helpers/Config.dart';
import 'package:ebranch/Helpers/HelperFunctions.dart';
import 'package:ebranch/Helpers/Navigation.dart';
import 'package:ebranch/Models/HomeModels/OrderModel.dart';
import 'package:ebranch/Providers/HomeProvider.dart';
import 'package:ebranch/Screens/HomeScreens/HomeScreen.dart';
import 'package:ebranch/States/HomeStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../ProductDetailsScreen.dart';

class OrderDetailsScreen extends StatefulWidget {
  List<Products> products;
  String orderStatus,orderId,photo;
  String orderType;
  var rate,deliveryPrice,finalPrice;
  OrderDetailsScreen({Key key,@required this.products,this.orderStatus,this.orderId,@required this.rate,@required this.deliveryPrice,@required this.finalPrice, this.photo, @required this.orderType}) : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  double updatedRate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.rate);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "تفاصيل الطلب"),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 75,),
              if(widget.products.isEmpty)
              CustomText(text: "لا يوجد منتجات لعرضها", fontSize: 16)
              else
              Directionality(
                textDirection: TextDirection.rtl,
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 10,
                  childAspectRatio: (Config.responsiveHeight(context)*0.15 / 160),
                  children: List.generate(widget.products.length, (index) {
                    return ProductCard(name: widget.products[index].name,image: widget.products[index].photo,price: widget.products[index].price.toString(),offer: widget.products[index].offer==0?null:widget.products[index].offer.toString(),onTap: (){
                      Navigation.mainNavigator(context, ProductDetailsScreen(product: widget.products[index],offer: widget.products[index].offer==0?null:true,fromOrder: true));
                    }, catName: widget.products[index].cat.name,);
                  }),
                ),
              ),

              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(widget.deliveryPrice.toString()!="0")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(text: widget.deliveryPrice.toString(), fontSize: 16),
                      CustomText(text: "قيمة التوصيل : ".toString(), fontSize: 16),
                    ],
                  ),
                  const SizedBox(width: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(text: "${int.parse(widget.finalPrice.toString())}", fontSize: 16),
                      CustomText(text: "سعر الطلبات : ", fontSize: 16),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 15,),
              widget.photo!=null?Column(
                children: [
                  CustomText(text: "الفاتورة", fontSize: 16),
                  const SizedBox(height: 15,),
                  FadeInImage(placeholder: AssetImage("images/homeBanner.png"),imageErrorBuilder: (context,builder,stackTrace)=>Image.asset("images/logo.png"), image: NetworkImage(widget.photo),height: 180,width:Config.responsiveWidth(context)*0.9,fit: BoxFit.fill,)

                ],
              ):const SizedBox(),
              const SizedBox(height: 75,),
              if(widget.orderType != "home")
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomText(text: "بانتظار موافقة المتجر", fontSize: 16,color: widget.orderStatus=="جديد" ||  widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                      CustomText(text: "بانتظار موافقة المتجر علي طلبك رقم ${widget.orderId}", fontSize: 14,color: widget.orderStatus=="جديد" ||  widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                      const SizedBox(height: 65,),
                      CustomText(text: "المتجر قبل طلبك", fontSize: 16,color: widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                      CustomText(text: "المتجر قبل طلبك وبانتظار موافقة السائق", fontSize: 14,color: widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                      const SizedBox(height: 65,),
                      CustomText(text: "السائق قبل طلبك", fontSize: 16,color: widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                      Container(width: Config.responsiveWidth(context)*0.65,child: CustomText(text: "السائق قبل طلبك رقم ${widget.orderId} وجاري استلام الطلب من المتجر", fontSize: 14,color: widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,)),
                      const SizedBox(height: 55,),
                      CustomText(text: "تم تسليم الطلب بنجاح", fontSize: 16,color: widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "مخالصة"?Config.mainColor:Config.buttonColor,),
                      CustomText(text: "نحن سعداء لخدمتك", fontSize: 14,color:widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "مخالصة"?Config.mainColor:Config.buttonColor,),
                      const SizedBox(height: 65,),

                    ],
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    children: [
                      DecoratedContainer(height: 60, width: 60, radius: 30 , borderColor: widget.orderStatus=="جديد" ||  widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor, borderWidth: 0.5 , child: Icon(Icons.check,size: 30,color: widget.orderStatus=="جديد" ||  widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,)),
                      CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="جديد" ||  widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                      CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="جديد" ||  widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                      CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="جديد" ||  widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                      CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="جديد" ||  widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                      CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="جديد" ||  widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),

                      DecoratedContainer(height: 60, width: 60, radius: 30 , borderColor: widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor, borderWidth: 0.5 , child: Icon(Icons.assignment,size: 30,color: widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,)),
                      CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                      CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                      CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                      CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                      CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),

                      DecoratedContainer(height: 60, width: 60, radius: 30 , borderColor: widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor, borderWidth: 0.5 , child: Icon(Icons.car_repair,size: 30,color: widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,)),
                      CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                      CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                      CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                      CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                      CustomText(text: "|", fontSize: 2,color: widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                      DecoratedContainer(height: 60, width: 60, radius: 30 , borderColor: widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "مخالصة" ?Config.mainColor:Config.buttonColor, borderWidth: 0.5 , child: Icon(Icons.favorite_border,size: 30,color: widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "مخالصة" ?Config.mainColor:Config.buttonColor,)),

                    ],
                  ),
                ],
              )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(text: "بانتظار تجهيز طلبك المتجر", fontSize: 16,color: widget.orderStatus=="جديد" ||  widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                        CustomText(text: "بانتظار تجهيز طلبك رقم ${widget.orderId}", fontSize: 14,color: widget.orderStatus=="جديد" ||  widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                        const SizedBox(height: 65,),
                        CustomText(text: "طلبك جاهز للاستلام من المتجر", fontSize: 16,color: widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                        CustomText(text: "المتجر جهز طلبك وبانتظار الاستلام", fontSize: 14,color: widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                        const SizedBox(height: 65,),
                        CustomText(text: "لقد استلمت طلبك", fontSize: 16,color: widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "مخالصة"?Config.mainColor:Config.buttonColor,),
                        CustomText(text: "لقد استلمت طلبك رقم ${widget.orderId}", fontSize: 14,color:widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "مخالصة"?Config.mainColor:Config.buttonColor,),
                        const SizedBox(height: 65,),

                      ],
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      children: [
                        DecoratedContainer(height: 60, width: 60, radius: 30 , borderColor: widget.orderStatus=="جديد" ||  widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor, borderWidth: 0.5 , child: Icon(Icons.check,size: 30,color: widget.orderStatus=="جديد" ||  widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,)),
                        CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="جديد" ||  widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                        CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="جديد" ||  widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                        CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="جديد" ||  widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                        CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="جديد" ||  widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                        CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="جديد" ||  widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),

                        DecoratedContainer(height: 60, width: 60, radius: 30 , borderColor: widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor, borderWidth: 0.5 , child: Icon(Icons.assignment,size: 30,color: widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,)),
                        CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                        CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                        CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                        CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),
                        CustomText(text: "|", fontSize: 7,color: widget.orderStatus=="تم الموافقة من المتجر" || widget.orderStatus=="تم الموافقة من السائق" || widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "الطلب ملغي" || widget.orderStatus == "الطلب متعثر" || widget.orderStatus == "الطلب مرتجع" || widget.orderStatus == "مخالصة" || widget.orderStatus == "تم الاستلام من المتجر"?Config.mainColor:Config.buttonColor,),

                       DecoratedContainer(height: 60, width: 60, radius: 30 , borderColor: widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "مخالصة" ?Config.mainColor:Config.buttonColor, borderWidth: 0.5 , child: Icon(Icons.favorite_border,size: 30,color: widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "مخالصة" ?Config.mainColor:Config.buttonColor,)),

                      ],
                    ),
                  ],
                ),
              const SizedBox(height: 10,),
              widget.orderStatus=="تم التوصيل" || widget.orderStatus == "الطلب منتهي" || widget.orderStatus == "مخالصة" ?widget.rate.toString()=="0" || widget.rate==null?Column(
                children: [
                  CustomText(text: "تقييم السائق", fontSize: 16),
                  const SizedBox(height: 10,),
                  RatingBar.builder(
                    initialRating: 0.0,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ), onRatingUpdate: (double value) {
                      updatedRate = value;
                  },
                  ),
                  const SizedBox(height: 10,),
                  Consumer<HomeProvider>(
                    builder: (context, provider,child) {
                      return HomeStates.makeOrderState != MakeOrderState.LOADING?CustomButton(text: "ارسال", onPressed: () async {
                        if(updatedRate==null){
                          toast("من فضلك ضع تقييمك", context);
                          return ;
                        }
                        Map response = await provider.rateOrder({"orderid": widget.orderId,"rate": updatedRate.toString()});
                        toast(response['msg'], context);
                        if(response['status']){
                          Navigation.removeUntilNavigator(context, HomeScreen());
                        }
                        },color: Config.mainColor,horizontalPadding: Config.responsiveWidth(context)*0.22,):Center(child: CircularProgressIndicator());
                    }
                  )
                ],
              ):SizedBox():SizedBox(),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
