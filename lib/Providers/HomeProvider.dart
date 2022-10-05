import 'package:ebranch/Helpers/HelperFunctions.dart';
import 'package:ebranch/Models/HomeModels/CartModel.dart';
import 'package:ebranch/Models/HomeModels/CategoriesModel.dart';
import 'package:ebranch/Models/HomeModels/ChatsModels/AllChatModel.dart';
import 'package:ebranch/Models/HomeModels/ChatsModels/ChatModel.dart';
import 'package:ebranch/Models/HomeModels/MarketModels/SlidersModel.dart';
import 'package:ebranch/Models/HomeModels/MarketsModel.dart';
import 'package:ebranch/Models/HomeModels/NotificationModel.dart';
import 'package:ebranch/Models/HomeModels/ProductsModel.dart';
import 'package:ebranch/Models/HomeModels/OrderModel.dart';
import 'package:ebranch/Repositories/HomeRepositories.dart';
import 'package:ebranch/States/HomeStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeProvider extends ChangeNotifier{
  Future<CategoriesModel> getCategories()async{
    HomeStates.catState = CatState.LOADING;
    notifyListeners();
    Map response = await HomeRepositories.getCategories();
    try{
      CategoriesModel categoriesModel = CategoriesModel.fromJson(response);
      HomeStates.catState = CatState.LOADED;
      notifyListeners();
      return categoriesModel;
    }catch(e){
      HomeStates.catState = CatState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

  Future<MarketsModel> getMarkets(id)async{
    HomeStates.marketsState = MarketsState.LOADING;
    notifyListeners();
    Map response = await HomeRepositories.getMarkets(id);
    try{
      MarketsModel marketsModel = MarketsModel.fromJson(response);
      HomeStates.marketsState = MarketsState.LOADED;
      notifyListeners();
      return marketsModel;
    }catch(e){
      HomeStates.marketsState = MarketsState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

  Future<MarketsModel> getMarketsWithLocation(lat,lang)async{
    HomeStates.marketsState = MarketsState.LOADING;
    notifyListeners();
    Map response = await HomeRepositories.getMarketsWithLocation(lat,lang);
    try{
      MarketsModel marketsModel = MarketsModel.fromJson(response);
      HomeStates.marketsState = MarketsState.LOADED;
      notifyListeners();
      return marketsModel;
    }catch(e){
      HomeStates.marketsState = MarketsState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }


  Future<SlidersModel> getMarketSliders(id)async{
    HomeStates.marketSlidersState = MarketSlidersState.LOADING;
    notifyListeners();
    Map response = await HomeRepositories.getMarketSliders(id);
    try{
      SlidersModel slidersModel = SlidersModel.fromJson(response);
      HomeStates.marketSlidersState = MarketSlidersState.LOADED;
      notifyListeners();
      return slidersModel;
    }catch(e){
      HomeStates.marketSlidersState = MarketSlidersState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }


  Future<ProductsModel> getMarketOffers(id)async{
    HomeStates.marketOffersState = MarketOffersState.LOADING;
    notifyListeners();
    Map response = await HomeRepositories.getMarketOffers(id);
    try{
      ProductsModel slidersModel = ProductsModel.fromJson(response);
      HomeStates.marketOffersState = MarketOffersState.LOADED;
      notifyListeners();
      return slidersModel;
    }catch(e){
      HomeStates.marketOffersState = MarketOffersState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

  NotificationModel notificationModel;
   getNotification()async{
    HomeStates.marketOffersState = MarketOffersState.LOADING;
    notifyListeners();
    Map response = await HomeRepositories.getNotification();
    try{
      notificationModel = NotificationModel.fromJson(response);
      HomeStates.marketOffersState = MarketOffersState.LOADED;
      notifyListeners();
      return notificationModel;
    }catch(e){
      HomeStates.marketOffersState = MarketOffersState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }


  ProductsModel _productsModel ;
  ProductsModel get productsModel => _productsModel;
  Future<ProductsModel> getProducts(id)async{
    HomeStates.marketOffersState = MarketOffersState.LOADING;
    notifyListeners();
    Map response = await HomeRepositories.getProducts(id);
    try{
      _productsModel = ProductsModel.fromJson(response);
      HomeStates.marketOffersState = MarketOffersState.LOADED;
      notifyListeners();
      return _productsModel;
    }catch(e){
      HomeStates.marketOffersState = MarketOffersState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }


  Future<ProductsModel> getRandomProducts()async{
    HomeStates.marketOffersState = MarketOffersState.LOADING;
    notifyListeners();
    Map response = await HomeRepositories.getRandomProducts();
    try{
      ProductsModel slidersModel = ProductsModel.fromJson(response);
      HomeStates.marketOffersState = MarketOffersState.LOADED;
      notifyListeners();
      return slidersModel;
    }catch(e){
      HomeStates.marketOffersState = MarketOffersState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

  ProductsModel bestSeller;
  Future<ProductsModel> getBestSeller(id)async{
    HomeStates.marketOffersState = MarketOffersState.LOADING;
    notifyListeners();
    Map response = await HomeRepositories.getBestSeller(id);
    try{
      bestSeller = ProductsModel.fromJson(response);
      HomeStates.marketOffersState = MarketOffersState.LOADED;
      notifyListeners();
      return bestSeller;
    }catch(e){
      HomeStates.marketOffersState = MarketOffersState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

  CartModel _cartModel ;
  CartModel get cartModel => _cartModel;

  double _total=0;
  double get total => _total;
  List<int> quantities = [];

  List<int> productIds = [];
  int shippingType = 0;

   getCartData()async{
    HomeStates.marketOffersState = MarketOffersState.LOADING;
    notifyListeners();
    Map response = await HomeRepositories.getCartData();
    try{
     _cartModel = CartModel.fromJson(response);
     _cartModel.data.forEach((element) {
       quantities.add(1);
       productIds.add(element.id);
       _total += double.parse(element.offer==null?element.price.toString():(double.parse(element.price.toString())-(double.parse(element.price.toString())*(double.parse(element.offer.toString())/100))).toString());
     });
      HomeStates.marketOffersState = MarketOffersState.LOADED;
      notifyListeners();
      return _cartModel;
    }catch(e){
      HomeStates.marketOffersState = MarketOffersState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

  changeQuantity(index,quantity){
     quantities.insert(index, quantity);
     quantities.removeAt(index+1);
     notifyListeners();
  }

  addToTotal(price){
     _total = _total+price;
     notifyListeners();
  }

  removeFromTotal(price){
     _total = _total-price;
     notifyListeners();
  }

  changeShippingType(value){
     shippingType = value;
     notifyListeners();
  }

  Future<CategoriesModel> getMarketCategories(id)async{
    HomeStates.marketCategoriesState = MarketCategoriesState.LOADING;
    notifyListeners();
    Map response = await HomeRepositories.getMarketCategories(id);
    try{
      CategoriesModel categoriesModel = CategoriesModel.fromJson(response);
      HomeStates.marketCategoriesState = MarketCategoriesState.LOADED;
      notifyListeners();
      return categoriesModel;
    }catch(e){
      HomeStates.marketCategoriesState = MarketCategoriesState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

  addToCart(formData)async{
    HomeStates.marketCategoriesState = MarketCategoriesState.LOADING;
    notifyListeners();
    try{
      Map response = await HomeRepositories.addToCart(formData);
      HomeStates.marketCategoriesState = MarketCategoriesState.LOADED;
      notifyListeners();
      return response;
    }catch(e){
      HomeStates.marketCategoriesState = MarketCategoriesState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

  Future<Map> removeCartItem(id)async{
    try{
      Map response = await HomeRepositories.removeCartItem(id);
      notifyListeners();
      return response;
    }catch(e){
      notifyListeners();
      return Future.error(e);
    }
  }


  Future<Map> cancelOrder(id)async{
    try{
      Map response = await HomeRepositories.cancelOrder(id);
      notifyListeners();
      return response;
    }catch(e){
      notifyListeners();
      return Future.error(e);
    }
  }


  LatLng _position;
  LatLng get getPosition => _position;
  setPosition(LatLng position){
    _position = position;
    notifyListeners();
  }

  String _address;
  String get getAddress => _address;
  setAddress(String address){
    _address = address;
    notifyListeners();
  }

  makeOrder(formData)async{
    HomeStates.makeOrderState = MakeOrderState.LOADING;
    notifyListeners();
    try{
      Map response = await HomeRepositories.makeOrder(formData);
      HomeStates.makeOrderState = MakeOrderState.LOADED;
      notifyListeners();
      return response;
    }catch(e){
      HomeStates.makeOrderState = MakeOrderState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

  rateOrder(formData)async{
    HomeStates.makeOrderState = MakeOrderState.LOADING;
    notifyListeners();
    try{
      Map response = await HomeRepositories.rateOrder(formData);
      HomeStates.makeOrderState = MakeOrderState.LOADED;
      notifyListeners();
      return response;
    }catch(e){
      HomeStates.makeOrderState = MakeOrderState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

  sendMsg(formData)async{
    notifyListeners();
    try{
      Map response = await HomeRepositories.sendMsg(formData);
      notifyListeners();
      return response;
    }catch(e){
      notifyListeners();
      return Future.error(e);
    }
  }

  OrderModel currentOrderModel;
  getCurrentOrder(endPoint)async{
    HomeStates.currentOrderState = CurrentOrderState.LOADING;
    notifyListeners();
    try{
      Map response = await HomeRepositories.getCurrentOrders(endPoint);
      currentOrderModel = OrderModel.fromJson(response);
      HomeStates.currentOrderState = CurrentOrderState.LOADED;
      notifyListeners();
    }catch(e){
      HomeStates.currentOrderState = CurrentOrderState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

  OrderModel previousOrderModel;
  getPreviousOrder()async{
    HomeStates.previousOrderState = PreviousOrderState.LOADING;
    notifyListeners();
    try{
      Map response = await HomeRepositories.getPreviousOrders();
      previousOrderModel = OrderModel.fromJson(response);
      HomeStates.previousOrderState = PreviousOrderState.LOADED;
      notifyListeners();
    }catch(e){
      HomeStates.previousOrderState = PreviousOrderState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

  AllCatsModel allCatsModel;
  getChatsList()async{
    HomeStates.fetchChatSate = FetchChatSate.LOADING;
    notifyListeners();
    try{
      Map response = await HomeRepositories.getChatsList();
      allCatsModel = AllCatsModel.fromJson(response);
      HomeStates.fetchChatSate = FetchChatSate.LOADED;
      notifyListeners();
    }catch(e){
      HomeStates.fetchChatSate = FetchChatSate.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

  getChat(id)async{
    HomeStates.fetchChatSate = FetchChatSate.LOADING;
    notifyListeners();
    try{
      Map response = await HomeRepositories.getChat(id);
      ChatModel chatModel = ChatModel.fromJson(response);
      await HomeRepositories.seenChat(id);
      HomeStates.fetchChatSate = FetchChatSate.LOADED;
      notifyListeners();
      return chatModel;
    }catch(e){
      HomeStates.fetchChatSate = FetchChatSate.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

  contactUs(formData)async{
    HomeStates.fetchChatSate = FetchChatSate.LOADING;
    notifyListeners();
    try{
      Map response = await HomeRepositories.contactUs(formData);
      HomeStates.fetchChatSate = FetchChatSate.LOADED;
      notifyListeners();
      return response;
    }catch(e){
      HomeStates.fetchChatSate = FetchChatSate.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }
  Map response;
  terms(type)async{
    HomeStates.fetchChatSate = FetchChatSate.LOADING;
    notifyListeners();
    try{
      response = await HomeRepositories.terms(type);
      HomeStates.fetchChatSate = FetchChatSate.LOADED;
      notifyListeners();
      return response;
    }catch(e){
      HomeStates.fetchChatSate = FetchChatSate.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

}