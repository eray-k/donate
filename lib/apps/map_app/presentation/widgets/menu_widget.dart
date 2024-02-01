import 'package:flutter/material.dart';

class FoldableMenu extends StatefulWidget {
  const FoldableMenu({super.key, required this.onBackPressed});
  final Function() onBackPressed;
  @override
  State<FoldableMenu> createState() => _FoldableMenuState();
}

class _FoldableMenuState extends State<FoldableMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
          width: 230,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: widget.onBackPressed,
                ),
                TextButton.icon(
                    icon: const Icon(Icons.person),
                    onPressed: () {},
                    label: const Text(
                      'My Information',
                    )),
                TextButton.icon(
                    icon: const Icon(Icons.list),
                    onPressed: () {},
                    label: const Text(
                      'List View',
                    )),
                TextButton.icon(
                    icon: const Icon(Icons.map),
                    onPressed: () {},
                    label: const Text(
                      'Map View',
                    )),
                TextButton.icon(
                    icon: const Icon(Icons.help),
                    onPressed: () {},
                    label: const Text(
                      'Help',
                    )),
              ],
            ),
          )),
    );
  }
}
