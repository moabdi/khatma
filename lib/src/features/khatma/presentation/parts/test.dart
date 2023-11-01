import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Mettre à niveau button
              ElevatedButton(
                onPressed: () {
                  // Add your action here
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Background color
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.upgrade_rounded),
                    SizedBox(width: 8.0), // Space between icon and text
                    Text('Mettre à niveau'),
                  ],
                ),
              ),

              SizedBox(width: 20.0), // Space between the two buttons

              // Inviter des amis button
              OutlinedButton(
                onPressed: () {
                  // Add your action here
                },
                child: Row(
                  children: [
                    Icon(Icons.favorite_border),
                    SizedBox(width: 8.0), // Space between icon and text
                    Text('Inviter des amis'),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                  primary: Colors.blue, // Text color
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  side: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
