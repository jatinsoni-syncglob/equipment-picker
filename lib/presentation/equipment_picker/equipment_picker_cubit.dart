import 'package:equipment_picker/presentation/components/custom_widgets.dart';
import 'package:equipment_picker/data/models/equipment_model.dart';
import 'package:equipment_picker/data/repository/repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'equipment_picker_cubit.freezed.dart';
part 'equipment_picker_state.dart';

class EquipmentPickerCubit extends Cubit<EquipmentPickerState> {

  List<Equipment> equipmentList = [];
  SharedPrefsDb sharedPrefsDb = SharedPrefsDb();
  bool isCircularProgressIndicator = false;

  EquipmentPickerCubit() : super(const EquipmentPickerState.initial());

  Future<void> getData() async {
    emit(const EquipmentPickerState.loading());
    List dataFromSp = await sharedPrefsDb.getDataFromSP("equipmentPickerData");
    try {
      equipmentList.clear();
      if(dataFromSp.isNotEmpty){
        for (Map<String, dynamic> element in dataFromSp) {
          try{
            equipmentList.add(Equipment.fromJson(element));
          }catch(e){
            if (kDebugMode) print("Unable to parse JSON");
            equipmentList.add(Equipment(id: element['id'],
                equipmentName: element['equipmentName'],
                isPicked: element['isPicked'],
            ),
            );
          }
        }
      }else{
        if (kDebugMode) print("No data available");
      }
      emit(EquipmentPickerState.success(equipmentList,isCircularProgressIndicator));
    } catch (e) {
      emit(EquipmentPickerState.failure(e.toString()));
    }
  }

  void showCircularProgressIndicator() {
    emit(const EquipmentPickerState.loading());
    isCircularProgressIndicator = ! isCircularProgressIndicator;
    emit(EquipmentPickerState.success(equipmentList,isCircularProgressIndicator));
  }

  Future<void> pickEquipment(BuildContext context,int id) async {
    int pickedEquipmentCount = await sharedPrefsDb.getPickedEquipmentsCount();
    if(pickedEquipmentCount<3){
      List rawData = await sharedPrefsDb.getDataFromSP("equipmentPickerData");
      rawData[id]["isPicked"] = ! rawData[id]["isPicked"];
      equipmentList.clear();
      await sharedPrefsDb.setDataInSP("equipmentPickerData", rawData);
      if(!rawData[id]["isPicked"]){
        await sharedPrefsDb.setPickedEquipmentsCount(pickedEquipmentCount==0?0:pickedEquipmentCount-1);
      }else{
        await sharedPrefsDb.setPickedEquipmentsCount(pickedEquipmentCount+1);
      }
      try {
        emit(const EquipmentPickerState.loading());
        for (Map<String, dynamic> element in rawData) {
          equipmentList.add(Equipment.fromJson(element));
        }
        emit(EquipmentPickerState.success(equipmentList,isCircularProgressIndicator));
      } catch (e) {
        emit(EquipmentPickerState.failure(e.toString()));
      }
    }else{
      List rawData = await sharedPrefsDb.getDataFromSP("equipmentPickerData");
      equipmentList.clear();
      if(rawData[id]["isPicked"]){
        rawData[id]["isPicked"] = ! rawData[id]["isPicked"];
        await sharedPrefsDb.setDataInSP("equipmentPickerData", rawData);
        await sharedPrefsDb.setPickedEquipmentsCount(pickedEquipmentCount==0?0:pickedEquipmentCount-1);
        try {
          emit(const EquipmentPickerState.loading());
          for (Map<String, dynamic> element in rawData) {
            equipmentList.add(Equipment.fromJson(element));
          }
          emit(EquipmentPickerState.success(equipmentList,isCircularProgressIndicator));
        } catch (e) {
          emit(EquipmentPickerState.failure(e.toString()));
        }
      }else{
        try {
          emit(const EquipmentPickerState.loading());
          for (Map<String, dynamic> element in rawData) {
            equipmentList.add(Equipment.fromJson(element));
          }
          if (context.mounted) ScaffoldMessenger.of(context).hideCurrentSnackBar();
          if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(customSnackBar('Sorry, But you can only Pick upto 3 equipments'));
          emit(EquipmentPickerState.success(equipmentList,isCircularProgressIndicator));
        } catch (e) {
          emit(EquipmentPickerState.failure(e.toString()));
        }
      }
    }
  }

  void showSnackBar(BuildContext context){
    if (context.mounted) ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(customSnackBar('Pick an equipment'));
  }
}

