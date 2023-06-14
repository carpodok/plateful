
class IngredientResponse {
  String aisle;
  double amount;
  int id;
  String image;
  String name;
  String original;
  String originalName;
  String unit;
  String unitLong;
  String unitShort;

  IngredientResponse({
    required this.aisle,
    required this.amount,
    required this.id,
    required this.image,
    required this.name,
    required this.original,
    required this.originalName,
    required this.unit,
    required this.unitLong,
    required this.unitShort,
  });

  factory IngredientResponse.fromJson(Map<String, dynamic> json) => IngredientResponse(
    aisle: json["aisle"],
    amount: json["amount"],
    id: json["id"],
    image: json["image"],
    name: json["name"],
    original: json["original"],
    originalName: json["originalName"],
    unit: json["unit"],
    unitLong: json["unitLong"],
    unitShort: json["unitShort"],
  );

  Map<String, dynamic> toJson() => {
    "aisle": aisle,
    "amount": amount,
    "id": id,
    "image": image,
    "name": name,
    "original": original,
    "originalName": originalName,
    "unit": unit,
    "unitLong": unitLong,
    "unitShort": unitShort,
  };
}
