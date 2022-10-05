import 'dart:async';

import 'package:ebranch/Components/Components.dart';
import 'package:ebranch/Helpers/Config.dart';
import 'package:ebranch/Helpers/HelperFunctions.dart';
import 'package:ebranch/Helpers/location_service.dart';
import 'package:ebranch/Providers/HomeProvider.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PickLocationMapScreen extends StatefulWidget {
  double lat,lang;
  String typeScreen;
  PickLocationMapScreen({Key key,this.lat,this.lang,this.typeScreen}) : super(key: key);

  @override
  _PickLocationMapScreenState createState() => _PickLocationMapScreenState();
}

class _PickLocationMapScreenState extends State<PickLocationMapScreen> {
  GoogleMapController googleMapController;
  CameraPosition _initialCameraPosition;
  LatLng _currentLocation;

  var searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialCameraPosition = CameraPosition(target: LatLng(widget.lat,widget.lang), zoom: 8);
    Future.delayed(Duration(seconds: 0),()async{
      if(widget.typeScreen==null) {
        Provider.of<HomeProvider>(context, listen: false).setAddress(null);
        Provider.of<HomeProvider>(context, listen: false).setPosition(null);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(

        child: Stack(

          alignment: AlignmentDirectional.center,

          children: [

            SizedBox.expand(

              child: _initialCameraPosition != null ?
              FutureBuilder(
                future: Future.delayed(Duration(milliseconds: 300), () => true),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return GoogleMap(
                      initialCameraPosition: _initialCameraPosition,
                      onMapCreated: (map){
                        googleMapController = map;
                      },
                      myLocationButtonEnabled: false,
                      myLocationEnabled: true,
                      onCameraMove: (CameraPosition position) {
                        _currentLocation = position.target;
                        },
                    );
                  }
                  return SizedBox();
                },
              )
                  : SizedBox(),

            ),

            SizedBox.expand(
              child: Center(
                child: Icon(Icons.add_location,color: Config.mainColor,size: 30,)
              ),
            ),

            Positioned(
              top: 60,
              right: 10,
              child: Row(
                children: [
                  Container(
                    color: Colors.white,
                    width: Config.responsiveWidth(context)*0.7,
                    child: CustomInput(controller: searchController, hint: "ابحث عن موقع", textInputType: TextInputType.text,onChange: (v) async {
                      print(v);
                        var addresses = await Geocoder.local.findAddressesFromQuery(v);
                      print(addresses);
                      var first = addresses.first;
                      _currentLocation = LatLng(addresses.first.coordinates.latitude, addresses.first.coordinates.longitude);
                      if (_currentLocation != null) {
                        googleMapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                                CameraPosition(target: LatLng(_currentLocation.latitude, _currentLocation.longitude), zoom: 16)
                            )
                        );
                      }
                      print("${first.featureName} : ${first.coordinates}");
                    },),
                  ),
                  SizedBox(width: 15,),
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: IconButton(
                      color: Config.mainColor,
                      icon: Icon(Icons.my_location),
                      onPressed: () async {

                        Position currentLocation = await determinePosition();

                        if (currentLocation != null) {
                            googleMapController.animateCamera(
                                CameraUpdate.newCameraPosition(
                                    CameraPosition(target: LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 16)
                                )
                            );
                        }

                      },
                    ),
                  ),


                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(text: context.watch<HomeProvider>().getAddress??'',textAlign: TextAlign.center, fontSize: 16,),
                    const Spacer(),
                    CustomButton(text: "تحديد", verticalPadding: 10,color: Config.mainColor,horizontalPadding: Config.responsiveWidth(context)*0.4,onPressed: () async {
                      String address = await LocationService.getAddress(LatLng(_currentLocation.latitude, _currentLocation.longitude));
                      Provider.of<HomeProvider>(context,listen: false).setAddress(address);
                      context.read<HomeProvider>().setPosition(_currentLocation);
                      Navigator.pop(context,[context.read<HomeProvider>().getAddress,context.read<HomeProvider>().getPosition]);
                    },)
                  ],
                ),
              ),
            )
          ],
        ),

      ),
    );
  }

}
