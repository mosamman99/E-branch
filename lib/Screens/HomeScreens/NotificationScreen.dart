import 'package:ebranch/Components/Components.dart';
import 'package:ebranch/Helpers/Config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/HomeProvider.dart';
import '../../States/HomeStates.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "الاشعارات"),
      body: ChangeNotifierProvider(
        create: (BuildContext context)  => HomeProvider()..getNotification(),
        child: Consumer<HomeProvider>(
            builder: (context, homeProvider,_) {
              if(homeProvider.notificationModel==null){
                return Center(child: CircularProgressIndicator());
              }else if(homeProvider.notificationModel.data.isEmpty){
                return Center(child: CustomText(text: "لا يوجد اشعارات", fontSize: 18));
              }
              if(HomeStates.marketOffersState==MarketOffersState.ERROR){
                return CustomText(text: "حدث خطأ", fontSize: 16);
              }
              return ListView.separated(
                itemBuilder: (context,index){
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: homeProvider.notificationModel.data[index].createdAt.substring(0,10), fontSize: 16,color: Colors.black,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(text: "${homeProvider.notificationModel.data[index].title}\n${homeProvider.notificationModel.data[index].body}${homeProvider.notificationModel.data[index].order!=null?"        ${homeProvider.notificationModel.data[index].order['id']}":""}", fontSize: 14,color: Config.mainColor,),
                              const SizedBox(width: 10,),
                              Icon(Icons.notifications_sharp,size: 30,color: Config.mainColor,)
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context,index){
                  return SizedBox(height: 15,);
                },
                itemCount: homeProvider.notificationModel.data.length
            );
          }
        ),
      ),
    );
  }
}
