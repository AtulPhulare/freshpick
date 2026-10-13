class DummyData {
  static const List<Map<String, dynamic>> products = [
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce?w=300&q=80',
      'name': 'Fresh Apple',
      'weight': '1 kg',
      'price': 17.99,
      'originalPrice': 20.99,
      'rating': 4.8,
      'reviewCount': 214,
      'isOrganic': true,
      'description':
          'Crispy and sweet fresh apples picked from the best orchards. Perfect for a healthy snack or making delicious desserts.',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=300&q=80',
      'name': 'Banana',
      'weight': '500 gm',
      'price': 9.99,
      'originalPrice': 12.99,
      'rating': 4.3,
      'reviewCount': 98,
      'isOrganic': false,
      'description':
          'Rich in potassium and energy. These bananas are perfectly ripe and ready to eat.',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1580052614034-c55d20bfee3b?w=300&q=80',
      'name': 'Sweet Orange',
      'weight': '1 kg',
      'price': 14.99,
      'originalPrice': 18.99,
      'rating': 4.5,
      'reviewCount': 176,
      'isOrganic': true,
      'description':
          'Juicy and packed with Vitamin C. Great for fresh juice or a refreshing snack.',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1587393855524-087f83d95bc9?w=300&q=80',
      'name': 'Strawberry',
      'weight': '250 gm',
      'price': 22.99,
      'originalPrice': 26.99,
      'rating': 4.9,
      'reviewCount': 341,
      'isOrganic': true,
      'description':
          'Sweet, red, and delicious. These strawberries are locally grown and freshly harvested.',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1563114773-84221bd62daa?w=300&q=80',
      'name': 'Watermelon',
      'weight': '1 pc',
      'price': 27.99,
      'originalPrice': 32.99,
      'rating': 4.6,
      'reviewCount': 89,
      'isOrganic': false,
      'description':
          'Keeping you hydrated with every bite. This watermelon is sweet, seedless and refreshing.',
    },
  ];

  static const List<Map<String, String>> categories = [
    {'name': 'All', 'image': 'assets/images/all.png'},
    {'name': 'Vegetables', 'image': 'assets/images/vegetables.png'},
    {'name': 'Fruits', 'image': 'assets/images/fruits.png'},
    {'name': 'Meat', 'image': 'assets/images/meat.png'},
    {'name': 'Milk/Juice', 'image': 'assets/images/milk.png'},
  ];

  static const List<Map<String, dynamic>> shops = [
    {
      'name': 'Fresh Produce Market',
      'type': 'Grocery',
      'imageUrl':
          'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400&q=80',
      'address': 'Connaught Place, New Delhi',
      'rating': 4.7,
      'reviewCount': 312,
      'distance': 0.8,
      'deliveryTime': '15-20 min',
      'isOpen': true,
      'freeDelivery': true,
    },
    {
      'name': 'Green Valley Store',
      'type': 'Organic',
      'imageUrl':
          'https://images.unsplash.com/photo-1488459716781-31db52582fe9?w=400&q=80',
      'address': 'Janpath Road, New Delhi',
      'rating': 4.8,
      'reviewCount': 204,
      'distance': 1.2,
      'deliveryTime': '20-25 min',
      'isOpen': true,
      'freeDelivery': false,
    },
    {
      'name': 'Daily Needs Shop',
      'type': 'Grocery',
      'imageUrl':
          'https://images.unsplash.com/photo-1604719312566-8912e9227c6a?w=400&q=80',
      'address': 'Barakhamba Road, New Delhi',
      'rating': 4.3,
      'reviewCount': 98,
      'distance': 1.5,
      'deliveryTime': '20-30 min',
      'isOpen': false,
      'freeDelivery': true,
    },
    {
      'name': 'Farm Fresh Corner',
      'type': 'Vegetables',
      'imageUrl':
          'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400&q=80',
      'address': 'Gole Market, New Delhi',
      'rating': 4.6,
      'reviewCount': 176,
      'distance': 0.6,
      'deliveryTime': '10-15 min',
      'isOpen': true,
      'freeDelivery': true,
    },
    {
      'name': 'Wholesale Hub',
      'type': 'Wholesale',
      'imageUrl':
          'https://images.unsplash.com/photo-1578916171728-46686eac8d58?w=400&q=80',
      'address': 'Paharganj, New Delhi',
      'rating': 4.2,
      'reviewCount': 64,
      'distance': 2.4,
      'deliveryTime': '30-40 min',
      'isOpen': true,
      'freeDelivery': false,
    },
    {
      'name': 'Quick Mart',
      'type': 'Convenience',
      'imageUrl':
          'https://images.unsplash.com/photo-1601599561213-832382fd07ba?w=400&q=80',
      'address': 'Mandi House, New Delhi',
      'rating': 4.4,
      'reviewCount': 141,
      'distance': 1.0,
      'deliveryTime': '10-20 min',
      'isOpen': true,
      'freeDelivery': true,
    },
    {
      'name': 'Local Bazaar',
      'type': 'Market',
      'imageUrl':
          'https://images.unsplash.com/photo-1533900298318-6b8da08a523e?w=400&q=80',
      'address': 'Karol Bagh, New Delhi',
      'rating': 4.5,
      'reviewCount': 233,
      'distance': 3.1,
      'deliveryTime': '35-45 min',
      'isOpen': false,
      'freeDelivery': false,
    },
  ];
}
