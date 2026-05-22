import 'package:ap2_sistemas_moveis/shared/api/cat_api.dart';
import 'package:ap2_sistemas_moveis/shared/widgets/cat_card.dart';
import 'package:flutter/material.dart';
import '../models/cat_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiCat api = ApiCat();

  final ScrollController _scrollController = ScrollController();

  List<CatModel> cats = [];

  int page = 0;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    loadCats();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        loadCats();
      }
    });
  }

  Future<void> loadCats() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    final newCats = await api.getCats(page);

    setState(() {
      page++;

      cats.addAll(newCats);

      isLoading = false;
    });
  }

  Future<void> refreshCats() async {
    setState(() {
      cats.clear();
      page = 0;
    });

    await loadCats();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text('Galeria de Gatinhos'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),

      body: RefreshIndicator(
        onRefresh: refreshCats,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: cats.length + 1,
          itemBuilder: (context, index) {
            if (index < cats.length) {
              return CatCard(cat: cats[index]);
            }

            return const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}