import 'package:flutter/material.dart';
import 'api_service.dart';

class FinalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final price = arguments['price'];
    final config = arguments['config'];
    final cpu = arguments['cpu'];
    final gpu = arguments['gpu'];

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text(
          'Configuration',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Verdana',
          ),
        ),
        backgroundColor: Colors.grey[900],
        iconTheme: IconThemeData(
          color: Colors.purpleAccent,
        ),
      ),
      body: FutureBuilder(
        future: ApiService.getBuildDetails(price, config, cpu, gpu),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white70)));
          } else if (snapshot.hasData) {
            final buildDetails = snapshot.data!;
            return ListView(
              children: [
                _buildComponentCard('CPU', buildDetails['cpu']),
                _buildComponentCard('GPU', buildDetails['gpu']),
                _buildComponentCard('Motherboard', buildDetails['motherboard']),
                _buildComponentCard('RAM', buildDetails['ram']),
                _buildComponentCard('Storage (ROM)', buildDetails['rom']),
                _buildComponentCard('Power Supply (PSU)', buildDetails['psu']),
                SizedBox(height: 20),
                _buildOtherInfo(buildDetails['other']),
                _buildTotalPrice(buildDetails['price']),
              ],
            );
          } else {
            return Center(child: Text('No data available', style: TextStyle(color: Colors.white70)));
          }
        },
      ),
    );
  }

  Widget _buildComponentCard(String componentName, Map<String, dynamic> componentDetails) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.grey[850],
      child: ListTile(
        title: Text(
          componentName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.purpleAccent,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${componentDetails['name']}', style: TextStyle(color: Colors.white)),

            if (componentName == 'CPU') ...[
              Text('Socket: ${componentDetails['socket']}', style: TextStyle(color: Colors.white70)),
              Text('Cores: ${componentDetails['cores']}', style: TextStyle(color: Colors.white70)),
              Text('TDP: ${componentDetails['tdp']} W', style: TextStyle(color: Colors.white70)),
            ],

            if (componentName == 'GPU') ...[
              Text('2D Benchmark: ${componentDetails['bench2d']}', style: TextStyle(color: Colors.white70)),
              Text('3D Benchmark: ${componentDetails['bench3d']}', style: TextStyle(color: Colors.white70)),
              Text('TDP: ${componentDetails['tdp']} W', style: TextStyle(color: Colors.white70)),
            ],

            if (componentName == 'Motherboard') ...[
              Text('Chipset: ${componentDetails['chipset']}', style: TextStyle(color: Colors.white70)),
              Text('Form Factor: ${componentDetails['form']}', style: TextStyle(color: Colors.white70)),
              Text('Max RAM: ${componentDetails['maxRam']} GB', style: TextStyle(color: Colors.white70)),
              Text('RAM Slots: ${componentDetails['ramSlots']}', style: TextStyle(color: Colors.white70)),
              Text('RAM Frequency: ${componentDetails['ramFreq']} MHz', style: TextStyle(color: Colors.white70)),
              Text('Socket: ${componentDetails['socket']}', style: TextStyle(color: Colors.white70)),
            ],

            if (componentName == 'RAM') ...[
              Text('Capacity: ${componentDetails['capacity']} GB', style: TextStyle(color: Colors.white70)),
              Text('Frequency: ${componentDetails['freq']} MHz', style: TextStyle(color: Colors.white70)),
              Text('Form: ${componentDetails['form']}', style: TextStyle(color: Colors.white70)),
              Text('Type: ${componentDetails['type']}', style: TextStyle(color: Colors.white70)),
              Text('Timing: ${componentDetails['time']}', style: TextStyle(color: Colors.white70)),
            ],

            if (componentName == 'PSU') ...[
              Text('Power: ${componentDetails['power']} W', style: TextStyle(color: Colors.white70)),
              Text('Fan Size: ${componentDetails['fan']} mm', style: TextStyle(color: Colors.white70)),
              Text('Form: ${componentDetails['form']}', style: TextStyle(color: Colors.white70)),
              Text('GPU Pin: ${componentDetails['gpuPin']}', style: TextStyle(color: Colors.white70)),
              Text('Pin: ${componentDetails['pin']}', style: TextStyle(color: Colors.white70)),
            ],

            if (componentName == 'Storage (ROM)') ...[
              Text('Capacity: ${componentDetails['capacity']} GB', style: TextStyle(color: Colors.white70)),
              Text('Type: ${componentDetails['type']}', style: TextStyle(color: Colors.white70)),
              Text('Bench: ${componentDetails['bench']}', style: TextStyle(color: Colors.white70)),
            ],

            Text('Price: ${componentDetails['price']}₽', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildOtherInfo(double other) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.grey[850],
      child: ListTile(
        title: Text('Other Costs', style: TextStyle(color: Colors.purpleAccent)),
        subtitle: Text('Total: $other ₽', style: TextStyle(color: Colors.white70)),
      ),
    );
  }

  Widget _buildTotalPrice(double totalPrice) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.grey[850],
      child: ListTile(
        title: Text(
          'Total Price',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.purpleAccent),
        ),
        subtitle: Text(
          'Total: $totalPrice ₽',
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
