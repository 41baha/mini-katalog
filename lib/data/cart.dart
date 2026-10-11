import '../models/product.dart';

// Sepetteki ürünler (basit bir liste, ekranlar setState ile yenilenir)
final List<Product> cartItems = [];

// Ürün sepette yoksa ekler. Eklediyse true, zaten varsa false döner
bool addToCart(Product product) {
  final alreadyIn = cartItems.any((p) => p.id == product.id);
  if (alreadyIn) return false;
  cartItems.add(product);
  return true;
}

void removeFromCart(Product product) {
  cartItems.removeWhere((p) => p.id == product.id);
}

// Sepetteki ürünlerin toplam fiyatı
double get cartTotal =>
    cartItems.fold<double>(0, (sum, p) => sum + p.priceValue);