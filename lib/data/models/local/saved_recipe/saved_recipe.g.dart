// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_recipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedRecipeAdapter extends TypeAdapter<SavedRecipe> {
  @override
  final int typeId = 0;

  @override
  SavedRecipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedRecipe(
      id: fields[0] as int,
      title: fields[1] as String,
      image: fields[2] as String,
      summary: fields[3] as String,
      ingredients: (fields[4] as List).cast<Ingredient>(),
    );
  }

  @override
  void write(BinaryWriter writer, SavedRecipe obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.summary)
      ..writeByte(4)
      ..write(obj.ingredients);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedRecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
