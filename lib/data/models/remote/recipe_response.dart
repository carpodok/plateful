class RecipeResponse {
  int id;
  String title;
  String image;

  RecipeResponse({required this.id, required this.title, required this.image});

  factory RecipeResponse.fromjson(Map<String, dynamic> json) => RecipeResponse(
        id: json["id"],
        title: json["title"],
        image: json["image"],
      );
}
