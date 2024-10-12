import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> data = [
    {
      'name': 'New Arrival: Special Offer 50% Off',
      'image': 'images/V1MXgfa.png',
      'description': 'Get 50% off on new arrivals. Limited time offer.',
      'price': 100.0,
    },
    {
      'name': 'Black Friday: Collection 50% Off',
      'image': 'images/8gvE5Ss.png',
      'description': 'Massive 50% discount on Black Friday collection.',
      'price': 200.0,
    },
    {
      'name': 'Flash Sale: Up to 70% Off',
      'image': 'images/3mSE5sN.png',
      'description': 'Hurry! Get up to 70% off in the flash sale.',
      'price': 150.0,
    },
    {
      'name': 'Best Sellers: Trending Products',
      'image': 'images/UM3GdWg.png',
      'description': 'Check out the top trending products of the season.',
      'price': 250.0,
    },
    {
      'name': 'Popular Products: Limited Edition',
      'image': 'images/5M89G2P.png',
      'description': 'Exclusive limited edition products just for you.',
      'price': 300.0,
    },
    {
      'name': 'New Arrival: Special Offer 50% Off',
      'image': 'images/V1MXgfa.png',
      'description': 'Get 50% off on new arrivals. Limited time offer.',
      'price': 100.0,
    },
    {
      'name': 'Black Friday: Collection 50% Off',
      'image': 'images/8gvE5Ss.png',
      'description': 'Massive 50% discount on Black Friday collection.',
      'price': 200.0,
    },
    {
      'name': 'Flash Sale: Up to 70% Off',
      'image': 'images/3mSE5sN.png',
      'description': 'Hurry! Get up to 70% off in the flash sale.',
      'price': 150.0,
    },
    {
      'name': 'Best Sellers: Trending Products',
      'image': 'images/UM3GdWg.png',
      'description': 'Check out the top trending products of the season.',
      'price': 250.0,
    },
    {
      'name': 'Popular Products: Limited Edition',
      'image': 'images/5M89G2P.png',
      'description': 'Exclusive limited edition products just for you.',
      'price': 300.0,
    },
    {
      'name': 'New Arrival: Special Offer 50% Off',
      'image': 'images/V1MXgfa.png',
      'description': 'Get 50% off on new arrivals. Limited time offer.',
      'price': 100.0,
    },
    {
      'name': 'Black Friday: Collection 50% Off',
      'image': 'images/8gvE5Ss.png',
      'description': 'Massive 50% discount on Black Friday collection.',
      'price': 200.0,
    },
    {
      'name': 'Flash Sale: Up to 70% Off',
      'image': 'images/3mSE5sN.png',
      'description': 'Hurry! Get up to 70% off in the flash sale.',
      'price': 150.0,
    },
    {
      'name': 'Best Sellers: Trending Products',
      'image': 'images/UM3GdWg.png',
      'description': 'Check out the top trending products of the season.',
      'price': 250.0,
    },
    {
      'name': 'Popular Products: Limited Edition',
      'image': 'images/5M89G2P.png',
      'description': 'Exclusive limited edition products just for you.',
      'price': 300.0,
    },
    {
      'name': 'New Arrival: Special Offer 50% Off',
      'image': 'images/V1MXgfa.png',
      'description': 'Get 50% off on new arrivals. Limited time offer.',
      'price': 100.0,
    },
    {
      'name': 'Black Friday: Collection 50% Off',
      'image': 'images/8gvE5Ss.png',
      'description': 'Massive 50% discount on Black Friday collection.',
      'price': 200.0,
    },
    {
      'name': 'Flash Sale: Up to 70% Off',
      'image': 'images/3mSE5sN.png',
      'description': 'Hurry! Get up to 70% off in the flash sale.',
      'price': 150.0,
    },
    {
      'name': 'Best Sellers: Trending Products',
      'image': 'images/UM3GdWg.png',
      'description': 'Check out the top trending products of the season.',
      'price': 250.0,
    },
    {
      'name': 'Popular Products: Limited Edition',
      'image': 'images/5M89G2P.png',
      'description': 'Exclusive limited edition products just for you.',
      'price': 300.0,
    },
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),

    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Find the selected result
    final selectedResult =
    data.firstWhere((element) => element['name'].toLowerCase().contains(query.toLowerCase()), orElse: () => {});

    if (selectedResult.isEmpty) {
      return Center(
        child: Text("No product found!"),
      );
    }

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                selectedResult['image'],
                height: 200,
                width: 350,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 46),
            Text(
              selectedResult['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 28),
            Text(
              selectedResult['description'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Price: \$${selectedResult['price'].toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 26),
            ElevatedButton(
              onPressed: () {
                // Handle Add to Cart action
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${selectedResult['name']} added to cart!'),
                ));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Center(
                child: Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 18),
                ),
              ),

            ),

          ],

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

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? data.map((item) => item['name']).toList()
        : data
        .where((element) => element['name'].toLowerCase().contains(query.toLowerCase()))
        .map((item) => item['name'])
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}




