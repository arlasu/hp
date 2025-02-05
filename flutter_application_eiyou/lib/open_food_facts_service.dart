import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenFoodFactsService {
  static const String _baseUrl =
      "https://world.openfoodfacts.org/api/v0/product";

  // バーコードで検索
  Future<Map<String, dynamic>?> fetchProductByBarcode(String barcode) async {
    final url = Uri.parse("$_baseUrl/$barcode.json");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["status"] == 1) {
          return data["product"];
        }
      }
    } catch (e) {
      print("Error fetching product by barcode: $e");
    }
    return null;
  }

  // 料理名で検索
  Future<List<Map<String, dynamic>>> searchProductsByName(
      String productName) async {
    final url = Uri.parse(
        "https://world.openfoodfacts.org/cgi/search.pl?search_terms=$productName&json=true");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["products"] != null) {
          return List<Map<String, dynamic>>.from(data["products"]);
        }
      }
    } catch (e) {
      print("Error searching products by name: $e");
    }
    return [];
  }
}
