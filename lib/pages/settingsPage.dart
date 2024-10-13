import 'package:data/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
                color:  Theme.of(context).colorScheme.primary,
          ),
          child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text("Change Mode", style: TextStyle(fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
                ),
                ),
                CupertinoSwitch(
                    value:
                    Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
                    onChanged: (value) =>
                        Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                )
              ],
          ),
        ),
      ),
    );
  }
}
