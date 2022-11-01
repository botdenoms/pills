class Product {
  final String name;
  final String description;
  final String category;
  final int price;
  final int amount;
  final String imageUrl;
  final String? id;
  // int downloads = 0;

  Product({
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.amount,
    required this.imageUrl,
    required this.id,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'],
      description: map['description'],
      category: map['category'],
      price: map['price'],
      amount: map['amount'],
      imageUrl: map['imageurl'],
      id: map['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'amount': amount,
      'imageUrl': imageUrl,
      'id': id,
    };
  }

  int get itemPrice => price;

  String priceFormat() {
    return "$itemPrice Ksh";
  }
}
