import 'package:ebranch/Helpers/HelperFunctions.dart';
import 'package:ebranch/Helpers/Navigation.dart';
import 'package:ebranch/Models/HomeModels/OrderModel.dart';
import 'package:ebranch/Providers/HomeProvider.dart';
import 'package:ebranch/States/HomeStates.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Components/Components.dart';
import 'OrderDetailsScreen.dart';
class FinishedOrdersPage extends StatefulWidget {
  const FinishedOrdersPage({Key key}) : super(key: key);

  @override
  _FinishedOrdersPageState createState() => _FinishedOrdersPageState();
}

class _FinishedOrdersPageState extends State<FinishedOrdersPage> {
  OrderModel orderModel;
  HomeProvider provider;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ChangeNotifierProvider(
        create: (BuildContext context) => HomeProvider()..getCurrentOrder("old-orders"),
        child: Selector<HomeProvider,CurrentOrderState>(
            selector: (context,homeProvider){
              provider = homeProvider;
              orderModel = homeProvider.currentOrderModel;
              return HomeStates.currentOrderState;
            },
            builder: (context, state,child) {
              print("state :  $state");
              if(state == CurrentOrderState.LOADING) {return Center(child: CircularProgressIndicator());}
              if(orderModel.data.isEmpty) { return Center(child: CustomText(text: "لا يوجد طلبات منتهية", fontSize: 18)); }

              return SingleChildScrollView(
                child: ListView.separated(
                    reverse: true,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                  return OrderCard(orderId: orderModel.data[index].id.toString(),storeName: orderModel.data[index].products[0].user.name,phone: orderModel.data[index].products[0].user.phone,onTap: (){
                        Navigation.mainNavigator(context, OrderDetailsScreen(products: orderModel.data[index].products,orderStatus: orderModel.data[index].status,orderId: orderModel.data[index].id.toString(),rate: orderModel.data[index].rate,deliveryPrice: orderModel.data[index].deliveryPrice,finalPrice: int.parse(orderModel.data[index].price.toString()),photo: orderModel.data[index].photo,orderType: orderModel.data[index].type,));
                      },price: orderModel.data[index].price.toString(),date: orderModel.data[index].createdAt.substring(0,10), qty: orderModel.data[index].amount,image: orderModel.data[index].products[0].photo,cancelOrder: () async {
                        Map response = await provider.removeCartItem(orderModel.data[index].id);
                        toast(response['msg'], context);
                        if(response['status']){
                          provider.getCurrentOrder("old-orders");
                        }
                      },);
                    },
                    separatorBuilder: (context,index){return SizedBox(height: 15,);},
                    itemCount: orderModel.data.length
                ),
              );
            }
        ),
      ),
    );
  }
}
