import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/features/khatma/enums/khatma_enums.dart';
import 'package:khatma/src/themes/theme.dart';

class AddKhatmaScreen extends StatefulWidget {
  @override
  State<AddKhatmaScreen> createState() => _AddKhatmaScreenState();
}

class _AddKhatmaScreenState extends State<AddKhatmaScreen> {
  SplitUnit _selectedSplitUnit = SplitUnit.hizb;
  KhatmaType _selectedKhatmaType = KhatmaType.monthly;
  bool _isPermanent = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Add Khatma',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              gapH20,
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter the name of the Khatma',
                ),
              ),
              gapH20,
              const TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Enter a description (optional)',
                ),
              ),
              ListTile(
                title: Text('Hizb'),
                subtitle: Text("60 Hizb"),
                onTap: () => _showSplitUnitModal(context),
                trailing: Icon(Icons.arrow_drop_down),
              ),
              gapH20,
              gapH20,
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Khatma Type',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ListTile(
                      title: Text('Ramadan'),
                      subtitle: Text("khatma ramadania"),
                      onTap: () => _showSplitUnitModal(context),
                      trailing: Icon(Icons.arrow_drop_down),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.0),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Permanent',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    SwitchListTile(
                      value: true,
                      onChanged: (value) {
                        // handle the switch value change here
                      },
                      activeColor: CupertinoColors.activeGreen,
                      secondary: const Icon(Icons.repeat),
                      title: const Text('Renew Khatma'),
                      subtitle: Text("data"),
                    )
                  ],
                ),
              ),
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }

  void _showSplitUnitModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Text(
                  'Select Split Unit',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text('Hizb'),
                leading: Radio(
                  value: SplitUnit.hizb,
                  groupValue: _selectedSplitUnit,
                  onChanged: (value) {
                    setState(() {
                      _selectedSplitUnit = value!;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: Text('Juzz'),
                leading: Radio(
                  value: SplitUnit.juzz,
                  groupValue: _selectedSplitUnit,
                  onChanged: (value) {
                    setState(() {
                      _selectedSplitUnit = value!;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
