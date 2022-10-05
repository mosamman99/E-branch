import 'package:ebranch/Components/Components.dart';
import 'package:ebranch/Helpers/Config.dart';
import 'package:ebranch/Models/HomeModels/ProductsModel.dart';
import 'package:ebranch/Providers/AuthProvider.dart';
import 'package:ebranch/Providers/HomeProvider.dart';
import 'package:ebranch/States/HomeStates.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Helpers/Navigation.dart';
import 'DrawerScreen.dart';
import 'ProductDetailsScreen.dart';
class ProductsScreen extends StatefulWidget {
  String name,id;
  ProductsScreen({Key key,this.name,this.id}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String filter;
  var filterController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: widget.name,leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){Navigator.pop(context);})),
      endDrawer: DrawerScreen(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                Row(
                  children: [
                    // Icon(Icons.filter_alt_outlined),
                    // const SizedBox(width: 6,),
                    // DropdownButton(
                    //   hint: Text("فرز حسب"),
                    //   value: filter,
                    //   onChanged: (value){
                    //     filter = value;
                    //     setState(() {});
                    //   },
                    //   items: ["الأقل سعرا" , "الأكثر مبيعا" , "الأحدث"].map((e) {
                    //     return DropdownMenuItem(
                    //       value: e,
                    //       child: Text(filter??e),
                    //     );
                    //   }).toList(),
                    // )
                  ],
                ),
                const SizedBox(width: 7,),
                Container(width: Config.responsiveWidth(context)*0.88,height: 45,child: CustomInput(controller: filterController, hint: "البحث", textInputType: TextInputType.text,suffixIcon: IconButton(icon: Icon(Icons.search,size: 32,color: Color(0xff000000),), onPressed: (){}),))
              ],
            ),
            const SizedBox(height: 15,),
            ChangeNotifierProvider(
              create: (_) => HomeProvider()..getProducts(widget.id),
              child: Consumer<HomeProvider>(
                builder: (context, homeProvider,child) {
                  if(homeProvider.productsModel==null){
                    return Center(child: CircularProgressIndicator());
                  }else if(homeProvider.productsModel.data.isEmpty){
                    return Center(child: CustomText(text: "لا يوجد منتجات", fontSize: 18));
                  }

                  if(HomeStates.marketOffersState==MarketOffersState.ERROR){
                    return CustomText(text: "حدث خطأ", fontSize: 16);
                  }
                  return Expanded(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 10,
                        childAspectRatio: (Config.responsiveHeight(context)*0.15 / 160),
                        children: List.generate(homeProvider.productsModel.data.length, (index) {
                          return ProductCard(name: homeProvider.productsModel.data[index].name,image: homeProvider.productsModel.data[index].photo,price: homeProvider.productsModel.data[index].price.toString(),onTap: (){
                            Navigation.mainNavigator(context, ProductDetailsScreen(product: homeProvider.productsModel.data[index]));
                          }, catName: homeProvider.productsModel.data[index].cat.name,);
                        }),
                      ),
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
