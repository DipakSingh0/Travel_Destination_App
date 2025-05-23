// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DestinationAdapter extends TypeAdapter<Destination> {
  @override
  final int typeId = 0;

  @override
  Destination read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Destination(
      imageUrl: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      price: fields[3] as String,
      isAsset: fields[4] as bool,
      rating: fields[6] as double,
      latitude: fields[7] as double,
      longitude: fields[8] as double,
      isFavorite: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Destination obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.imageUrl)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.isAsset)
      ..writeByte(5)
      ..write(obj.isFavorite)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.latitude)
      ..writeByte(8)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DestinationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
