part of 'equipment_picker_cubit.dart';

@freezed
class EquipmentPickerState with _$EquipmentPickerState{
  const factory EquipmentPickerState.initial() = _Initial;
  const factory EquipmentPickerState.loading() = _Loading;
  const factory EquipmentPickerState.success(List<Equipment> equipmentList, bool isCircularProgressIndicator) = _Success;
  const factory EquipmentPickerState.failure(String error) = _Failure;
}
