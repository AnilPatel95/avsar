import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final List<String> items;
  final Function(String) onItemSelected;

  CustomBottomSheet({
    required this.title,
    required this.items,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child:Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
          ),
            SizedBox(height: 20),
            // List of selectable items
            Container(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(items[index]),
                    onTap: () {
                      // Handle item selection here
                      onItemSelected(items[index]);
                      Navigator.of(context).pop(); // Close the BottomSheet
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            // Close button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the BottomSheet
              },
              child: Text('Close'),
            ),
        ],
      ),
    );
  }
}
