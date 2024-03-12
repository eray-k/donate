import 'package:flutter/material.dart';

class FoldableMenu extends StatefulWidget {
  const FoldableMenu({super.key, required this.onBackPressed});
  final Function() onBackPressed;
  @override
  State<FoldableMenu> createState() => _FoldableMenuState();
}

class _FoldableMenuState extends State<FoldableMenu> {
  final style = TextButton.styleFrom(
      foregroundColor: Colors.black.withOpacity(0.7),
      minimumSize: const Size.fromHeight(0),
      alignment: AlignmentDirectional.centerStart,
      textStyle: const TextStyle(fontSize: 20));
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
                  onPressed: () {
                    Navigator.of(context).pushNamed('/account');
                  },
                  label: const Text(
                    'My Information',
                  ),
                  style: style,
                ),
                TextButton.icon(
                  icon: const Icon(Icons.list),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/list');
                  },
                  label: const Text(
                    'List View',
                  ),
                  style: style,
                ),
                TextButton.icon(
                  icon: const Icon(Icons.help),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/about');
                  },
                  label: const Text(
                    'About',
                  ),
                  style: style,
                ),
              ],
            ),
          )),
    );
  }
}
