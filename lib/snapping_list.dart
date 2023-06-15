import 'package:flutter/material.dart';

class SnappingList extends StatefulWidget {
  const SnappingList({
    Key? key,
    required this.selectedColor,
  }) : super(key: key);
  final Color selectedColor;
  @override
  SnappingListState createState() => SnappingListState();
}

class SnappingListState extends State<SnappingList> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 120, left: 16, right: 16),
      child: Center(
        child: SizedBox(
          height: 55, // card height
          child: PageView.builder(
            itemCount: 7,
            controller: PageController(viewportFraction: 0.15),
            onPageChanged: (int index) => setState(() => _index = index),
            itemBuilder: (_, i) {
              return Transform.scale(
                scale: i == _index ? 1 : 0.6,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    border: Border.all(
                      width: (i == _index ? 2 : 0),
                      color: widget.selectedColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/${i + 1}.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
