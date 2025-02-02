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

  void _showForm({Map<String, dynamic>? item}) {
    final nameController = TextEditingController(text: item?['name']);
    final quantityController = TextEditingController(text: item?['quantity']?.toString());
    final priceController = TextEditingController(text: item?['price']?.toString());
    final dateController = TextEditingController(text: item?['date']);
    final deliverToController = TextEditingController(text: item?['deliverTo']);
    final inController = TextEditingController(text: item?['in']?.toString());
    final outController = TextEditingController(text: item?['out']?.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item == null ? 'Create New Item' : 'Edit Item'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: dateController,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Date'),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                    });
                  }
                },
              ),
              TextField(
                controller: deliverToController,
                decoration: const InputDecoration(labelText: 'Deliver To'),
              ),
              TextField(
                controller: inController,
                decoration: const InputDecoration(labelText: 'In'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: outController,
                decoration: const InputDecoration(labelText: 'Out'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),