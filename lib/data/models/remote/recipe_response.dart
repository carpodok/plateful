class RecipeResponse {
  int id;
  String title;
  String image;
  String summary;

  RecipeResponse(
      {required this.id,
      required this.title,
      required this.image,
      required this.summary});

  factory RecipeResponse.fromjson(Map<String, dynamic> json) => RecipeResponse(
      id: json["id"],
      title: json["title"],
      image: json["image"],
      summary: json["summary"]);
}
