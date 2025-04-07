import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu du Restaurant',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Menu du Restaurant'),
    );
  }
}

// On créé un enum pour nos différentes catégories
enum Category { entrees, plats, desserts, boissons, sauces }

// Page principale
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Category? _selectedCategory = Category.entrees;

  // Liste de toutes nos données à afficher (plats) : Liste de notre composant Plat
  final Map<Category, List<PlatData>> platsParCategory = {
    Category.entrees: [
      PlatData(
        title: "Carottes râpées",
        imageUrl: "https://www.epicetoo.fr/wp-content/uploads/2024/06/recette-carottes-rap-es-au-carvi.jpg",
        price: 4.96,
        description: "Des carottes râpées fraîches.",
      ),
      PlatData(
        title: "Soupe froide",
        imageUrl: "https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/197434B8-D801-429A-9D6A-261ABEB17B30/Derivates/5875cf44-15e7-4299-8abb-234d633b3d5a.jpg",
        price: 5.50,
        description: "Soupe froide à base de légumes verts.",
      ),
    ],
    Category.plats: [
      PlatData(
        title: "Bouillabaisse",
        imageUrl: "https://littleferrarokitchen.com/wp-content/uploads/2023/05/Easy-French-seafood-stew-bouillabaisse.jpg",
        price: 14.38,
        description: "Spécialité de la côte d'Azur.",
      ),
      PlatData(
        title: "Steak Frites",
        imageUrl: "https://foodmymuse.com/wp-content/uploads/2024/03/SteakFrites3-500x500.jpg",
        price: 12.00,
        description: "Un classique toujours efficace.",
      ),
    ],
    Category.desserts: [
      PlatData(
        title: "Tarte Tatin",
        imageUrl: "https://www.177milkstreet.com/assets/site/Recipes/_large/Tarte-Tatin.jpg",
        price: 6.50,
        description: "Tarte aux pommes caramélisées.",
      ),
      PlatData(
        title: "Mousse au chocolat",
        imageUrl: "https://img-3.journaldesfemmes.fr/-EgBiqR2f4Et83dUhweifcxxbrE=/750x500/f322d57630aa46a4b589b1da445b4571/ccmcms-jdf/39977905.jpg",
        price: 5.00,
        description: "Un dessert incontournable.",
      ),
    ],
    Category.boissons: [
      PlatData(
        title: "Eau minérale",
        imageUrl: "https://www.team-creatif.com/wp-content/uploads/2021/08/Volvic-Mise-en-avant.png",
        price: 1.50,
        description: "Eau minérale fraîche.",
      ),
      PlatData(
        title: "Coca Cola",
        imageUrl: "https://www.centraleboissons.com/25760-thickbox_default/COCA-COLA-VC-33CL-X24.jpg",
        price: 2.00,
        description: "Boisson gazeuse tellement sucré que ça génère du diabète",
      ),
      PlatData(
        title: "Jus d'orange",
        imageUrl: "https://im.qccdn.fr/node/comment-nous-testons-jus-d-orange-le-protocole-15017/thumbnail_1000x600px-118822.jpg",
        price: 2.50,
        description: "Jus d'orange pressé.",
      ),
    ],
    Category.sauces: [
      PlatData(
        title: "Mayonnaise",
        imageUrl: "https://i2.wp.com/www.downshiftology.com/wp-content/uploads/2023/05/Mayonnaise-Recipe-main-1-1.jpg",
        price: 0.50,
        description: "Mayonnaise maison.",
      ),
      PlatData(
        title: "Ketchup",
        imageUrl: "https://cdn-s-www.leprogres.fr/images/48c8333f-775d-42ed-8087-2dae92d50ca4/NW_raw/ajoutez-une-touche-de-couleur-et-de-saveur-a-vos-oeufs-brouilles-omelettes-ou-oeufs-poches-en-les-garnissant-d-une-cuilleree-de-ketchup-photo-shutterstock-1709631130.jpg",
        price: 0.50,
        description: "Ketchup doux.",
      ),
      PlatData(
        title: "Sauce piquante",
        imageUrl: "https://revolutionfermentation.com/wp-content/uploads/2021/07/sauce-piquante-lactofermentee-maison-piments-1400x788-1.jpg",
        price: 0.75,
        description: "Sauce piquante artisanale.",
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final plats = _selectedCategory == null
        ? platsParCategory.values.expand((list) => list).toList()
        : platsParCategory[_selectedCategory]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // Row scrollable de nos catégories
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: Category.values.map((category) {
                final label = category.name[0].toUpperCase() + category.name.substring(1);
                final isSelected = category == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  // utilisation de ChoiceChip pour simplifier la gestion de la catégorie à afficher
                  child: ChoiceChip(
                    label: Text(label),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        _selectedCategory = (_selectedCategory == category) ? null : category;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          // GridView de nos plats à afficher
          const SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.all(8),
              children: plats.map((plat) => PlatCard(plat: plat)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Class pour typer ce que nous avons besoin dans notre widget
class PlatData {
  final String title;
  final String imageUrl;
  final double price;
  final String description;

  PlatData({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
  });
}

// Création d'un widget pour éviter de dupliquer le code
class PlatCard extends StatelessWidget {
  const PlatCard({super.key, required this.plat});
  final PlatData plat;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plat.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Image.network(
              plat.imageUrl,
              height: 80,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 5),
            Text('${plat.price.toStringAsFixed(2)} €', style: const TextStyle(color: Colors.teal)),
            const SizedBox(height: 5),
            Text(plat.description, maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}