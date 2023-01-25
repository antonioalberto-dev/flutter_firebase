import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/list_patient.dart';

class ItemMenu extends StatefulWidget {
  final Widget router;
  final String title;
  final IconData icon;
  final Color color;

  ItemMenu({
    required this.router,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  State<ItemMenu> createState() => _ItemMenuState();
}

class _ItemMenuState extends State<ItemMenu> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => widget.router),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, bottom: 5),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(20),
          ),
        ),
        child: ListTile(
          leading: Icon(
            widget.icon,
            size: 30,
          ),
          iconColor: Colors.white,
          titleTextStyle: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
          title: Text(
            widget.title,
          ),
        ),
      ),
    );
  }
}
