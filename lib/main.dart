// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


void main() {
  runApp(const FoodPlannerApp());
}

class FoodPlannerApp extends StatefulWidget {
  const FoodPlannerApp({super.key});

  @override
  _FoodPlannerAppState createState() => _FoodPlannerAppState();
}

class _FoodPlannerAppState extends State<FoodPlannerApp> {
  ThemeData _themeData = ThemeData(
    primarySwatch: Colors.pink,
  );

  void _onThemeChanged(ThemeData themeData) {
    setState(() {
      _themeData = themeData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perencanaan Makanan',
      theme: _themeData,
      home: FoodPlannerHomePage(onThemeChanged: _onThemeChanged),
      routes: {
        '/profile': (context) => const ProfilePage(),
        '/shoppingList': (context) => const ShoppingListPage(),
        '/themeSelection': (context) =>
            ThemeSelectionPage(onThemeChanged: _onThemeChanged),
      },
    );
  }
}

class FoodPlannerHomePage extends StatelessWidget {
  final ValueChanged<ThemeData> onThemeChanged;
  final List<String> daysOfWeek = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu'
  ];

  FoodPlannerHomePage({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perencana Makanan'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'profile') {
                Navigator.pushNamed(context, '/profile');
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Profile'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice.toLowerCase(),
                  child: Text(choice),
                );
              }).toList();
            },
            icon: const Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: daysOfWeek.map((day) => DayPlanner(day: day)).toList(),
        ),
      ),
    );
  }
}

class ThemeSelectionPage extends StatelessWidget {
  final ValueChanged<ThemeData> onThemeChanged;

  const ThemeSelectionPage({required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Telusuri Tema'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Tema',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    onThemeChanged(ThemeData(
                      primarySwatch: Colors.pink,
                      scaffoldBackgroundColor: Colors.white,
                    ));
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/theme1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Center(
                            child: Text('Tema 1',
                                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0)))),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onThemeChanged(ThemeData(
                      primarySwatch: Colors.blue,
                      scaffoldBackgroundColor: Colors.white,
                    ));
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/theme2.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Center(
                            child: Text('Tema 2',
                                style: TextStyle(color: Color.fromARGB(0, 255, 255, 255)))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DayPlanner extends StatelessWidget {
  final String day;

  const DayPlanner({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.pinkAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    day,
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DailyMealPage(day: day),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const MealEntry(mealType: 'Sarapan    '),
            const MealEntry(mealType: 'Makan       '),
            const MealEntry(mealType: 'Makanan   '),
            const MealEntry(mealType: 'Makan       '),
          ],
        ),
      ),
    );
  }
}

class MealEntry extends StatelessWidget {
  final String mealType;

  const MealEntry({super.key, required this.mealType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.lightBlueAccent,
            child: Text(
              mealType,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 10.0),
          const Text('Tambahkan Makanan'),
        ],
      ),
    );
  }
}

class DailyMealPage extends StatelessWidget {
  final String day;

  const DailyMealPage({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Makanan $day'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          MealCard(mealType: 'Sarapan'),
          MealCard(mealType: 'Makan Siang'),
          MealCard(mealType: 'Makanan Ringan'),
          MealCard(mealType: 'Makan Malam'),
        ],
      ),
    );
  }
}

class MealCard extends StatelessWidget {
  final String mealType;

  const MealCard({super.key, required this.mealType});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  mealType.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.pinkAccent),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddFoodPage(mealType: mealType),
                      ),
                    );
                    if (result != null) {
                      // Lakukan sesuatu dengan hasilnya (misal: tambahkan ke daftar makanan)
                      print('Makanan ditambahkan: $result');
                    }
                  },
                ),
              ],
            ),
            const Text(
              'Tambahkan Makanan',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class AddFoodPage extends StatefulWidget {
  final String mealType;

  const AddFoodPage({super.key, required this.mealType});

  @override
  _AddFoodPageState createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  final TextEditingController foodController = TextEditingController();
  final List<String> foodList = [];

  void addFoodItem(String food) {
    setState(() {
      foodList.add(food);
    });
  }

  void removeFoodItem(int index) {
    setState(() {
      foodList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambahkan Makanan - ${widget.mealType}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Masukkan Makanan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: foodController,
              decoration: InputDecoration(
                hintText: 'Masukkan nama makanan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: const Icon(Icons.camera_alt),
                 
                suffixIcon: IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    if (foodController.text.isNotEmpty) {
                      addFoodItem(foodController.text);
                      foodController.clear();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Pilih Makanan Anda',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: foodList.isEmpty
                  ? const Center(
                      child: Text(
                        'Anda belum memasukkan makanan apa pun',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: foodList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.camera_alt),
                          title: Text(foodList[index]),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              removeFoodItem(index);
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset(
              'assets/cat_image.png',
              height: 200,
            ),
            const SizedBox(height: 20),
            ProfileOption(
              icon: Icons.shopping_basket,
              text: 'Daftar Belanja',
              onTap: () {
                Navigator.pushNamed(context, '/shoppingList');
              },
            ),
            ProfileOption(
              icon: Icons.brush,
              text: 'Sesuaikan Desain',
              onTap: () {
                Navigator.pushNamed(context, '/themeSelection');
              },
            ),
            ProfileOption(
              icon: Icons.star,
              text: 'Beri peringkat Aplikasi',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }
}

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  List<String> shoppingList = [];
  List<String> recentItems = [];

  TextEditingController itemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Belanja'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Daftar'),
              Tab(text: 'Terbaru'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildShoppingListTab(),
            buildRecentItemsTab(),
          ],
        ),
      ),
    );
  }

  Widget buildShoppingListTab() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: shoppingList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(shoppingList[index]),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: itemController,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan makanan',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  setState(() {
                    String newItem = itemController.text;
                    if (newItem.isNotEmpty) {
                      shoppingList.add(newItem);
                      recentItems.add(newItem);
                      itemController.clear();
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildRecentItemsTab() {
    return ListView.builder(
      itemCount: recentItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(recentItems[index]),
        );
      },
    );
  }
}
