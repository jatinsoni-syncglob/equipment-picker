import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPrefsDb{

  Future<int> getPickedEquipmentsCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int pickedEquipmentsCount = prefs.getInt('pickedEquipmentsCount') ?? 0;
    return pickedEquipmentsCount;
  }

  Future<void> setPickedEquipmentsCount(int pickedEquipmentsCount) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('pickedEquipmentsCount', pickedEquipmentsCount);
  }

  Future<List> getDataFromSP(String key)async{
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? encodedValue = pref.getString(key);
      if(encodedValue == null){
        await setDataInSP("equipmentPickerData", rawData);
        String? newEncodedValue = pref.getString(key);
        List newDecodedValue = json.decode(newEncodedValue!);
        return newDecodedValue;
      }else{
        List decodedValue = json.decode(encodedValue);
        return decodedValue;
      }
    }catch(e){
      return [];
    }
  }

  Future<void> setDataInSP(String key, List mapValue)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String encodedValue = json.encode(mapValue);
    pref.setString(key, encodedValue).then((value){
    });
  }

  List rawData = [
    {
      "id": 0,
      "equipmentName": "Body Weight",
      "imageUrl": "assets/equipment.png",
      "isPicked": false
    },
    {
      "id": 1,
      "equipmentName": "Dumbbells",
      "imageUrl": "assets/equipment.png",
      "isPicked": false
    },
    {
      "id": 2,
      "equipmentName": "Bands",
      "imageUrl": "assets/equipment.png",
      "isPicked": false
    },
    {
      "id": 3,
      "equipmentName": "Body Weight",
      "imageUrl": "assets/equipment.png",
      "isPicked": false
    },
    {
      "id": 4,
      "equipmentName": "Dumbbells",
      "imageUrl": "assets/equipment.png",
      "isPicked": false
    },
    {
      "id": 5,
      "equipmentName": "Bands",
      "imageUrl": "assets/equipment.png",
      "isPicked": false
    },
  ];

}
