import 'package:flutter/material.dart';
import 'open_food_facts_service.dart';
import 'MealRecordScreen.dart'; // MealRecordScreenをインポート

class FoodSearchScreen extends StatefulWidget {
  @override
  _FoodSearchScreenState createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController(); // 料理名用
  final OpenFoodFactsService _service = OpenFoodFactsService();

  String? _productName;
  String? _calories;
  String? _protein;
  String? _fat;
  String? _fiber; // 食物繊維
  String? _sodium; // 塩分
  List<Map<String, dynamic>> _products = [];
  String? _selectedProduct;

// 料理名で検索
  Future<void> _searchFoodByName() async {
    final productName = _nameController.text;
    if (productName.isEmpty) return;

    final products = await _service.searchProductsByName(productName);

    setState(() {
      _products = products;
      if (_products.isNotEmpty) {
        final product = _products[0];

        _productName = product["product_name"];
        _calories =
            product["nutriments"]?["energy-kcal_100g"]?.toString() ?? "N/A";
        _protein = product["nutriments"]?["proteins_100g"]?.toString() ?? "N/A";
        _fat = product["nutriments"]?["fat_100g"]?.toString() ?? "N/A";
        _fiber = product["nutriments"]?["fiber_100g"]?.toString() ?? "N/A";
        _sodium = product["nutriments"]?["sodium_100g"]?.toString() ?? "N/A";
      } else {
        _productName = "Not Found";
        _calories = _protein = _fat = _fiber = _sodium = null;
      }
    });
  }

// バーコードで検索
  Future<void> _searchFood() async {
    final barcode = _barcodeController.text;
    if (barcode.isEmpty) return;

    final product = await _service.fetchProductByBarcode(barcode);

    setState(() {
      if (product != null) {
        _productName = product["product_name"] ?? "Unknown";
        _calories =
            product["nutriments"]?["energy-kcal_100g"]?.toString() ?? "N/A";
        _protein = product["nutriments"]?["proteins_100g"]?.toString() ?? "N/A";
        _fat = product["nutriments"]?["fat_100g"]?.toString() ?? "N/A";
        _fiber = product["nutriments"]?["fiber_100g"]?.toString() ?? "N/A";
        _sodium = product["nutriments"]?["sodium_100g"]?.toString() ?? "N/A";
      } else {
        _productName = "Not Found";
        _calories = _protein = _fat = _fiber = _sodium = "N/A";
      }
    });
  }

  // 商品を選択した場合の処理
  void _selectProduct(Map<String, dynamic> product) {
    setState(() {
      _productName = product["product_name"];
      _calories =
          product["nutriments"]?["energy-kcal_100g"]?.toString() ?? "N/A";
      _protein = product["nutriments"]?["proteins_100g"]?.toString() ?? "N/A";
      _fat = product["nutriments"]?["fat_100g"]?.toString() ?? "N/A";
      _fiber = product["nutriments"]?["fiber_100g"]?.toString() ?? "N/A";
      _sodium = product["nutriments"]?["sodium_100g"]?.toString() ?? "N/A";
      _selectedProduct = product["product_name"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('食品検索')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 料理名検索用
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: '料理名を入力'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _searchFoodByName,
              child: Text('検索'),
            ),
            // バーコード検索用
            TextField(
              controller: _barcodeController,
              decoration: InputDecoration(labelText: 'バーコードを入力'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _searchFood,
              child: Text('検索'),
            ),
            // 商品が複数の場合、選択できるボタンを表示
            if (_products.isNotEmpty) ...[
              SizedBox(height: 24),
              Text('検索結果:'),
              for (var product in _products)
                ListTile(
                  title: Text(product["product_name"] ?? "Unknown"),
                  onTap: () => _selectProduct(product),
                ),
            ],
            // 1つだけの場合に表示
            if (_productName != null) ...[
              SizedBox(height: 24),
              Text('食品名: $_productName'),
              Text('カロリー (100g): $_calories kcal'),
              Text('タンパク質 (100g): $_protein g'),
              Text('脂質 (100g): $_fat g'),
              Text('食物繊維 (100g): $_fiber g'),
              Text('塩分 (100g): $_sodium g'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MealRecordScreen(
                        productName: _productName,
                        calories: _calories,
                        protein: _protein,
                        fat: _fat,
                        fiber: _fiber,
                        salt: _sodium, // ここで栄養素を渡す
                      ),
                    ),
                  );
                },
                child: Text('この食品を記録する'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
