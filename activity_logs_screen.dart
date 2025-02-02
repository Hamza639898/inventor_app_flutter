import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'db_helper.dart';

class ActivityLogsScreen extends StatefulWidget {
  const ActivityLogsScreen({Key? key}) : super(key: key);

  @override
  State<ActivityLogsScreen> createState() => _ActivityLogsScreenState();
}

class _ActivityLogsScreenState extends State<ActivityLogsScreen> {
  List<Map<String, dynamic>> _logs = [];
  List<Map<String, dynamic>> _filteredLogs = [];
  final TextEditingController _searchController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _fetchLogs();
    _searchController.addListener(_filterLogs);
  }

  void _fetchLogs() async {
