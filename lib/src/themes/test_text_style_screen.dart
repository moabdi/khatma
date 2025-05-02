import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 72.0,
            fontWeight: FontWeight.w900,
            fontFamily: 'SFProDisplay',
            color: Colors.deepPurple,
          ),
          displayMedium: TextStyle(
            fontSize: 60.0,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.normal,
            fontFamily: 'SFProDisplay',
            color: Colors.purple,
          ),
          displaySmall: TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'SFProDisplay',
            color: Colors.purple,
          ),
          headlineLarge: TextStyle(
            fontSize: 36.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
            fontFamily: 'SFProText',
            color: Colors.black,
          ),
          headlineMedium: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'SFProDisplay',
            color: Colors.black,
            wordSpacing: 0.5,
          ),
          headlineSmall: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'SFProDisplay',
            color: Colors.black,
          ),
          titleLarge: TextStyle(
            fontSize: 21.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'SFProDisplay',
            wordSpacing: 0.5,
          ),
          titleMedium: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'SFProDisplay',
            wordSpacing: 0.5,
          ),
          titleSmall: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'SFProDisplay',
            wordSpacing: 0.5,
          ),
          bodyLarge: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            fontFamily: 'SFProText',
          ),
          bodyMedium: TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w400,
            fontFamily: 'SFProText',
          ),
          bodySmall: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'SFProText',
          ),
          labelLarge: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            fontFamily: 'SFProText',
          ),
          labelMedium: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'SFProText',
          ),
          labelSmall: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'SFProText',
            wordSpacing: 0.5,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Typography Demo'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Display Large',
                  style: Theme.of(context).textTheme.displayLarge),
              Text('Display Medium',
                  style: Theme.of(context).textTheme.displayMedium),
              Text('Display Small',
                  style: Theme.of(context).textTheme.displaySmall),
              Text('Headline Large',
                  style: Theme.of(context).textTheme.headlineLarge),
              Text('Headline Medium',
                  style: Theme.of(context).textTheme.headlineMedium),
              Text('Headline Small',
                  style: Theme.of(context).textTheme.headlineSmall),
              Text('Title Large',
                  style: Theme.of(context).textTheme.titleLarge),
              Text('Title Medium',
                  style: Theme.of(context).textTheme.titleMedium),
              Text('Title Small',
                  style: Theme.of(context).textTheme.titleSmall),
              Text('Body Large', style: Theme.of(context).textTheme.bodyLarge),
              Text('Body Medium',
                  style: Theme.of(context).textTheme.bodyMedium),
              Text('Body Small', style: Theme.of(context).textTheme.bodySmall),
              Text('Label Large',
                  style: Theme.of(context).textTheme.labelLarge),
              Text('Label Medium',
                  style: Theme.of(context).textTheme.labelMedium),
              Text('Label Small',
                  style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
        ),
      ),
    );
  }
}
