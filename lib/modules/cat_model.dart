class CatModel {
  final String imageUrl;
  final String breedName;
  final String description;
  final String weight;
  final int adaptability;

  CatModel({
    required this.imageUrl,
    required this.breedName,
    required this.description,
    required this.weight,
    required this.adaptability,
  });

  factory CatModel.fromJson(Map<String, dynamic> json) {
    String breedName = 'Sem raça informada';
    String description = 'Sem descrição';
    String weight = 'Não informado';
    int adaptability = 0;

    if (json['breeds'] != null && json['breeds'].isNotEmpty) {
      final breed = json['breeds'][0];

      breedName = breed['name'] ?? breedName;

      description = breed['description'] ?? description;

      weight = breed['weight']?['metric'] ?? weight;

      adaptability = breed['adaptability'] ?? adaptability;
    }

    return CatModel(
      imageUrl: json['url'] ?? '',
      breedName: breedName,
      description: description,
      weight: weight,
      adaptability: adaptability,
    );
  }

  factory CatModel.fromBreedJson(
    Map<String, dynamic> json, {
    String? imageUrl,
  }) {
    final referenceImageId = json['reference_image_id'];

    return CatModel(
      imageUrl: imageUrl ??
          (referenceImageId != null
              ? 'https://cdn2.thecatapi.com/images/$referenceImageId.jpg'
              : ''),
      breedName: json['name'] ?? 'Sem raça informada',
      description: json['description'] ?? 'Sem descrição',
      weight: json['weight']?['metric'] ?? 'Não informado',
      adaptability: json['adaptability'] ?? 0,
    );
  }
}
