
class SimilarRecipeResponse {
  int id;

  SimilarRecipeResponse({
    required this.id,

  });

  factory SimilarRecipeResponse.fromJson(Map<String, dynamic> json) => SimilarRecipeResponse(
    id: json["id"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
