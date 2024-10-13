import 'package:data/pages/settingsPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
           DrawerHeader(
              child: Center(
                child: Text("Explore", style: GoogleFonts.dmSerifText(fontSize: 35,
                          color: Theme.of(context).colorScheme.inversePrimary),),
              )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.home,
                      color: Theme.of(context).colorScheme.inversePrimary),
                  title: Text("Notes", style: GoogleFonts.dmSerifText(fontSize: 20,
                      color: Theme.of(context).colorScheme.inversePrimary,
                   ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: Theme.of(context).colorScheme.inversePrimary),
                  title: Text("Settings", style: GoogleFonts.dmSerifText(fontSize: 20,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
                  },
                ),
              ],
            ),
          ),
        ],

      ),


    );
  }
}
