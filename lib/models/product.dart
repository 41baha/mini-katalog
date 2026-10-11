class Product {
  final int id;
  final String name;
  final String tagline;
  final String description;
  final String price;
  final String image;
  final Map<String, String> specs;

  Product({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.price,
    required this.image,
    required this.specs,
  });

  // JSON'daki bir ürünü Product nesnesine çevirir
  factory Product.fromJson(Map<String, dynamic> json) {
    final rawSpecs = json['specs'] as Map<String, dynamic>;
    return Product(
      id: json['id'],
      name: json['name'],
      tagline: json['tagline'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      specs: rawSpecs.map((key, value) => MapEntry(key, value.toString())),
    );
  }

  // Görselin adresini projedeki asset yoluna çevirir
  // (https://wantapi.com/assets/images/iphone.png -> assets/images/iphone.png)
  String get imageAsset => 'assets/images/${image.split('/').last}';

  // "$1,299" gibi yazıyı 1299.0 sayısına çevirir (sepet toplamı için)
  double get priceValue =>
      double.parse(price.replaceAll('\$', '').replaceAll(',', ''));
}