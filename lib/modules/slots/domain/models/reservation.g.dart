// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReservationImpl _$$ReservationImplFromJson(Map<String, dynamic> json) =>
    _$ReservationImpl(
      id: (json['id'] as num).toInt(),
      slotId: (json['slotid'] as num).toInt(),
      date:
          const ReservationDateTimeConverter().fromJson(json['date'] as String),
      userId: (json['userid'] as num).toInt(),
      reserverId: (json['reserverid'] as num).toInt(),
    );

Map<String, dynamic> _$$ReservationImplToJson(_$ReservationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slotid': instance.slotId,
      'date': const ReservationDateTimeConverter().toJson(instance.date),
      'userid': instance.userId,
      'reserverid': instance.reserverId,
    };
