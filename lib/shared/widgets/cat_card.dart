import 'package:ap2_sistemas_moveis/modules/cat_model.dart';
import 'package:flutter/material.dart';

class CatCard extends StatelessWidget {
  final CatModel cat;

  const CatCard({
    super.key,
    required this.cat,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            child: Image.network(
              cat.imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cat.breedName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'Peso: ${cat.weight} kg',
                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 8),

                Text(
                  'Adaptabilidade: ${cat.adaptability}/5',
                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Descrição:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  cat.description,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}