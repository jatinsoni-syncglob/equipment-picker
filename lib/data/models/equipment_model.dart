import 'package:freezed_annotation/freezed_annotation.dart';
part 'equipment_model.freezed.dart';
part 'equipment_model.g.dart';

@freezed
class Equipment with _$Equipment {
  const factory Equipment({
    required int id,
    required String equipmentName,
    @Default('N/A') String imageUrl,
    required bool isPicked,
  }) = _Equipment;

  factory Equipment.fromJson(Map<String,dynamic> json) => _$EquipmentFromJson(json);
}
