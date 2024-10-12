import 'package:ecomerce/route/route_constants.dart';
import 'package:ecomerce/screens/home/views/components/best_sellers.dart';
import 'package:ecomerce/screens/home/views/components/flash_sale.dart';
import 'package:ecomerce/screens/home/views/components/most_popular.dart';
import 'package:ecomerce/screens/home/views/components/offer_carousel_and_categories.dart';
import 'package:ecomerce/screens/home/views/components/popular_products.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cart_screen.dart';
import 'components/Banner/S/banner_s_style_1.dart';
import 'components/Banner/S/banner_s_style_5.dart';
import 'components/product/product_card.dart';
import 'constants.dart';
import 'custom_search_delegate.dart';
import 'models/product_model.dart';
import 'product_details_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Product list and their corresponding prices
  Map<String, double> products = {
    'Smartphone': 699.99,
    'Laptop': 999.99,
    'Headphones': 199.99,
    'Smartwatch': 299.99,
    'Tablet': 399.99,
    'Camera': 499.99,
    'Speaker': 149.99,
    'Monitor': 249.99,
  };

  List<String> filteredProducts = [];
  String searchQuery = ""; // Track the search query
  bool isSearching = false; // Track if search is active
  int _selectedIndex = 2; // Current selected tab index

  // Initialize screens for the bottom navigation tabs
  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = []; // Start with an empty list
    _screens.addAll([
      HomeScreen(),
      CatagoriesScreen(),
      ProductsScreen(
        products: products,
        filteredProducts: filteredProducts,
        isSearching: isSearching,
        onSearch: filterProducts,
      ),
      ContactPage(),
    ]);
  }

  void filterProducts(String query) {
    setState(() {
      searchQuery = query; // Update the search query
      if (query.isNotEmpty) {
        filteredProducts = products.keys
            .where((product) =>
            product.toLowerCase().contains(query.toLowerCase())) // Filter logic
            .toList();
      } else {
        filteredProducts = []; // Clear the list if query is empty
      }
      _screens[2] = ProductsScreen(
        products: products,
        filteredProducts: filteredProducts,
        isSearching: isSearching,
        onSearch: filterProducts,
      ); // Update ProductsScreen
    });
  }

  void toggleSearch() {
    setState(() {
      isSearching = !isSearching; // Toggle search mode
      if (!isSearching) {
        filteredProducts = [];
        searchQuery = "";
      }
      _screens[2] = ProductsScreen(
        products: products,
        filteredProducts: filteredProducts,
        isSearching: isSearching,
        onSearch: filterProducts,
      ); // Update ProductsScreen
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected tab index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shop Products',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: [
          if (_selectedIndex == 2) // Show search icon only in Products tab
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: toggleSearch, // Toggle search mode
              color: Colors.white,
            ),
        ],
      ),
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple,
        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            backgroundColor: Colors.grey,

            icon: Icon(Icons.home,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category, ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart ,),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail, ),
            label: 'Contact',
          ),
        ],
        currentIndex: _selectedIndex, // Set the current index
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped, // Handle item tap
      ),
    );
  }
}

// Simple placeholder for Home Screen


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: OffersCarouselAndCategories()),
            const SliverToBoxAdapter(child: PopularProducts()),
            const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: defaultPadding * 1.5),
              sliver: SliverToBoxAdapter(child: FlashSale()),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  BannerSStyle1(
                    title: "New \narrival",
                    subtitle: "SPECIAL OFFER",
                    discountParcent: 50,
                    press: () {
                      Navigator.pushNamed(context, onSaleScreenRoute);
                    },
                  ),
                  const SizedBox(height: defaultPadding / 4),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: BestSellers()),
            const SliverToBoxAdapter(child: MostPopular()),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: defaultPadding * 1.5),
                  BannerSStyle5(
                    title: "Black \nfriday",
                    subtitle: "50% Off",
                    bottomText: "Collection".toUpperCase(),
                    press: () {
                      Navigator.pushNamed(context, onSaleScreenRoute);
                    },
                  ),
                  const SizedBox(height: defaultPadding / 4),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: BestSellers()),
          ],
        ),
      ),
    );
  }
}





class CatagoriesScreen extends StatelessWidget {
  const CatagoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // While loading use 👇
          //  BookMarksSlelton(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: defaultPadding,
                crossAxisSpacing: defaultPadding,
                childAspectRatio: 0.66,
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return ProductCard(
                    image: demoPopularProducts[index].image,
                    brandName: demoPopularProducts[index].brandName,
                    title: demoPopularProducts[index].title,
                    price: demoPopularProducts[index].price,
                    priceAfetDiscount:
                    demoPopularProducts[index].priceAfetDiscount,
                    dicountpercent: demoPopularProducts[index].dicountpercent,
                    press: () {
                      Navigator.pushNamed(context, productDetailsScreenRoute);
                    },
                  );
                },
                childCount: demoPopularProducts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Product Screen with search functionality
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key, required List<String> filteredProducts,
    required Map<String, double> products, required bool isSearching,
    required void Function(String query) onSearch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: OffersCarouselAndCategories()),
            const SliverToBoxAdapter(child: PopularProducts()),
            const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: defaultPadding * 1.5),
              sliver: SliverToBoxAdapter(child: FlashSale()),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  BannerSStyle1(
                    title: "New \narrival",
                    subtitle: "SPECIAL OFFER",
                    discountParcent: 50,
                    press: () {
                      Navigator.pushNamed(context, onSaleScreenRoute);
                    },
                  ),
                  const SizedBox(height: defaultPadding / 4),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: BestSellers()),
            const SliverToBoxAdapter(child: MostPopular()),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: defaultPadding * 1.5),
                  BannerSStyle5(
                    title: "Black \nfriday",
                    subtitle: "50% Off",
                    bottomText: "Collection".toUpperCase(),
                    press: () {
                      Navigator.pushNamed(context, onSaleScreenRoute);
                    },
                  ),
                  const SizedBox(height: defaultPadding / 4),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: BestSellers()),
          ],
        ),
      ),
    );
  }
}

// Simple placeholder for Contact Screen


class ContactPage extends StatelessWidget {
  final String email = 'gaminghuzaifa893@gmail.com';
  final String phone = '+923260934003';
  final messageController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Section
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://pics.craiyon.com/2023-11-26/oMNPpACzTtO5OVERUZwh3Q.webp'),
              ),
              SizedBox(height: 16),
              Text(
                'MUHAMMAD ZEESHAN ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
              ),
              SizedBox(height: 4),
              Text(
                'Flutter Developer',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(height: 10),
        
              // Contact Information
              ListTile(
                leading: Icon(Icons.phone),
                title: Text(phone),
                onTap: () => _launchPhone(phone),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text(email),
                onTap: () => _launchEmail(email),
              ),
        
              // Social Media Links (example for LinkedIn)
              ListTile(
                leading: Icon(Icons.link),
                title: Text('LinkedIn Profile'),
                onTap: () => _launchURL('https://www.linkedin.com/in/muhammad-zeeshan-'),
              ),
        
              // Message Form (simplified)
              TextField(
                controller: messageController,
                decoration: InputDecoration(
                  labelText: 'Message',
        
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 10),
        
              // Send Button
              ElevatedButton(
        
                onPressed: ()async {
        
                  if(await canLaunchUrl(messageController as Uri));
        
                  // Handle send message action
                },
                child: Text('Send Message'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:Colors.green.shade500,
        onPressed: (){
          String url =
              "https://wa.me/+923045873730/?text=Hello";
          launch(url);
        },child:FaIcon(FontAwesomeIcons.whatsapp,color: Colors.white,),
      ),
    );
  }

  // Helper methods for launching actions
  void _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  void _launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}




