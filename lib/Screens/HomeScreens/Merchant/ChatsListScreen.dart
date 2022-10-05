import 'package:ebranch/Components/Components.dart';
import 'package:ebranch/Helpers/HelperFunctions.dart';
import 'package:ebranch/Helpers/Navigation.dart';
import 'package:ebranch/Providers/HomeProvider.dart';
import 'package:ebranch/States/HomeStates.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Repositories/HomeRepositories.dart';
import 'ChatsScreen.dart';
class ChatsListScreen extends StatefulWidget {
  const ChatsListScreen({Key key}) : super(key: key);

  @override
  _ChatsListScreenState createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "المحادثات"),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => HomeProvider()..getChatsList(),
        child: Consumer<HomeProvider>(
          builder: (context, provider,child) {
            if(HomeStates.fetchChatSate == FetchChatSate.LOADING){
              return Center(child: CircularProgressIndicator());
            }
            if(HomeStates.fetchChatSate == FetchChatSate.LOADED && provider.allCatsModel.data.isEmpty){
              return Center(child: CustomText(text: "لا يوجد محادثات", fontSize: 18));
            }

            return SingleChildScrollView(
              child: Column(
                children: List.generate(provider.allCatsModel.data.length, (index) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () async {
                            await HomeRepositories.seenChat(provider.allCatsModel.data[index].id);
                            await provider.getChatsList();
                            Navigation.mainNavigator(context, ChatsScreen(merchantId: provider.allCatsModel.data[index].id.toString(),merchantName: provider.allCatsModel.data[index].name));
                          },
                          contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          title: CustomText(text: provider.allCatsModel.data[index].name, fontSize: 18,fontWeight: FontWeight.bold,),
                          leading: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Icon(Icons.local_convenience_store_rounded,size: 50,),
                              if(provider.allCatsModel.data[index].seenUser==0)
                              CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.red,
                              )
                            ],
                          ),
                        ),
                        Divider(thickness: 1,)
                      ],
                    ),
                  );
                }),
              ),
            );
          }
        ),
      ),
    );
  }
}
