import 'package:flutter/material.dart';
import 'package:alarm/localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:alarm/models/language.dart';
import 'package:alarm/screens/screens.dart';
class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List<Widget> _pages = [
    OverviewPage(),
    NewsPage(),
    NotificationPage()
  ];
  void _selectLanguage(Language language, lang) {
    lang.changeLanguage(Locale(language.code));
  }
  navigate(int index) {
    this.setState(() { this._currentIndex = index;});
  }
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('title')),
        elevation: 10,
        actions: <Widget>[
          PopupMenuButton<Language>(
            // overflow menu
            onSelected: (language) => _selectLanguage(language, appLanguage),
            icon: Icon(
              Icons.public,
              color: Colors.white,
            ),
            itemBuilder: (BuildContext context) {
              return languages
                  .map<PopupMenuItem<Language>>((Language language) {
                return PopupMenuItem<Language>(
                  value: language,
                  child: Text(language.title),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => navigate(index),
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            title: Text(AppLocalizations.of(context).translate('overview') != null ? AppLocalizations.of(context).translate('overview') : 'Overview'),
            icon: Icon(Icons.info_outline)
          ),
          BottomNavigationBarItem(
              title: Text(AppLocalizations.of(context).translate('news') != null ? AppLocalizations.of(context).translate('news') :'News'),
              icon: Icon(Icons.assessment)
          ),
          BottomNavigationBarItem(
              title: Text(AppLocalizations.of(context).translate('notifications') != null ? AppLocalizations.of(context).translate('notifications') : 'Notification'),
              icon: Icon(Icons.notifications)
          )
        ],
      ),
    );
  }
}