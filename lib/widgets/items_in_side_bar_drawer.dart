import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:instant_api_news_app/main.dart';
import 'package:instant_api_news_app/singleton/shared_prefernces.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ItemsInSideBarDrawer extends StatefulWidget{
  const ItemsInSideBarDrawer({super.key,required this.onCountryCodeChanged});

  final Function(String) onCountryCodeChanged;


  @override
  State<StatefulWidget> createState() {
    return ItemsInSideBarDrawerState();
  }
  
}

class ItemsInSideBarDrawerState extends State<ItemsInSideBarDrawer>{


  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Column(
        children: [
          Image.asset(
            'assets/news.png',
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
           SizedBox(height: 20.sp,),
          itemInDrawer(
              icon: Icons.home,
              title: tr('Home'),
              onTap: ()=> Navigator.pop(context)
          ),
          itemInDrawer(
              icon: Icons.location_city,
              title: tr('Country'),
              onTap: () {
                showCountryPicker(
                  context: context,
                  onSelect: (Country country) {
                    print('country code: ${country.countryCode.toLowerCase()}');
                    print('Select country: ${country.displayName.toLowerCase()}');
                    saveSelectedCountry(country.countryCode.toLowerCase());
                    setState(() {});
                  },
                );
              },
          ),
          itemInDrawer(
              icon: Icons.language,
              title: tr('Language'),
              onTap: () {
                showLanguageSelectionDialog(context);
              }
          ),
          itemInDrawer(
              icon: Icons.invert_colors_on,
              title: tr('Theme'),
              onTap: () {
                selectThemeDialog(context);
              }
          ),
        ],
      ),
    );
  }

  Future<void> saveSelectedCountry(String selectedCountryCode) async{
    await PreferenceUtils.setString(PrefKeys.newsCountry, selectedCountryCode,);
    setState(() {});
    print('-----------> ${PreferenceUtils.getString(PrefKeys.newsCountry)}');
    Navigator.pop(context);
    widget.onCountryCodeChanged(selectedCountryCode);
  }

  Widget itemInDrawer({
    required IconData icon,
    required String title,
    required GestureTapCallback onTap,
}){
    return ListTile(
      leading: Icon(
        icon,
        size: 27.sp,
        color: Colors.indigo[800],
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 20.sp,),
      ),
      onTap: onTap
    );
  }

  void showLanguageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Text(tr('select_language'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    tr('Arabic',),
                    style: TextStyle(
                        color: Colors.indigo[800],
                      fontSize: 19.sp,
                    ),
                  ),
                  onPressed: () {
                    EasyLocalization.of(context)!.setLocale(const Locale('ar', 'EG'));
                    PreferenceUtils.setString(PrefKeys.language, 'ar');

                    setState(() { });
                    Navigator.pop(dialogContext);
                  },
                ),
                TextButton(
                  child: Text(tr('English'),
                    style: TextStyle(
                        color: Colors.indigo[800],
                      fontSize: 19.sp,
                    ),
                  ),
                  onPressed: () {
                    EasyLocalization.of(context)!.setLocale(const Locale('en', 'US'));
                    PreferenceUtils.setString(PrefKeys.language, 'en');
                    setState(() { });
                    Navigator.pop(dialogContext);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10,)
          ],
        );
      },
    );
  }

 void selectThemeDialog(BuildContext context) {
   showDialog(
     context: context,
     builder: (BuildContext dialogContext) {
       return AlertDialog(
         content: Text(tr('Select Theme'),
           textAlign: TextAlign.center,
           style: TextStyle(
               fontSize: 20.sp,
               fontWeight: FontWeight.w600
           ),
         ),
         shape: const RoundedRectangleBorder(
           borderRadius: BorderRadius.all(Radius.circular(20.0),
           ),
         ),
         actions: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               TextButton(
                 child: Text(
                   tr('Dark',),
                   style: TextStyle(
                     color: Colors.indigo[800],
                     fontSize: 19.sp,
                   ),
                 ),
                 onPressed: () {
                   changeTheme(ThemeData.dark());
                   Navigator.pop(dialogContext);
                 },
               ),
               TextButton(
                   child: Text(tr('Light'),
                   style: TextStyle(
                     color: Colors.indigo[800],
                     fontSize: 19.sp,
                   ),
                 ),
                 onPressed: () {
                   changeTheme(ThemeData.light());
                   Navigator.pop(dialogContext);
                 },
               ),
             ],
           ),
           const SizedBox(height: 10,)
         ],
       );
     },
   );
 }

  void changeTheme(ThemeData selectedTheme) {
    setState(() {
      MyApp.applyTheme(selectedTheme);
    });
  }

  
}