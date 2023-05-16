// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartitemAdapter extends TypeAdapter<CartItems> {
  @override
  final int typeId = 0;

  @override
  CartItems read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItems(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as int?,
      fields[3] as String?,
      fields[4] as String?,
      fields[5] as int?,
      fields[6] as String?,
    )
      ..realprice = fields[7] as int?
      ..percentprice = fields[8] as num?;
  }

  @override
  void write(BinaryWriter writer, CartItems obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.categoryid)
      ..writeByte(1)
      ..write(obj.collectionId)
      ..writeByte(2)
      ..write(obj.discountprice)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.thumbnail)
      ..writeByte(7)
      ..write(obj.realprice)
      ..writeByte(8)
      ..write(obj.percentprice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartitemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
