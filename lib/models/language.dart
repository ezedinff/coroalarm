class Language {
  const Language({this.title, this.code});
  final String title;
  final String code;
}

const List<Language> languages = <Language>[
  Language(title: 'English', code: 'en'),
  Language(title: 'አማርኛ', code: 'am'),
  Language(title: 'Afan Oromo', code: 'or'),
];