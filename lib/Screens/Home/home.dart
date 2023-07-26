import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp/Components/buttons.dart';
import 'package:whatsapp/Components/text_style.dart';
import 'package:whatsapp/Theme/custom_theme.dart';

import 'chats.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: context.theme.background,
          title: const CustomText(
            title: "WhatsApp",
            color: Colors.white,
            size: 20,
            weight: FontWeight.bold,
          ),
          actions: [
            CustomIconButton(onPressed: () {}, icon: Icons.camera_alt_outlined),
            CustomIconButton(onPressed: () {}, icon: Icons.search),
            CustomIconButton(onPressed: () {}, icon: Icons.more_vert),
          ],
          bottom: TabBar(
            labelStyle: GoogleFonts.varelaRound(),
            tabs: const [
              Tab(text: "Chats"),
              Tab(text: "Status"),
              Tab(text: "Calls"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Chats(),
            Text("Status"),
            Text("Calls"),
          ],
        ),
      ),
    );
  }
}
