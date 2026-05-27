import 'dart:convert';
import 'package:ap2_sistemas_moveis/modules/cat_model.dart';
import 'package:http/http.dart' as http;

class ApiCat {
  Future<List<CatModel>> getCats(int page) async {
    final breedsUri = Uri.https('api.thecatapi.com', '/v1/breeds');

    final response = await http.get(breedsUri);

    if (response.statusCode != 200) {
      throw Exception('Erro ao carregar raças da Api');
    }

    final List breeds = jsonDecode(response.body);
    final start = (page * 10) % breeds.length;
    final selectedBreeds = List.generate(
      10,
      (index) => breeds[(start + index) % breeds.length],
    );

    final cats = await Future.wait(
      selectedBreeds.map((breed) async {
        final referenceImageId = breed['reference_image_id'];

        if (referenceImageId == null) {
          return CatModel.fromBreedJson(breed);
        }

        final imageUri = Uri.https(
          'api.thecatapi.com',
          '/v1/images/$referenceImageId',
        );
        final imageResponse = await http.get(imageUri);

        final imageUrl = imageResponse.statusCode == 200
            ? jsonDecode(imageResponse.body)['url']
            : null;

        return CatModel.fromBreedJson(breed, imageUrl: imageUrl);
      }),
    );

    return cats;
  }
}
