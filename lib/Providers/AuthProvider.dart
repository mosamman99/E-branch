import 'package:ebranch/Models/AuthModels/CitiesModel.dart';
import 'package:ebranch/Models/AuthModels/CountriesModel.dart';
import 'package:ebranch/Models/AuthModels/UserModel.dart';
import 'package:ebranch/Repositories/AuthRepositories.dart';
import 'package:ebranch/States/AuthStates.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier{
  //  Future<CountriesModel> getCountries()async{
  //   States.countriesState = CountriesState.LOADING;
  //   notifyListeners();
  //   Map response = await AuthRepositories.getCountries();
  //   try{
  //     CountriesModel countriesModel = CountriesModel.fromJson(response);
  //     States.countriesState = CountriesState.LOADED;
  //     notifyListeners();
  //     return countriesModel;
  //   }catch(e){
  //     States.countriesState = CountriesState.ERROR;
  //     notifyListeners();
  //     return Future.error(e);
  //   }
  // }
  //  Future<CitiesModel> getCities(id)async{
  //   States.citiesState = CitiesState.LOADING;
  //   notifyListeners();
  //   Map response = await AuthRepositories.getCities(id);
  //   try{
  //     CitiesModel citiesModel = CitiesModel.fromJson(response);
  //     States.citiesState = CitiesState.LOADED;
  //     notifyListeners();
  //     return citiesModel;
  //   }catch(e){
  //     States.citiesState = CitiesState.ERROR;
  //     notifyListeners();
  //     return Future.error(e);
  //   }
  // }

  Future<UserModel> register(formData)async{
    States.registerState = RegisterState.LOADING;
    notifyListeners();
    try{
      Map response = await AuthRepositories.register(formData);
      UserModel userModel = UserModel.fromJson(response);
      States.registerState = RegisterState.LOADED;
      notifyListeners();
      return userModel;
    }catch(e){
      States.registerState = RegisterState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }


  Future<UserModel> login(formData)async{
    States.registerState = RegisterState.LOADING;
    notifyListeners();
    try{
      Map response = await AuthRepositories.login(formData);
      UserModel userModel = UserModel.fromJson(response);
      States.registerState = RegisterState.LOADED;
      notifyListeners();
      return userModel;
    }catch(e){
      States.registerState = RegisterState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }


  forgotPass(formData)async{
    States.registerState = RegisterState.LOADING;
    notifyListeners();
    try{
      Map response = await AuthRepositories.forgotPass(formData);
      States.registerState = RegisterState.LOADED;
      notifyListeners();
      return response;
    }catch(e){
      States.registerState = RegisterState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }


  
}