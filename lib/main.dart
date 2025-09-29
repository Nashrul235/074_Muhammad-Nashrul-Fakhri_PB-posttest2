import 'package:flutter/material.dart';

void main() {
  runApp(const PerfumeShopApp());
}

class PerfumeShopApp extends StatelessWidget {
  const PerfumeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onana TheParfume Shop Wireframe',
      theme: ThemeData(
        primarySwatch: Colors.grey, 
        hintColor: Colors.black,   
        fontFamily: 'Roboto',      
        scaffoldBackgroundColor: Colors.white, 
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black, 
          elevation: 1, 
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300], 
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0), 
            ),
          ),
        ),
      ),
      home: const ProductListScreen(),
    );
  }
}

class Perfume {
  final String name;
  final String? description;
  final double price;
  final String imageUrl;
  int stock;
  final bool isBestSeller;

  Perfume({
    required this.name,
    this.description,
    required this.price,
    required this.imageUrl,
    this.stock = 10,
    this.isBestSeller = false,
  });
}

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final List<Perfume> _perfumes = [
    Perfume(
      name: "Floral Breeze",
      description: "rasa bunga melati dan bunga mawar.",
      price: 150000,
      imageUrl: "lib/Assets/jasmine and rose.png", //asset pada image parfum menggunakan png
      stock: 5,
      isBestSeller: true,
    ),
    Perfume(
      name: "Woody Oud",
      description: "bau oldmoney.",
      price: 250000,
      imageUrl: "lib/Assets/luxury.png", 
      stock: 8,
    ),
    Perfume(
      name: "Citrus Burst",
      description: "bau buah-buahan.",
      price: 120000,
      imageUrl: "lib/Assets/citrus.png", 
      stock: 12,
    ),
    Perfume(
      name: "Sweet Vanilla",
      description: "bau vanilla.",
      price: 180000,
      imageUrl: "lib/Assets/vanilla-removebg-preview.png", 
      stock: 0,
    ),
    Perfume(
      name: "Cooling Fresh",
      description: "dingin kesukaan orang sigma.",
      price: 160000,
      imageUrl: "lib/Assets/cool.png", 
      stock: 7,
      isBestSeller: true,
    ),
    Perfume(
      name: "Warm Spicy",
      description: "aroma panas seperti digibahin.",
      price: 220000,
      imageUrl: "lib/Assets/spicy.png", 
      stock: 3,
    ),
  ];

  final List<Perfume> _cart = [];

  void _addToCart(Perfume perfume) {
    setState(() {
      if (perfume.stock > 0) {
        _cart.add(perfume);
        perfume.stock--;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${perfume.name} ditambahkan ke keranjang!'),
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.grey[700], 
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${perfume.name} stok habis!'),
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.grey[700], 
          ),
        );
      }
    });
  }

  void _viewCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(cartItems: _cart),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onana TheParfume Shop'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: _viewCart,
          ),
        ],
      ),
      body: GridView.builder( //gridview pada tampilan utama parfum
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.75,
        ),
        itemCount: _perfumes.length,
        itemBuilder: (context, index) {
          final perfume = _perfumes[index];
          return Card(
            child: Stack( //stack pada tampilan utama aplikasi parfume berfungsi memeberi tanda bestseller pada parfum
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container( 
                          color: Colors.grey[200], 
                          width: double.infinity,
                          child: perfume.imageUrl.isNotEmpty
                              ? Image.network(
                                  perfume.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.image_not_supported, color: Colors.grey),
                                )
                              : const Icon(Icons.image, color: Colors.grey), 
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        perfume.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal, 
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        perfume.description ?? 'tidak ada deskripsi',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Rp ${perfume.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal, 
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            perfume.stock > 0 ? 'Stok: ${perfume.stock}' : 'Stok Habis!',
                            style: TextStyle(
                              fontSize: 12,
                              color: perfume.stock > 0 ? Colors.black : Colors.grey, 
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_shopping_cart, size: 20),
                            color: Colors.black, 
                            onPressed: perfume.stock > 0
                                ? () => _addToCart(perfume)
                                : null,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (perfume.isBestSeller)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0), 
                          bottomRight: Radius.circular(0),
                        ),
                      ),
                      child: const Text(
                        'BEST SELLER',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Perfume> cartItems;

  const CartScreen({super.key, required this.cartItems});

  double _calculateTotal() {
    return cartItems.fold(0.0, (sum, item) => sum + item.price);
  }

  @override
  Widget build(BuildContext context) {
    final double total = _calculateTotal();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'Keranjang Anda kosong!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder( //listview pada tampilan keranjang belanja 
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: ListTile(
                          leading: Container( 
                            width: 50,
                            height: 50,
                            color: Colors.grey[200], 
                            child: item.imageUrl.isNotEmpty
                                ? Image.network(
                                    item.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.image_not_supported, color: Colors.grey),
                                  )
                                : const Icon(Icons.image, color: Colors.grey),
                          ),
                          title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.normal)),
                          subtitle: Text('Rp ${item.price.toStringAsFixed(0)}', style: const TextStyle(color: Colors.black)),
                          trailing: const Icon(Icons.check_circle_outline, color: Colors.black),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200], 
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                    border: const Border(top: BorderSide(color: Colors.grey, width: 1)), 
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Rp ${total.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Checkout berhasil!'),
                                backgroundColor: Colors.grey,
                            ),
                          );
                        },
                        child: const Text(
                          'Checkout',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
           ),
);
}
}
