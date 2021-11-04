import 'package:api_product/rating.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product {
  final int id;
  final String title;
  final dynamic price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  Product(this.id, this.title, this.price, this.description, this.category,
      this.image, this.rating);
  static Future<List<Product>> fetchData() async {
    String url = "https://fakestoreapi.com/products";

    var client = http.Client();
    var response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("Lay du lieu thanh cong");
      var result = response.body;
      var jsonData = jsonDecode(result);
      List<Product> ls = [];

      for (var item in jsonData) {
        dynamic rate = item["rating"]["rate"];
        dynamic count = item["rating"]["count"];
        Rating rating = new Rating(rate: rate, count: count);

        var id = item['id'];
        var title = item['title'];
        var price = item['price'];
        var description = item['description'];
        var category = item['category'];
        var image = item['image'];

        Product p =
            new Product(id, title, price, description, category, image, rating);
        ls.add(p);
      }
      print("Length = ${ls.length}");
      return ls;
    } else {
      print("Call api fail");
      throw Exception("Loi lay du lieu");
    }
  }
}
