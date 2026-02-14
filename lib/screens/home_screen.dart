import 'package:flutter/material.dart';
import 'report_screen.dart';
import '../backend/debug_reports_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  const Row(
                    children: [
                      Icon(Icons.waves, color: Color(0xFFFF6D3B), size: 28), 
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ocean', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text('Eyes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(  0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.circle, color: Colors.green, size: 8),
                            SizedBox(width: 4),
                            Text('ONLINE', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEBE5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          '2 REPORTES\nPENDIENTES',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFFFF6D3B), fontSize: 9, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              
              const SizedBox(height: 30),

              GestureDetector(
                onLongPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DebugReportsScreen()),
                  );
                },
                child: const Text(
                  'Hola, Pescador ⛵',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFF1A1A1A)),
                ),
              ),

              const SizedBox(height: 20),

             /* _buildActionCard(
                color: const Color(0xFFFF6D3B),
                title: 'REPORTAR PESCA\nILEGAL',
                subtitle: 'Captura foto y envía',
                icon: Icons.emergency,
                actionIcon: Icons.camera_alt_outlined,
              ),
            */
              GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportDniScreen()),
                );
              },
              child: _buildActionCard(
                color: const Color(0xFFFF6D3B),
                title: 'REPORTAR PESCA\nILEGAL',
                subtitle: 'Captura foto y envía',
                icon: Icons.emergency,
                actionIcon: Icons.camera_alt_outlined,
              ),
            ),

              const SizedBox(height: 16),

              _buildActionCard(
                color: const Color(0xFF23768B),
                title: 'MEDIR CALIDAD DEL\nAGUA',
                subtitle: 'Conectar sensor Bluetooth',
                icon: Icons.water_drop, 
                actionIcon: Icons.bluetooth,
              ),

              const SizedBox(height: 30),

  
              const Text('Tu Actividad', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                 boxShadow: [
                    BoxShadow(color: Colors.black, 
                    blurRadius: 0.5)
                   
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatItem('8', 'REPORTES', Colors.orange),
                        _buildStatItem('6', 'VERIFICADOS', Colors.teal),
                        _buildStatItem('120', 'PUNTOS', Colors.black),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(height: 1, color: Colors.grey.shade100),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Nivel: Guardián del Mar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Icon(Icons.military_tech, color: Colors.orange),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 30),

              //Mapa
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(24),
                  image: const DecorationImage(
                    image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/USA_location_map.svg/1200px-USA_location_map.svg.png"), // Placeholder mapa
                    fit: BoxFit.cover,
                    opacity: 0.5,
                  ),
                ),
                child: Center(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.map, size: 18, color: Color(0xFFFF6D3B)),
                    label: const Text('Ver Mapa en Tiempo Real', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20), 
            ],
          ),
        ),
      ),
      
      // Barra de navegación
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFF6D3B),
        unselectedItemColor: Colors.grey.shade400,
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'INICIO'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'HISTORIAL'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'ZONAS'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'PERFIL'),
        ],
      ),
    );
  }

  // Estadísticas
  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade600, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Widget auxiliar para las tarjetas grandes de colores
  Widget _buildActionCard({
    required Color color,
    required String title,
    required String subtitle,
    required IconData icon,
    required IconData actionIcon,
  }) {
    return Container(
      height: 160,
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(28),

      ),
      child: Stack(
        children: [
          // Contenido Texto
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, height: 1.2),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(actionIcon, color: Colors.white, size: 24),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                ],
              )
            ],
          ),
          // Icono Decorativo en caja translúcida
          Positioned(
            right: 0,
            top: 10,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: Colors.white, size: 32),
            ),
          )
        ],
      ),
    );
  }
}