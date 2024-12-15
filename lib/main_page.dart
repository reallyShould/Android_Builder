import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _priceController = TextEditingController();
  String? _config;
  String? _cpu;
  String? _gpu;
  String? _mode;

  String _main_label_text = '';
  String _author_text = '';
  String _dropdown_price_text = '';
  String _dropdown_conf_text = '';
  String _dropdown_cpu_text = '';
  String _dropdown_gpu_text = '';
  String _dropdown_mode_text = '';
  String _error_fields_text = '';
  String _button_build_text = '';
  String _label_about_text = '';
  String _label_about_body_text = '';

  @override
  void initState() {
    super.initState();
    loadText();
  }

  Future<void> loadText() async {
    final String response = await rootBundle.loadString('assets/text.json');
    final data = json.decode(response);

    setState(() {
      _main_label_text = data['main_label'];
      _author_text = data['author_label'];
      _dropdown_price_text = data['dropdown_price_text'];
      _dropdown_conf_text = data['dropdown_conf_text'];
      _dropdown_cpu_text = data['dropdown_cpu_text'];
      _dropdown_gpu_text = data['dropdown_gpu_text'];
      _dropdown_mode_text = data['dropdown_mode_text'];
      _error_fields_text = data['error_fields_text'];
      _button_build_text = data['button_build_text'];
      _label_about_text = data['label_about_text'];
      _label_about_body_text = data['label_about_body_text'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _main_label_text,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Verdana',
                    ),
                  ),
                  Text(
                    _author_text,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontFamily: 'Verdana',
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Price Field
            TextField(
              controller: _priceController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: _dropdown_price_text,
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.grey[800],
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 10),

            // Configuration Dropdown
            DropdownButton<String>(
              isExpanded: true,
              value: _config,
              hint: Text(
                _dropdown_conf_text,
                style: TextStyle(color: Colors.white),
              ),
              onChanged: (newValue) {
                setState(() {
                  _config = newValue;
                });
              },
              dropdownColor: Colors.grey[800],
              items: <String>['Gaming', 'Working', 'Graphics']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.white)),
                );
              }).toList(),
            ),

            SizedBox(height: 10),

            // CPU Dropdown
            DropdownButton<String>(
              isExpanded: true,
              value: _cpu,
              hint: Text(
                _dropdown_cpu_text,
                style: TextStyle(color: Colors.white),
              ),
              onChanged: (newValue) {
                setState(() {
                  _cpu = newValue;
                });
              },
              dropdownColor: Colors.grey[800],
              items: <String>['INTEL', 'AMD', "Any"]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.white)),
                );
              }).toList(),
            ),

            SizedBox(height: 10),

            // GPU Dropdown
            DropdownButton<String>(
              isExpanded: true,
              value: _gpu,
              hint: Text(
                _dropdown_gpu_text,
                style: TextStyle(color: Colors.white),
              ),
              onChanged: (newValue) {
                setState(() {
                  _gpu = newValue;
                });
              },
              dropdownColor: Colors.grey[800],
              items: <String>['NVIDIA', 'AMD', "Any"]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.white)),
                );
              }).toList(),
            ),

            DropdownButton<String>(
              isExpanded: true,
              value: _mode,
              hint: Text(
                _dropdown_mode_text,
                style: TextStyle(color: Colors.white),
              ),
              onChanged: (newValue) {
                setState(() {
                  _mode = newValue;
                });
              },
              dropdownColor: Colors.grey[800],
              items: <String>['Best', 'Best of seven']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.white)),
                );
              }).toList(),
            ),

            SizedBox(height: 10),

            // Start Button
            ElevatedButton(
              onPressed: () {
                if (_priceController.text.isNotEmpty &&
                    _config != null &&
                    _cpu != null &&
                    _gpu != null) {
                  // Navigate to the final page with the arguments
                  Navigator.pushNamed(
                    context,
                    '/final',
                    arguments: {
                      'price': _priceController.text,
                      'config': _config,
                      'cpu': _cpu,
                      'gpu': _gpu,
                      'mode': _mode,
                    },
                  );
                } else {
                  // Show a message if fields are not filled
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(_error_fields_text)),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.grey[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                elevation: 0,
              ),
              child: Text(
                _button_build_text,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Verdana',
                ),
              ),
            ),

            SizedBox(height: 40),

            // About Section
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _label_about_text,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Verdana',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _label_about_body_text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontFamily: 'Verdana',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
