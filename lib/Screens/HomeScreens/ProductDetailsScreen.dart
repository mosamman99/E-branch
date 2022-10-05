import 'package:ebranch/Helpers/HelperFunctions.dart';
import 'package:ebranch/Models/HomeModels/ProductsModel.dart';
import 'package:ebranch/Providers/HomeProvider.dart';
import 'package:ebranch/States/HomeStates.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Components/Components.dart';
import '../../Components/Components.dart';
import '../../Components/Components.dart';
import '../../Components/Components.dart';
import '../../Components/Components.dart';
import '../../Components/Components.dart';
import '../../Helpers/Config.dart';
import '../../Helpers/Navigation.dart';
import 'CartScreen.dart';
class ProductDetailsScreen extends StatefulWidget {
  var product;
  bool offer;
  bool fromOrder;
  ProductDetailsScreen({Key key,this.product, this.offer, this.fromOrder}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  var qty=1;
  String size = "";
  String color = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: widget.product.name,actions: [
        if(widget.fromOrder==null)
        IconButton(icon: Icon(Icons.add_shopping_cart), onPressed: (){
          Navigation.mainNavigator(context, CartScreen());
        })
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.product.photo,width: double.infinity,height: 220,),
            const SizedBox(height: 15,),
            CustomText(text: widget.product.name, fontSize: 16,fontWeight: FontWeight.w600,),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if(widget.offer==null)
                          CustomText(text: "${widget.product.price.toString()} SAR", fontSize: 14)
                          else
                          Row(
                            children: [
                              CustomText(text: "${double.parse(widget.product.price.toString())-(double.parse(widget.product.price.toString())*(double.parse(widget.product.offer.toString())/100))} SAR", fontSize: 14,color: Config.mainColor,),
                              const SizedBox(width: 30,),
                              CustomText(text: "${widget.product.price.toString()} SAR", fontSize: 14,textDecoration: TextDecoration.lineThrough,)
                            ],
                          ),
                          const SizedBox(width: 7,),
                          CustomText(text:"السعر : ", fontSize: 14,),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: Config.mainColor,
                      alignment: Alignment.center,
                      child: CustomText(text: "الوصف", fontSize: 18,color: Colors.white,),
                    ),
                    const SizedBox(height: 5,),
                    CustomText(text: widget.product.description, fontSize: 14),
                    const SizedBox(height: 35,),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(text: "اختر الحجم", fontSize: 16),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: List.generate(widget.product.sizes.split(",").length, (index) {
                              return InkWell(
                                onTap: (){
                                  size = widget.product.sizes.split(",")[index];
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 7,horizontal: 14),
                                  margin: EdgeInsets.symmetric(horizontal: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: size== widget.product.sizes.split(",")[index]?1.0:0.2,color: size== widget.product.sizes.split(",")[index]?Config.mainColor:Colors.black),
                                    color: Config.mainColor.withOpacity(0.1),
                                  ),
                                  alignment: Alignment.center,
                                  child: CustomText(text: widget.product.sizes.split(",")[index], fontSize: 14),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(text: "اختر اللون", fontSize: 16),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: List.generate(widget.product.sizes.split(",").length, (index) {
                              return InkWell(
                                onTap: (){
                                  color = widget.product.colors.split(",")[index];
                                  setState(() {});
                                },
                                child: Container(
                                  height: 45,width: 45,
                                  margin: EdgeInsets.symmetric(horizontal: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: color == widget.product.colors.split(",")[index]?2.0:0.2,color: color == widget.product.colors.split(",")[index]?Config.mainColor:Colors.black),
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color(int.parse("0xff${widget.product.colors.split(",")[index].substring(1)}")),
                                  ),
                                  alignment: Alignment.center,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),


            // Container(
            //   height: 55,
            //   width: double.infinity,
            //   color: Config.mainColor,
            //   alignment: Alignment.center,
            //   child: CustomText(text: "الكمية", fontSize: 14,color: Color(0xffffffff),),
            // ),
            // const SizedBox(height: 5,),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 45),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       InkWell(
            //         onTap: (){
            //           if(qty!=1){
            //             qty--;
            //           }
            //           setState(() {});
            //         },
            //         child: Stack(
            //           alignment: Alignment.center,
            //           children: [
            //             Container(
            //               height: 30,width: 30,
            //                 decoration: BoxDecoration(border: Border.all(width:1),borderRadius: BorderRadius.circular(15)),
            //             ),
            //             Text("-",style: TextStyle(fontSize: 30),)
            //           ],
            //         ),
            //       ),
            //       CustomText(text: qty.toString(), fontSize: 25),
            //       InkWell(
            //         onTap: (){
            //           qty++;
            //           setState(() {});
            //         },
            //         child: Stack(
            //           alignment: Alignment.center,
            //           children: [
            //             Container(
            //               height: 30,width: 30,
            //               decoration: BoxDecoration(border: Border.all(width:1),borderRadius: BorderRadius.circular(15)),
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.only(bottom: 5),
            //               child: Text("+",style: TextStyle(fontSize: 30),),
            //             )
            //           ],
            //         ),
            //       ),            ],
            //   ),
            // ),
            const SizedBox(height: 25,),
            if(widget.fromOrder==null)
            Consumer<HomeProvider>(
              builder: (context, homeProvider,child) {
                return HomeStates.marketCategoriesState!=MarketCategoriesState.LOADING?CustomButton(text: "اضف للسلة", onPressed: () async {
                  if(widget.product.sizes!="" || widget.product.colors!="") {
                    if (size == "" || color == "") {
                      toast("من فضلك اختر الحجم واللون", context);
                      return;
                    }
                  }
                  Map formData = {
                    "product_id":widget.product.id.toString(),
                    "quantity":qty.toString(),
                    "size": size,
                    "color": color
                  };
                  print(formData);
                  Map response = await homeProvider.addToCart(formData);
                  if(response['status']){
                    toast("تم إضافة المنتج بنجاح", context);
                  }else{
                    toast(response['msg'], context);
                  }
                  print(response);
                }):Center(child: CircularProgressIndicator());
              }
            )
          ],
        ),
      ),
    );
  }
}
