/// Model for a single Azkar entry.
class AzkarEntry {
  final String arabic;
  final String translation;
  final int repeatCount;

  const AzkarEntry({
    required this.arabic,
    required this.translation,
    required this.repeatCount,
  });
}

/// All Morning Azkar entries.
const List<AzkarEntry> morningAzkar = [
  AzkarEntry(
    arabic:
        'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
    translation:
        'We have entered the morning and the whole kingdom of Allah has also entered the morning. Praise is to Allah. None has the right to be worshipped except Allah, alone, without any partner.',
    repeatCount: 1,
  ),
  AzkarEntry(
    arabic:
        'اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ النُّشُورُ',
    translation:
        'O Allah, by Your leave we have reached the morning and by Your leave we reach the evening, by Your leave we live and by Your leave we die, and to You is our resurrection.',
    repeatCount: 1,
  ),
  AzkarEntry(
    arabic:
        'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ',
    translation:
        'O Allah, You are my Lord. There is no god but You. You created me and I am Your servant.',
    repeatCount: 1,
  ),
  AzkarEntry(
    arabic: 'سُبْحَانَ اللهِ وَبِحَمْدِهِ',
    translation: 'Glory and praise be to Allah.',
    repeatCount: 100,
  ),
  AzkarEntry(
    arabic:
        'لَا إِلَهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
    translation:
        'None has the right to be worshipped except Allah, alone, without partner. To Him belongs all sovereignty and praise, and He is over all things omnipotent.',
    repeatCount: 10,
  ),
];

/// All Evening Azkar entries.
const List<AzkarEntry> eveningAzkar = [
  AzkarEntry(
    arabic:
        'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ',
    translation:
        'We have entered the evening and the whole kingdom of Allah has also entered the evening. Praise is to Allah.',
    repeatCount: 1,
  ),
  AzkarEntry(
    arabic:
        'اللَّهُمَّ بِكَ أَمْسَيْنَا، وَبِكَ أَصْبَحْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ الْمَصِيرُ',
    translation:
        'O Allah, by Your leave we have reached the evening and by Your leave we reach the morning, by Your leave we live and by Your leave we die, and to You is our return.',
    repeatCount: 1,
  ),
  AzkarEntry(
    arabic:
        'اللَّهُمَّ إِنِّي أَمْسَيْتُ أُشْهِدُكَ وَأُشْهِدُ حَمَلَةَ عَرْشِكَ وَمَلَائِكَتَكَ وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللهُ لَا إِلَهَ إِلَّا أَنْتَ وَحْدَكَ لَا شَرِيكَ لَكَ',
    translation:
        'O Allah, I have entered the evening calling You, the bearers of Your Throne, Your angels, and all of Your creation to witness that You are Allah, there is none worthy of worship but You alone.',
    repeatCount: 4,
  ),
  AzkarEntry(
    arabic: 'سُبْحَانَ اللهِ وَبِحَمْدِهِ',
    translation: 'Glory and praise be to Allah.',
    repeatCount: 100,
  ),
  AzkarEntry(
    arabic: 'أَسْتَغْفِرُ اللهَ وَأَتُوبُ إِلَيْهِ',
    translation: 'I seek the forgiveness of Allah and repent to Him.',
    repeatCount: 100,
  ),
];
