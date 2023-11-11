import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:instant_api_news_app/singleton/shared_prefernces.dart';

class ItemsInSideBarDrawer extends StatefulWidget{
  const ItemsInSideBarDrawer({super.key,});

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
          const SizedBox(height: 20,),
          itemInDrawer(
              icon: Icons.home,
              title: 'Home',
              onTap: ()=> Navigator.pop(context)
          ),
          itemInDrawer(
              icon: Icons.location_city,
              title: 'Country',
              onTap: () {
                showCountryPicker(
                  context: context,
                  onSelect: (Country country) {
                    print('country code: ${country.countryCode.toLowerCase()}');
                    print('Select country: ${country.displayName.toLowerCase()}');
                    saveSelectedCountry(country.countryCode.toLowerCase());
                    setState(() {

                    });
                  },
                );
              }
          ),
          itemInDrawer(
              icon: Icons.language,
              title: 'Language',
              onTap: () {}
          ),
          itemInDrawer(
              icon: Icons.invert_colors_on,
              title: 'Theme',
              onTap: () {}
          ),
        ],
      ),
    );
  }

  void saveSelectedCountry(String selectedCountryCode) async{
    await PreferenceUtils.setString(PrefKeys.newsCountry, selectedCountryCode,);
    setState(() {});
    print('-----------> ${PreferenceUtils.getString(PrefKeys.newsCountry)}');
    Navigator.pop(context);
  }

  Widget itemInDrawer({
    required IconData icon,
    required String title,
    required GestureTapCallback onTap,
}){
    return ListTile(
      leading: Icon(
        icon,
        size: 40,
        color: Colors.indigo[800],
      ),
      title: Text(
        title,
        style:const TextStyle(fontSize: 25,),
      ),
      onTap: onTap
    );
  }
  
}