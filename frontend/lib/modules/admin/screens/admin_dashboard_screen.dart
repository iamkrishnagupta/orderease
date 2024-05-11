import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ChartModel {
  final String date;
  final int income;

  ChartModel({required this.date, required this.income});

  factory ChartModel.fromJson(Map<String, dynamic> json) {
    return ChartModel(
      date: json['date'] as String,
      income: json['income'] as int,
    );
  }
}

Future<List<ChartModel>> fetchChartData() async {
  final response =
      await http.get(Uri.parse('${GlobalVariables.baseUrl}/api/chartdata'));
  if (response.statusCode == 200) {
    final List jsonResponse = json.decode(response.body) as List;
    return jsonResponse
        .map((data) => ChartModel.fromJson(data as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Failed to load chart data: ${response.statusCode}');
  }
}

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  late Future<List<ChartModel>> _futureChartData;

  @override
  void initState() {
    super.initState();
    _futureChartData = fetchChartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Income Chart'),
               backgroundColor: GlobalVariables.purple,

      ),
      body: FutureBuilder<List<ChartModel>>(
        future: _futureChartData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildChart(snapshot.data!),
                ),
                Expanded(
                  flex: 1,
                  child: _buildList(snapshot.data!),
                ),
              ],
            );
          } else {
            return const Text('No data available');
          }
        },
      ),
    );
  }

  Widget _buildChart(List<ChartModel> data) {
    List<charts.Series<ChartModel, String>> series = [
      charts.Series(
        id: "Income",
        data: data,
        domainFn: (ChartModel series, _) =>
            DateFormat('dd-MM-yyyy').format(DateTime.parse(series.date)),
        measureFn: (ChartModel series, _) => series.income,
        colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
      ),
    ];

    return charts.BarChart(
      series,
      animate: true,
    );
  }

  Widget _buildList(List<ChartModel> data) {
    return ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        DateTime dateTime = DateTime.parse(item.date);
        String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
        return ListTile(
          title: Text(formattedDate),
          subtitle: Text('Income: ₹${item.income}'),
        );
      },
    );
  }
}
