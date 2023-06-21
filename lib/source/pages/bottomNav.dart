import 'package:batubara/source/pages/Batubara/batubara.dart';
import 'package:batubara/source/pages/history/history.dart';
import 'package:batubara/source/widget/color.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const [Batubara(), History()].elementAt(index),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: merah,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white70,
        selectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(fontSize: 15, color: Colors.white),
        unselectedLabelStyle: TextStyle(fontSize: 14, color: Colors.white70),
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            activeIcon: Icon(Icons.calculate, color: Colors.white),
            label: 'Perhitungan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            activeIcon: Icon(Icons.history, color: Colors.white),
            label: 'Riwayat',
          ),
        ],
      ),
    );
  }
}
