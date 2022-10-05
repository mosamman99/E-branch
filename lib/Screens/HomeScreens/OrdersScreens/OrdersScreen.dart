import 'package:flutter/material.dart';

import '../../../Components/Components.dart';
import '../../../Helpers/Config.dart';
import 'CurrentOrdersPage.dart';
import 'FinishedOrdersPage.dart';
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "الطلبات"),
      body: DefaultTabController(
        length: 2,
        initialIndex: 1,
        child: Column(
          children: [
            TabBar(
                indicatorWeight: 2,
                indicatorColor: Config.mainColor,
                tabs: <Widget>[
                  Tab(child: Text("الطلبات المنتهية",style: TextStyle(color: Config.mainColor),),),
                  Tab(child: Text("الطلبات الحالية",style: TextStyle(color: Config.mainColor),),),
                ]
            ),

            Expanded(
              child: TabBarView(
                  children: <Widget>[
                    FinishedOrdersPage(),
                    CurrentOrdersPage()
                  ]),
            ),
          ],
        ),
      )
    );
  }
}
