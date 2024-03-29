import 'package:flutter/material.dart';
import 'package:toktok/Components/tab_grid.dart';
import 'package:toktok/Theme/colors.dart';

class Audio extends StatelessWidget {
  final List<String> dance = [
    'assets/thumbnails/dance/Layer 951.png',
    'assets/thumbnails/dance/Layer 952.png',
    'assets/thumbnails/dance/Layer 953.png',
    'assets/thumbnails/dance/Layer 954.png',
    'assets/thumbnails/dance/Layer 951.png',
    'assets/thumbnails/dance/Layer 952.png',
    'assets/thumbnails/dance/Layer 953.png',
    'assets/thumbnails/dance/Layer 954.png',
    'assets/thumbnails/dance/Layer 951.png',
    'assets/thumbnails/dance/Layer 952.png',
    'assets/thumbnails/dance/Layer 953.png',
    'assets/thumbnails/dance/Layer 954.png',
    'assets/thumbnails/dance/Layer 951.png',
    'assets/thumbnails/dance/Layer 952.png',
    'assets/thumbnails/dance/Layer 953.png',
    'assets/thumbnails/dance/Layer 954.png',
  ];
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: darkColor,
      appBar: AppBar(
        title: const Text("Audio"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(20),
            leading: Image.asset('assets/thumbnails/dance/Layer 954.png'),
            title: Text(
              "Dance on Heaven",
              style: TextStyle(color: secondaryColor),
            ),
            subtitle: const Text("James Carlo"),
            trailing: Icon(
              Icons.bookmark_border,
              color: secondaryColor,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12), topLeft: Radius.circular(12)),
              color: backgroundColor,
            ),
            child: Text(
              '1.1 M Videos using this audio',
              style: theme.textTheme.labelLarge!.copyWith(fontSize: 14),
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                TabGrid(
                  [],
                  showView: true,
                  viewIcon: Icons.remove_red_eye,
                  onTap: () {},
                ),
                Container(
                  width: 134,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: theme.primaryColor,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera_alt_sharp,
                        color: secondaryColor,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        "User Audio",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
