import 'package:flutter/material.dart';
import 'package:vivo_registry/constants.dart';

class BottomNav extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChangedTab;

  const BottomNav({Key? key, required this.index, required this.onChangedTab})
      : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: white,
      shape: CircularNotchedRectangle(),
      notchMargin: 6,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        buildTabItem(index: 0, icon: Icon(Icons.home)),
        buildTabItem(index: 1, icon: Icon(Icons.view_list)),
        Opacity(
            opacity: 0,
            child: IconButton(onPressed: () {}, icon: Icon(Icons.nat))),
        buildTabItem(index: 2, icon: Icon(Icons.query_stats)),
        buildTabItem(index: 3, icon: Icon(Icons.person)),
      ]),
    );
  }

  Widget buildTabItem({required int index, required Icon icon}) {
    final isSelected = index == widget.index;
    return IconTheme(
      data: IconThemeData(color: isSelected ? themeBT : Colors.black),
      child:
          IconButton(onPressed: () => widget.onChangedTab(index), icon: icon),
    );
  }
}
