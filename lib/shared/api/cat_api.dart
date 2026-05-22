import 'dart:convert';

import 'package:ap2_sistemas_moveis/models/cat_model.dart';
import 'package:http/http.dart' as http;

class ApiCat{
  Future<List<CatModel>> getCats(int page) async{
    final url = 'https://api.thecatapi.com/v1/images/search?limit=20&page=$page';

    final response = await http.get(Uri.parse(url));

    if( response.statusCode == 200){
      final List data = jsonDecode(response.body);

      return data.map((json) => CatModel.fromJson(json)).toList();
    }else{
      throw Exception('Erro ao carregar dados da Api');
    }
  }
}