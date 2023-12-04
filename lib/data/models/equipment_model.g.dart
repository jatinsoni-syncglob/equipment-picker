// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EquipmentImpl _$$EquipmentImplFromJson(Map<String, dynamic> json) =>
    _$EquipmentImpl(
      id: json['id'] as int,
      equipmentName: json['equipmentName'] as String,
      imageUrl: json['imageUrl'] as String? ?? 'N/A',
      isPicked: json['isPicked'] as bool,
    );

Map<String, dynamic> _$$EquipmentImplToJson(_$EquipmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'equipmentName': instance.equipmentName,
      'imageUrl': instance.imageUrl,
      'isPicked': instance.isPicked,
    };
