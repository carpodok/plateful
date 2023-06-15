
class IngredientResponse {
  double amount;
  String image;
  String name;



  IngredientResponse({

    required this.amount,
    required this.image,
    required this.name,

  });

  factory IngredientResponse.fromJson(Map<String, dynamic> json) => IngredientResponse(
    amount: json["amount"],
    image: json["image"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "image": image,
    "name": name,
  };
}
