import 'package:flutter/material.dart';
import 'basedato_helper.dart'; 

class DebugReportsScreen extends StatefulWidget {
  const DebugReportsScreen({super.key});

  @override
  State<DebugReportsScreen> createState() => _DebugReportsScreenState();
}

class _DebugReportsScreenState extends State<DebugReportsScreen> {
  // Variable para guardar la lista de datos
  late Future<List<Map<String, dynamic>>> _reportsList;

  @override
  void initState() {
    super.initState();
    _refreshReports();
  }

  void _refreshReports() {
    setState(() {
      _reportsList = DatabaseHelper.instance.getReports();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Base de Datos (Debug)'),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshReports, // Botón para recargar la lista
          )
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _reportsList,
        builder: (context, snapshot) {
          // 1. Si está cargando
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2. Si hubo error
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // 3. Si no hay datos
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay reportes guardados aún.'));
          }

          // 4. Si hay datos, mostramos la lista
          final reports = snapshot.data!;
          
          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: report['is_anonymous'] == 1 ? Colors.grey : Colors.orange,
                    child: Icon(
                      report['is_anonymous'] == 1 ? Icons.visibility_off : Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  title: Text("DNI: ${report['dni']}"),
                  subtitle: Text("Fecha: ${report['created_at']}\nID: ${report['id']}"),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}