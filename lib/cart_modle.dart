class Cart {
  late final int? id;
  final String? productId;
  final String? productName;
  final int? productPrice;
  final int? intialPrice;
  final int? quantity;
  final String? unitTag;
  final String? image;

  Cart({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.intialPrice,
    required this.unitTag,
    required this.image,
    required this.productId,
    required this.quantity,
  });

  Cart.fromMap(Map<dynamic, dynamic> res)
      : id = res['id'],
        productId = res['productId'],
        quantity = res['quantity'],
        productName = res['productId'],
        productPrice = res['productPrice'],
        intialPrice = res['intialPrice'],
        unitTag = res['unitTag'],
        image = res['image'];
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'intialPrice': intialPrice,
      'quantity': quantity,
      'unitTag': unitTag,
      'image': image,
    };
  }
}
