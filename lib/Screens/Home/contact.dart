import 'package:flutter/material.dart';

import '../../Components/tabs.dart';
import '/Components/text_style.dart';
import '../../Components/buttons.dart';
import '/Theme/custom_theme.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: context.theme.background,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CustomText(
                title: "Select contact",
                color: Colors.white,
                size: 20,
                weight: FontWeight.bold,
              ),
              CustomText(
                title: "contacts",
                color: Colors.white,
                size: 12,
              ),
            ],
          ),
          actions: [
            CustomIconButton(onPressed: () {}, icon: Icons.search),
            CustomIconButton(onPressed: () {}, icon: Icons.more_vert),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              CustomTab(
                onPressed: () {},
                title: "New group",
                icon: Icons.people,
              ),
              CustomTab(
                onPressed: () {},
                title: "New contact",
                icon: Icons.person_add,
              )
            ],
          ),
        ));
  }
}
