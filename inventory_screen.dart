import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db_helper.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  List<Map<String, dynamic>> _inventoryItems = [];
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _refreshInventory();
  }

  void _refreshInventory() async {
    final data = await DBHelper().getItems();
    setState(() {
      _inventoryItems = data;
    });
  }

  void _showDeleteConfirmationDialog(int itemId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await DBHelper().deleteItem(itemId);
              _refreshInventory();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Item deleted successfully')),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

 