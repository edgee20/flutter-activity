import 'dart:convert'; // Provides JSON encoding and decoding functions
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Provides access to platform services like loading assets

/// ProductsScreen - Fourth Screen (JSON Data Implementation)
///
/// PURPOSE:
/// This screen demonstrates loading and displaying data from a local JSON file.
/// It shows how to:
/// 1. Load JSON data from assets folder
/// 2. Parse JSON into Dart objects
/// 3. Display data in a GridView with responsive design
/// 4. Handle loading states and errors
///
/// NAVIGATION:
/// - Reached via push() from Dashboard
/// - Users can pop() back using back button
/// - Each product card can navigate to detail screen (future implementation)
class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  /// List to store parsed product data
  /// Initially empty, filled after loading JSON
  List<dynamic> _products = [];

  /// Boolean flag to track loading state
  /// true: data is being loaded
  /// false: data loading complete
  bool _isLoading = true;

  /// String to store error message if loading fails
  String _errorMessage = '';

  /// Selected category for filtering products
  /// 'All' shows all products, other values filter by category
  String _selectedCategory = 'All';

  /// List of available categories for filter
  /// First item is 'All' to show all products
  final List<String> _categories = [
    'All',
    'Technology',
    'Arts',
    'Business',
    'Sports',
    'Music',
    'Science',
    'Personal Development',
  ];

  /// initState() called once when widget is first created
  /// Perfect place to load data that's needed immediately
  @override
  void initState() {
    super.initState();

    /// Load product data as soon as screen is created
    _loadProductData();
  }

  /// Asynchronous function to load and parse JSON data
  ///
  /// ASYNC/AWAIT EXPLAINED:
  /// - async: marks function as asynchronous (can perform time-consuming operations)
  /// - await: pauses execution until the operation completes
  /// - This prevents UI from freezing while loading data
  Future<void> _loadProductData() async {
    try {
      /// setState() tells Flutter to rebuild widget with new data
      /// Always wrap state changes in setState()
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      /// LOADING JSON FROM ASSETS:
      /// 1. rootBundle.loadString() reads file as string
      /// 2. 'assets/data/products.json' is the file path
      /// 3. Must be declared in pubspec.yaml assets section
      /// 4. await pauses until file is fully loaded
      final String jsonString = await rootBundle.loadString(
        'assets/data/products.json',
      );

      /// PARSING JSON:
      /// 1. json.decode() converts JSON string to Dart Map/List
      /// 2. Returns a Map<String, dynamic> for JSON objects
      /// 3. Access nested data using bracket notation: data['products']
      final Map<String, dynamic> data = json.decode(jsonString);

      /// ERROR HANDLING:
      /// Check if 'products' key exists in JSON
      /// Prevents crashes if JSON structure is incorrect
      if (data.containsKey('products')) {
        setState(() {
          /// Extract products array from JSON
          _products = data['products'];
          _isLoading = false;
        });
      } else {
        throw Exception('Invalid JSON structure: products key not found');
      }
    } catch (e) {
      /// CATCH BLOCK:
      /// Catches any errors during loading or parsing
      /// Common errors: file not found, invalid JSON format, network issues
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error loading products: $e';
      });

      /// Show user-friendly error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load products: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  /// Filter products based on selected category
  /// Returns filtered list of products
  List<dynamic> _getFilteredProducts() {
    if (_selectedCategory == 'All') {
      return _products;
    }

    /// where() filters list based on condition
    /// Only products matching selected category are returned
    return _products
        .where((product) => product['category'] == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    /// Get screen dimensions for responsive design
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Events & Workshops',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          /// Refresh button to reload data
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadProductData,
            tooltip: 'Refresh data',
          ),
        ],
      ),

      body: Column(
        children: [
          /// Category filter section
          _buildCategoryFilter(),

          /// Main content area with conditional rendering
          Expanded(child: _buildContent(screenWidth)),
        ],
      ),
    );
  }

  /// Builds horizontal scrolling category filter
  Widget _buildCategoryFilter() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category;
                });
              },
              selectedColor: Theme.of(context).primaryColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }

  /// Builds main content with conditional rendering based on state
  ///
  /// CONDITIONAL RENDERING:
  /// Shows different widgets based on loading state and data availability
  Widget _buildContent(double screenWidth) {
    /// LOADING STATE: Show circular progress indicator
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              'Loading products...',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    /// ERROR STATE: Show error message with retry button
    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
              const SizedBox(height: 20),
              Text(
                _errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _loadProductData,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    /// EMPTY STATE: Show message when no products found
    final filteredProducts = _getFilteredProducts();
    if (filteredProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 20),
            Text(
              'No products found in this category',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    /// SUCCESS STATE: Show products in grid
    return _buildProductGrid(filteredProducts, screenWidth);
  }

  /// Builds responsive grid of products
  ///
  /// RESPONSIVE GRID:
  /// - Phone (< 600px): 1 column
  /// - Tablet (600-900px): 2 columns
  /// - Desktop (> 900px): 3 columns
  Widget _buildProductGrid(List<dynamic> products, double screenWidth) {
    /// Determine number of columns based on screen width
    int crossAxisCount = 1;
    if (screenWidth > 900) {
      crossAxisCount = 3;
    } else if (screenWidth > 600) {
      crossAxisCount = 2;
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),

      /// itemCount: number of items to display
      itemCount: products.length,

      /// gridDelegate: controls grid layout
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,

        /// childAspectRatio: width/height ratio for each item
        childAspectRatio: 0.75,
      ),

      /// itemBuilder: called for each item in grid
      /// Must return widget for that index
      itemBuilder: (context, index) {
        final product = products[index];
        return _buildProductCard(product);
      },
    );
  }

  /// Builds individual product card
  ///
  /// ACCESSING JSON DATA:
  /// Use bracket notation to access JSON properties
  /// Example: product['name'] gets the 'name' property
  Widget _buildProductCard(Map<String, dynamic> product) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          /// TODO (Act #8): Navigate to product detail screen
          /// This will use push() to show detailed view
          _showProductDetails(product);
        },
        borderRadius: BorderRadius.circular(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product image placeholder
            /// In real app, this would load actual image
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
                gradient: LinearGradient(
                  colors: [
                    _getCategoryColor(product['category']).withOpacity(0.7),
                    _getCategoryColor(product['category']),
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  _getCategoryIcon(product['category']),
                  size: 64,
                  color: Colors.white,
                ),
              ),
            ),

            /// Product information section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Product name
                    Text(
                      product['name'] ?? 'Unknown',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    /// Category badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(
                          product['category'],
                        ).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        product['category'] ?? 'General',
                        style: TextStyle(
                          fontSize: 12,
                          color: _getCategoryColor(product['category']),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    /// Rating and students count
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '${product['rating'] ?? 0}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.people, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${product['students'] ?? 0}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const Spacer(),

                    /// Price
                    Text(
                      product['price'] == 0
                          ? 'FREE'
                          : '₱${product['price'].toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: product['price'] == 0
                            ? Colors.green
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Shows detailed product information in a dialog
  void _showProductDetails(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(product['name'] ?? 'Product Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Category', product['category']),
              _buildDetailRow('Instructor', product['instructor']),
              _buildDetailRow('Duration', product['duration']),
              _buildDetailRow('Rating', '${product['rating']} ⭐'),
              _buildDetailRow('Students', '${product['students']}'),
              _buildDetailRow(
                'Price',
                product['price'] == 0
                    ? 'FREE'
                    : '₱${product['price'].toStringAsFixed(2)}',
              ),
              const SizedBox(height: 12),
              const Text(
                'Description:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(product['description'] ?? 'No description available'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Enrolled in: ${product['name']}'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Enroll Now'),
          ),
        ],
      ),
    );
  }

  /// Helper widget to build detail row
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  /// Returns color based on category
  Color _getCategoryColor(String? category) {
    switch (category) {
      case 'Technology':
        return Colors.blue;
      case 'Arts':
        return Colors.purple;
      case 'Business':
        return Colors.green;
      case 'Sports':
        return Colors.orange;
      case 'Music':
        return Colors.pink;
      case 'Science':
        return Colors.teal;
      case 'Personal Development':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }

  /// Returns icon based on category
  IconData _getCategoryIcon(String? category) {
    switch (category) {
      case 'Technology':
        return Icons.computer;
      case 'Arts':
        return Icons.palette;
      case 'Business':
        return Icons.business_center;
      case 'Sports':
        return Icons.sports_basketball;
      case 'Music':
        return Icons.music_note;
      case 'Science':
        return Icons.science;
      case 'Personal Development':
        return Icons.psychology;
      default:
        return Icons.event;
    }
  }
}
