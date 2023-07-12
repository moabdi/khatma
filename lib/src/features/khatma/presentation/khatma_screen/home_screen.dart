import 'package:flutter/material.dart';
import 'package:khatma/src/themes/theme.dart';

import 'package:khatma/src/features/khatma/domain/khatma.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SplitUnit _selectedSplitUnit = SplitUnit.HIZB;
  final bool _isPermanent = true;
  int? _value = 1;
  List<bool> _isSelected = [false, true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ToggleButtons(
              children: <Widget>[
                Text("Indivifual)"),
              ],
              isSelected: _isSelected,
              onPressed: (int index) {
                setState(() {
                  _isSelected[index] = !_isSelected[index];
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter the name of the Khatma',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                contentPadding: const EdgeInsets.all(15),
                filled: true,
                fillColor: HexColor("#F8F9FD"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter a description (optional)',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                contentPadding: const EdgeInsets.all(15),
                filled: true,
                fillColor: HexColor("#F8F9FD"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Choose an item'),
            const SizedBox(height: 10.0),
            Wrap(
              spacing: 5.0,
              children: List<Widget>.generate(
                SplitUnit.values.length,
                (int index) {
                  return FilterChip(
                    label: Text(
                        '${SplitUnit.values[index].name} (${SplitUnit.values[index].count})'),
                    selected: _value == SplitUnit.values[index].index,
                    onSelected: (bool selected) {
                      setState(() {
                        _value =
                            selected ? SplitUnit.values[index].index : null;
                      });
                    },
                  );
                },
              ).toList(),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Ramadan'),
              subtitle: Text("khatma ramadania"),
              onTap: () => _showSplitUnitModal(context),
              trailing: Icon(Icons.arrow_drop_down),
            ),
            Container(
              height: 130,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: HexColor("#F8F9FD"),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Khatma Unit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    ListTile(
                      title: Text('Ramadan'),
                      subtitle: Text("khatma ramadania"),
                      onTap: () => _showSplitUnitModal(context),
                      trailing: Icon(Icons.arrow_drop_down),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSplitUnitModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      useSafeArea: true,
      elevation: 2,
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Split Unit',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text('Hizb'),
              leading: Radio(
                value: SplitUnit.HIZB,
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
                value: SplitUnit.JUZZ,
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
        );
      },
    );
  }
}
