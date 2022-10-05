import 'package:ebranch/Helpers/Config.dart';
import 'package:flutter/material.dart';
import '../Helpers/Config.dart';



class CustomInput extends StatelessWidget {
  String hint;
  TextEditingController controller;
  TextInputType textInputType;
  Function onChange;
  bool obscureText;
  Widget suffixIcon;
  Widget prefixIcon;
  bool readOnly;
  int maxLines;
  Function onTap;
  CustomInput({Key key,@required this.controller,this.readOnly = false,this.onTap,@required this.hint,@required this.textInputType,this.obscureText = false,this.prefixIcon,this.suffixIcon,this.onChange,this.maxLines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        // color: Colors.white,
      ),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        obscureText: obscureText,
        textAlign: TextAlign.right,
        onTap: onTap,
        onChanged: onChange,
        validator: (v){
          if(v.isEmpty) {
            return "هذا الحقل مطلوب";
          }
        },
        maxLines: maxLines??1,
        decoration: InputDecoration(
          hintText: hint,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: Config.responsiveHeight(context)*0.0153),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(color: Config.mainColor)
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(color: Config.buttonColor)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(color: Config.mainColor)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(color: Config.mainColor)
          ),

        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  String text;
  int fontSize;
  TextAlign textAlign;
  FontWeight fontWeight;
  Color color;
  TextDecoration textDecoration;
  CustomText({Key key,@required this.text,@required this.fontSize,this.textAlign = TextAlign.right,this.fontWeight = FontWeight.w400,this.color = Colors.black,this.textDecoration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,textAlign: textAlign,textDirection: TextDirection.rtl,style: TextStyle(color: color,fontSize: double.parse(fontSize.toString()),fontWeight: fontWeight,decoration: textDecoration),);
  }
}


class CustomButton extends StatelessWidget {
  Color color;
  int radius;
  String text;
  Color textColor;
  Function onPressed;
  double horizontalPadding,verticalPadding;
  CustomButton({Key key,@required this.text,@required this.onPressed,this.color,this.radius = 15,this.textColor = Colors.white,this.horizontalPadding = 50.0,this.verticalPadding = 5.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(vertical: verticalPadding,horizontal: horizontalPadding,),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(double.parse("$radius")),
      ),
      color: color??Config.buttonColor,
      child: CustomText(text: text, fontSize: 16,fontWeight: FontWeight.w600,color: textColor,),
    );
  }
}


AppBar CustomAppBar ({@required text,Widget leading,List<Widget> actions}){
  return AppBar(
    backgroundColor: Config.mainColor,
    title: CustomText(text: text, fontSize: 18,color: Colors.white,fontWeight: FontWeight.w600,),
    centerTitle: true,
    leading: leading,
    actions: actions,
  );
}

class ProductCard extends StatelessWidget {
  double rate;
  String name,price,image,catName;
  Function onTap;
  String offer;
  ProductCard({Key key,@required this.name,this.rate = 0.0,this.price = "0",this.image="",this.onTap,@ required this.catName, this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 7,
        child: Container(
        height: 170,width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),
          padding: EdgeInsets.only(left: 8,right: 8,top: 8),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(placeholder: AssetImage("images/homeBanner.png"),imageErrorBuilder: (context,builder,stackTrace)=>Image.asset("images/logo.png"), image: NetworkImage(image),height: 110,width: double.infinity,fit: BoxFit.fill,)),
              const SizedBox(height: 7,),
              offer==null?CustomText(text: "$price ر.س", fontSize: 11,textAlign: TextAlign.center,color: Config.buttonColor,):Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: "${int.parse(price)-(int.parse(price)*(int.parse(offer)/100))} ر.س", fontSize: 11,textAlign: TextAlign.center,color: Config.mainColor,),
                  const SizedBox(width: 10,),
                  CustomText(text: "$price ر.س", fontSize: 11,textAlign: TextAlign.center,color: Config.buttonColor,textDecoration: TextDecoration.lineThrough,)
                ],
              ),
              CustomText(text: name, fontSize: 16,textAlign: TextAlign.center,),
              CustomText(text: catName, fontSize: 11,textAlign: TextAlign.center,color: Config.buttonColor,)
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesCard extends StatelessWidget {
  String name,image,color;
  Function onTap;
  CategoriesCard({Key key,@required this.name,this.color = "888888",this.image,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        elevation: 7,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            FadeInImage(placeholder: AssetImage("images/logo.png"),imageErrorBuilder: (context,builder,stackTrace)=>Image.asset("images/logo.png"), image: NetworkImage(image),height: double.infinity,width: double.infinity,fit: BoxFit.fill,),
            Container(
              height: 35,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Color(int.parse("0xff$color"))
              ),
              child: CustomText(text: name, fontSize: 16,color: Colors.white,),
            )
          ],
        ),
      ),
    );
  }
}

class CartCard extends StatelessWidget {
  String image,text,desc,price;
  int qty;
  Function onIncrement,onDecrement,onTapDeleteItem;
  CartCard({Key key,@required this.text,this.image = "",this.price = "0.00",this.desc="",this.onDecrement,this.onTapDeleteItem,this.onIncrement,this.qty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          height: 150,
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 0.5,color: Config.mainColor)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 3,),
                  Container(width: Config.responsiveWidth(context)*0.6,child: CustomText(text: text, fontSize: 16,fontWeight: FontWeight.w600,)),
                  const SizedBox(height: 3,),
                  Container(width: Config.responsiveWidth(context)*0.6,child: CustomText(text: desc, fontSize: 14,)),
                  const SizedBox(height: 6,),
                  Row(
                    children: [
                      CustomText(text: "${double.parse(price)*qty} ريال", fontSize: 16,fontWeight: FontWeight.w600,),
                      const SizedBox(width: 15,),
                      InkWell(
                        onTap: onDecrement,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                          alignment: Alignment.center,
                          child: CustomText(fontSize: 20,text: "-",),
                        ),
                      ),
                      const SizedBox(width: 2,),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2,horizontal: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.3)
                        ),
                        child: CustomText(fontSize: 12,text: qty.toString(),),
                      ),
                      const SizedBox(width: 2,),
                      InkWell(
                        onTap: onIncrement,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                          alignment: Alignment.center,
                          child: CustomText(fontSize: 20,text: "+",),
                        ),
                      ),
                      const SizedBox(width: 2,),
                      // Container(
                      //   padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                      //   alignment: Alignment.center,
                      //   color: Config.buttonColor,
                      //   child: CustomText(fontSize: 12,text: "الكمية",color: Colors.white,),
                      // ),
                      // const SizedBox(width: 2,),
                      // Container(
                      //   padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                      //   alignment: Alignment.center,
                      //   decoration: BoxDecoration(
                      //       border: Border.all(width: 0.3,color: Colors.black)
                      //   ),
                      //   child: Image.asset("images/orders.png",height: 23,width: 23,),
                      // ),
                    ],
                  )
                ],
              ),
              const SizedBox(width: 5,),
              FadeInImage(placeholder: AssetImage("images/logo.png"),imageErrorBuilder: (context,builder,stackTrace)=>Image.asset("images/logo.png"), image: NetworkImage(image),fit: BoxFit.fill,width: 100,),

            ],
          ),
        ),
        InkWell(
          onTap: onTapDeleteItem,
            child: Icon(Icons.close)),
      ],
    );
  }
}

class OrderCard extends StatelessWidget {
  String image,storeName,phone,orderId,price,date,qty,orderStatus;
  Function onTap,cancelOrder;
  OrderCard({Key key,@required this.orderId,@required this.storeName,@required this.image,@required this.price,this.phone="",this.onTap,@required this.date,@required this.qty,this.orderStatus = "تم التوصيل",this.cancelOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Column(
          children: [
            Container(height: 170,),
            Card(elevation:7,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),child: DecoratedContainer(height: 40, width: Config.responsiveWidth(context)*0.4, child: CustomText(text: date, fontSize: 14,color: Config.mainColor,),radius: 20,)),
          ],
        ),
        InkWell(
          onTap: onTap,
          child: Card(
            elevation: 7,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
            child: Container(
              height: 180,
              color: Colors.white,
              child: Container(
                height: 170,
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 3,),
                        Row(
                          children: [
                            CustomText(text: "رقم الطلب", fontSize: 13,color: Config.buttonColor,),
                          ],
                        ),
                        const SizedBox(height: 3,),
                        Row(
                          children: [
                            CustomText(text: orderId, fontSize: 14,color: Config.mainColor,),
                          ],
                        ),
                        Row(
                          children: [
                            CustomText(text: "رقم الجوال", fontSize: 13,color: Config.buttonColor,),
                            SizedBox(width: 50,),
                            CustomText(text: "اسم المتجر", fontSize: 13,color: Config.buttonColor,),
                          ],
                        ),
                        const SizedBox(height: 3,),
                        Row(
                          children: [
                            CustomText(text: phone, fontSize: 14,color: Config.mainColor,),
                            SizedBox(width: 50,),
                            CustomText(text: storeName, fontSize: 14,color: Config.mainColor,),
                          ],
                        ),
                        const SizedBox(height: 6,),
                        Row(
                          children: [
                            CustomText(text: "الكمية", fontSize: 13,color: Config.buttonColor,),
                            SizedBox(width: 60,),
                            CustomText(text: "السعر", fontSize: 13,color: Config.buttonColor,),
                          ],
                        ),
                        const SizedBox(height: 3,),
                        Row(
                          children: [
                            CustomText(text: qty, fontSize: 14,color: Config.mainColor,),
                            SizedBox(width: 50,),
                            CustomText(text: "$price ر.س", fontSize: 14,color: Config.mainColor,),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 15,),
                    FadeInImage(placeholder: AssetImage("images/logo.png"),imageErrorBuilder: (context,builder,stackTrace)=>Image.asset("images/logo.png"), image: NetworkImage(image),height: 80,fit: BoxFit.fill,width: 100,),

                  ],
                ),
              ),
            ),
          ),
        ),
        if (orderStatus!="تم التوصيل") InkWell(
          onTap: cancelOrder,
            child: Icon(Icons.close)),
      ],
    );
  }
}

class DecoratedContainer extends StatelessWidget {
  double height,width,radius,borderWidth;
  Color borderColor;
  Alignment alignment;
  Widget child;

  DecoratedContainer({Key key,@required this.height,@required this.width,@required this.child,this.alignment = Alignment.center,this.borderColor,this.radius = 0,this.borderWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
        border: borderColor==null?null:Border.all(width: borderWidth,color: borderColor),
      ),
      alignment: alignment,
      child: child,
    );
  }
}
