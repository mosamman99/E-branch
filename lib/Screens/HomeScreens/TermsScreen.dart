import 'package:ebranch/Components/Components.dart';
import 'package:ebranch/Providers/HomeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../States/HomeStates.dart';
class TermsScreen extends StatefulWidget {
  String type;
  TermsScreen({Key key,this.type}) : super(key: key);

  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(text: widget.type=="about"?"معلومات عننا":widget.type=="privcy"?"سياسة الخصوصية":"الشروط والأحكام"),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => HomeProvider()..terms(widget.type),
        child: Consumer<HomeProvider>(
          builder: (context, provider,child) {
            if(HomeStates.fetchChatSate == FetchChatSate.LOADING){
              return Center(child: CircularProgressIndicator());
            }
              return Center(
              child: CustomText(text: provider.response['data'], fontSize: 16),
            );
          }
        ),
      ),
    );
  }
}
