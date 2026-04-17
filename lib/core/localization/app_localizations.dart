import 'dart:ui';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AppLocalizations — manually maintained translations for 5 languages
// ─────────────────────────────────────────────────────────────────────────────
class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const delegate = _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en'), // English
    Locale('hi'), // Hindi
    Locale('mr'), // Marathi
    Locale('gu'), // Gujarati
    Locale('ta'), // Tamil
  ];

  static const Map<String, String> _languageNames = {
    'en': '🇬🇧 English',
    'hi': '🇮🇳 हिंदी',
    'mr': '🇮🇳 मराठी',
    'gu': '🇮🇳 ગુજરાતી',
    'ta': '🇮🇳 தமிழ்',
  };

  static String languageNameFor(String code) =>
      _languageNames[code] ?? code;

  String get _lang => locale.languageCode;

  // ────────────────────────── APP WIDE ─────────────────────────────────────
  String get appName => const {
    'en': 'MUNI-M',
    'hi': 'MUNI-M',
    'mr': 'MUNI-M',
    'gu': 'MUNI-M',
    'ta': 'MUNI-M',
  }[_lang]!;

  String get appTagline => const {
    'en': 'The Intelligence Behind Your Money',
    'hi': 'आपके पैसे की बुद्धि',
    'mr': 'तुमच्या पैशाची बुद्धिमत्ता',
    'gu': 'તમારા પૈસાની બુદ્ધિ',
    'ta': 'உங்கள் பணத்தின் புத்திசாலித்தனம்',
  }[_lang]!;

  // ────────────────────────── GREETINGS ────────────────────────────────────
  String get goodMorning => const {
    'en': 'Good Morning',
    'hi': 'सुप्रभात',
    'mr': 'शुभ सकाळ',
    'gu': 'શુભ સવાર',
    'ta': 'காலை வணக்கம்',
  }[_lang]!;

  String get goodAfternoon => const {
    'en': 'Good Afternoon',
    'hi': 'शुभ दोपहर',
    'mr': 'शुभ दुपार',
    'gu': 'શુભ બપોર',
    'ta': 'மதிய வணக்கம்',
  }[_lang]!;

  String get goodEvening => const {
    'en': 'Good Evening',
    'hi': 'शुभ संध्या',
    'mr': 'शुभ संध्याकाळ',
    'gu': 'શુભ સાંજ',
    'ta': 'மாலை வணக்கம்',
  }[_lang]!;

  String get welcomeBack => const {
    'en': 'Welcome back!',
    'hi': 'वापसी पर स्वागत!',
    'mr': 'परत स्वागत आहे!',
    'gu': 'પાછા સ્વાગત!',
    'ta': 'மீண்டும் வரவேற்கிறோம்!',
  }[_lang]!;

  // ────────────────────────── DASHBOARD ────────────────────────────────────
  String get netProfit => const {
    'en': 'Net Profit',
    'hi': 'शुद्ध लाभ',
    'mr': 'निव्वळ नफा',
    'gu': 'ચોખ્ખો નફો',
    'ta': 'நிகர லாபம்',
  }[_lang]!;

  String get thisMonth => const {
    'en': 'This month',
    'hi': 'इस महीने',
    'mr': 'या महिन्यात',
    'gu': 'આ મહિને',
    'ta': 'இந்த மாதம்',
  }[_lang]!;

  String get burnRate => const {
    'en': 'Burn Rate',
    'hi': 'खर्च दर',
    'mr': 'खर्च दर',
    'gu': 'ખર્ચ દર',
    'ta': 'செலவு விகிதம்',
  }[_lang]!;

  String get daysOfFreedom => const {
    'en': 'Days of Freedom',
    'hi': 'स्वतंत्रता के दिन',
    'mr': 'स्वातंत्र्याचे दिवस',
    'gu': 'સ્વતંત્રતાના દિવસો',
    'ta': 'சுதந்திர நாட்கள்',
  }[_lang]!;

  String get invested => const {
    'en': 'Invested',
    'hi': 'निवेशित',
    'mr': 'गुंतवणूक',
    'gu': 'રોકાણ',
    'ta': 'முதலீடு',
  }[_lang]!;

  String get addEntry => const {
    'en': 'Add Entry',
    'hi': 'एंट्री जोड़ें',
    'mr': 'एंट्री जोडा',
    'gu': 'એન્ટ્રી ઉમેરો',
    'ta': 'பதிவு சேர்க்க',
  }[_lang]!;

  String get recentTransactions => const {
    'en': 'Recent Transactions',
    'hi': 'हाल के लेनदेन',
    'mr': 'अलीकडील व्यवहार',
    'gu': 'તાજેતરના વ્યવહારો',
    'ta': 'சமீபத்திய பரிவர்த்தனைகள்',
  }[_lang]!;

  String get seeAll => const {
    'en': 'See all',
    'hi': 'सभी देखें',
    'mr': 'सर्व पहा',
    'gu': 'બધા જુઓ',
    'ta': 'அனைத்தும் காண்க',
  }[_lang]!;

  String get noTransactionsYet => const {
    'en': 'No transactions yet',
    'hi': 'अभी कोई लेनदेन नहीं',
    'mr': 'अद्याप कोणताही व्यवहार नाही',
    'gu': 'હજુ સુધી કોઈ વ્યવહાર નહીં',
    'ta': 'இன்னும் பரிவர்த்தனைகள் இல்லை',
  }[_lang]!;

  String get noTransactionsHint => const {
    'en': 'Tap "Add Entry" to record your first income or expense',
    'hi': 'पहली आय या खर्च दर्ज करने के लिए "एंट्री जोड़ें" दबाएं',
    'mr': 'पहिले उत्पन्न किंवा खर्च नोंदवण्यासाठी "एंट्री जोडा" दाबा',
    'gu': 'પ્રથમ આવક અથવા ખર્ચ નોંધવા "એન્ટ્રી ઉમેરો" ટેપ કરો',
    'ta': 'முதல் வருமானம் அல்லது செலவை பதிக்க "பதிவு சேர்க்க" தட்டவும்',
  }[_lang]!;

  // ────────────────────────── ADD TRANSACTION SHEET ────────────────────────
  String get addTransaction => const {
    'en': 'Add Transaction',
    'hi': 'लेनदेन जोड़ें',
    'mr': 'व्यवहार जोडा',
    'gu': 'વ્યવહાર ઉમેરો',
    'ta': 'பரிவர்த்தனை சேர்க்க',
  }[_lang]!;

  String get income => const {
    'en': 'Income',
    'hi': 'आय',
    'mr': 'उत्पन्न',
    'gu': 'આવક',
    'ta': 'வருமானம்',
  }[_lang]!;

  String get expense => const {
    'en': 'Expense',
    'hi': 'खर्च',
    'mr': 'खर्च',
    'gu': 'ખર્ચ',
    'ta': 'செலவு',
  }[_lang]!;

  String get invest => const {
    'en': 'Invest',
    'hi': 'निवेश',
    'mr': 'गुंतवणूक',
    'gu': 'રોકાણ',
    'ta': 'முதலீடு',
  }[_lang]!;

  String get save => const {
    'en': 'Save',
    'hi': 'बचत',
    'mr': 'बचत',
    'gu': 'બચત',
    'ta': 'சேமிப்பு',
  }[_lang]!;

  String get enterValidAmount => const {
    'en': 'Enter a valid amount',
    'hi': 'वैध राशि दर्ज करें',
    'mr': 'वैध रक्कम प्रविष्ट करा',
    'gu': 'માન્ય રકમ દાખલ કરો',
    'ta': 'சரியான தொகையை உள்ளிடுக',
  }[_lang]!;

  String get labelOptional => const {
    'en': 'Label (optional)',
    'hi': 'लेबल (वैकल्पिक)',
    'mr': 'लेबल (पर्यायी)',
    'gu': 'લેબલ (વૈકલ્પિક)',
    'ta': 'லேபிள் (விருப்பத்தேர்வு)',
  }[_lang]!;

  // ────────────────────────── NAVIGATION LABELS ─────────────────────────────
  String get home => const {
    'en': 'Home',
    'hi': 'होम',
    'mr': 'होम',
    'gu': 'હોમ',
    'ta': 'முகப்பு',
  }[_lang]!;

  String get future => const {
    'en': 'Future',
    'hi': 'भविष्य',
    'mr': 'भविष्य',
    'gu': 'ભવિષ્ય',
    'ta': 'எதிர்காலம்',
  }[_lang]!;

  String get advisor => const {
    'en': 'Advisor',
    'hi': 'सलाहकार',
    'mr': 'सल्लागार',
    'gu': 'સલાહકાર',
    'ta': 'ஆலோசகர்',
  }[_lang]!;

  String get strategy => const {
    'en': 'Strategy',
    'hi': 'रणनीति',
    'mr': 'रणनीती',
    'gu': 'વ્યૂહ',
    'ta': 'உத்தி',
  }[_lang]!;

  String get community => const {
    'en': 'Community',
    'hi': 'समुदाय',
    'mr': 'समुदाय',
    'gu': 'સમુદાય',
    'ta': 'சமூகம்',
  }[_lang]!;

  // ────────────────────────── STRATEGY ─────────────────────────────────────
  String get moneyRule => const {
    'en': '50-30-20 Money Rule',
    'hi': '50-30-20 पैसे का नियम',
    'mr': '50-30-20 पैशाचा नियम',
    'gu': '50-30-20 પૈસાનો નિયમ',
    'ta': '50-30-20 பண விதி',
  }[_lang]!;

  String get needs => const {
    'en': 'Needs',
    'hi': 'ज़रूरतें',
    'mr': 'गरजा',
    'gu': 'જરૂરિયાતો',
    'ta': 'தேவைகள்',
  }[_lang]!;

  String get wants => const {
    'en': 'Wants',
    'hi': 'इच्छाएं',
    'mr': 'इच्छा',
    'gu': 'ઇચ્છાઓ',
    'ta': 'விருப்பங்கள்',
  }[_lang]!;

  String get investAndSave => const {
    'en': 'Invest & Save',
    'hi': 'निवेश करें और बचाएं',
    'mr': 'गुंतवणूक आणि बचत',
    'gu': 'રોકાણ અને બચત',
    'ta': 'முதலீடு & சேமிப்பு',
  }[_lang]!;

  String get goalTracker => const {
    'en': 'Goal Tracker',
    'hi': 'लक्ष्य ट्रैकर',
    'mr': 'ध्येय ट्रॅकर',
    'gu': 'ધ્યેય ટ્રૅકર',
    'ta': 'இலக்கு கண்காணிப்பு',
  }[_lang]!;

  // ────────────────────────── FUTURE INSIGHTS ───────────────────────────────
  String get futureInsights => const {
    'en': 'Future Insights',
    'hi': 'भविष्य की जानकारी',
    'mr': 'भविष्यातील माहिती',
    'gu': 'ભવિષ્યની સમज',
    'ta': 'எதிர்கால நுண்ணறிவு',
  }[_lang]!;

  String get opportunityCost => const {
    'en': 'Opportunity Cost',
    'hi': 'अवसर लागत',
    'mr': 'संधी खर्च',
    'gu': 'તક ખર્ચ',
    'ta': 'வாய்ப்பு செலவு',
  }[_lang]!;

  String get inflationRealityCheck => const {
    'en': 'Inflation Reality Check',
    'hi': 'मुद्रास्फीति वास्तविकता जांच',
    'mr': 'महागाई वास्तविकता तपासणी',
    'gu': 'ફુગાવો વાસ્તવિકતા ચકાસણી',
    'ta': 'பணவீக்க உண்மை சோதனை',
  }[_lang]!;

  // ────────────────────────── AI ADVISOR ───────────────────────────────────
  String get muniAdvisor => const {
    'en': 'MUNI Advisor',
    'hi': 'MUNI सलाहकार',
    'mr': 'MUNI सल्लागार',
    'gu': 'MUNI સલાહકાર',
    'ta': 'MUNI ஆலோசகர்',
  }[_lang]!;

  String get aiAlwaysAvailable => const {
    'en': 'AI • Always Available',
    'hi': 'AI • हमेशा उपलब्ध',
    'mr': 'AI • नेहमी उपलब्ध',
    'gu': 'AI • હંમેશા ઉપલબ્ધ',
    'ta': 'AI • எப்போதும் கிடைக்கும்',
  }[_lang]!;

  String get askMuniAnything => const {
    'en': 'Ask MUNI anything...',
    'hi': 'MUNI से कुछ भी पूछें...',
    'mr': 'MUNI ला काहीही विचारा...',
    'gu': 'MUNI ને ગમે તે પૂછો...',
    'ta': 'MUNI யிடம் எதையும் கேளுங்கள்...',
  }[_lang]!;

  // ────────────────────────── COMMUNITY ────────────────────────────────────
  String get wealthCircles => const {
    'en': 'Wealth Circles',
    'hi': 'धन मंडल',
    'mr': 'संपत्ती मंडळ',
    'gu': 'સંપત્તિ વર્તુળ',
    'ta': 'செல்வ வட்டங்கள்',
  }[_lang]!;

  String get leaderboard => const {
    'en': 'Leaderboard',
    'hi': 'लीडरबोर्ड',
    'mr': 'लीडरबोर्ड',
    'gu': 'લીડરબોર્ડ',
    'ta': 'முன்னணி பட்டியல்',
  }[_lang]!;

  String get dailyWisdom => const {
    'en': 'Daily Wisdom',
    'hi': 'दैनिक ज्ञान',
    'mr': 'दैनिक शहाणपण',
    'gu': 'દૈનિક શાણપણ',
    'ta': 'தினசரி ஞானம்',
  }[_lang]!;

  // ────────────────────────── SETTINGS / LANGUAGE ───────────────────────────
  String get selectLanguage => const {
    'en': 'Select Language',
    'hi': 'भाषा चुनें',
    'mr': 'भाषा निवडा',
    'gu': 'ભાષા પસંદ કરો',
    'ta': 'மொழியை தேர்ந்தெடுக்கவும்',
  }[_lang]!;

  String get theme => const {
    'en': 'Theme',
    'hi': 'थीम',
    'mr': 'थीम',
    'gu': 'થીમ',
    'ta': 'தீம்',
  }[_lang]!;

  // ────────────────────────── SMART ALERTS ──────────────────────────────────
  String get burnRateCritical => const {
    'en': 'Burn Rate Critical',
    'hi': 'खर्च दर गंभीर',
    'mr': 'खर्च दर गंभीर',
    'gu': 'ખર્ચ દર ગંભીર',
    'ta': 'செலவு விகிதம் தீவிரம்',
  }[_lang]!;

  String get zeroInvestmentWarning => const {
    'en': 'Zero Investment Warning',
    'hi': 'शून्य निवेश चेतावनी',
    'mr': 'शून्य गुंतवणूक चेतावणी',
    'gu': 'શૂન્ય રોકાણ ચેતવણી',
    'ta': 'பூஜ்ஜிய முதலீட்டு எச்சரிக்கை',
  }[_lang]!;

  String get emergencyFundGap => const {
    'en': 'Emergency Fund Gap',
    'hi': 'आपातकालीन निधि अंतर',
    'mr': 'आपत्कालीन निधी तफावत',
    'gu': 'ઇમર્જન્સી ફંડ ગેપ',
    'ta': 'அவசர நிதி குறைபாடு',
  }[_lang]!;

  // ────────────────────────── ONBOARDING ────────────────────────────────────
  String get getStarted => const {
    'en': 'Get Started',
    'hi': 'शुरू करें',
    'mr': 'सुरू करा',
    'gu': 'શરૂ કરો',
    'ta': 'தொடங்கு',
  }[_lang]!;

  String get yourMonthlyIncome => const {
    'en': 'Your Monthly Income',
    'hi': 'आपकी मासिक आय',
    'mr': 'तुमचे मासिक उत्पन्न',
    'gu': 'તમારી માસિક આવક',
    'ta': 'உங்கள் மாதாந்திர வருமானம்',
  }[_lang]!;

  String get chooseYourGoals => const {
    'en': 'Choose Your Goals',
    'hi': 'अपने लक्ष्य चुनें',
    'mr': 'तुमची उद्दिष्टे निवडा',
    'gu': 'તમારા લક્ષ્ય પસંદ કરો',
    'ta': 'உங்கள் இலக்குகளை தேர்ந்தெடுங்கள்',
  }[_lang]!;

  String get whatsYourName => const {
    'en': "What's your name?",
    'hi': 'आपका नाम क्या है?',
    'mr': 'तुमचे नाव काय आहे?',
    'gu': 'તમારું નામ શું છે?',
    'ta': 'உங்கள் பெயர் என்ன?',
  }[_lang]!;

  // ────────────────────────── NET PROFIT CARD ──────────────────────────────
  String get dailyNetProfit => const {
    'en': 'Daily Net Profit',
    'hi': 'दैनिक शुद्ध लाभ',
    'mr': 'दैनंदिन निव्वळ नफा',
    'gu': 'દૈનિક ચોખ્ખો નફો',
    'ta': 'தினசரி நிகர லாபம்',
  }[_lang]!;

  String get onTrack => const {
    'en': 'On Track',
    'hi': 'सही राह पर',
    'mr': 'योग्य मार्गावर',
    'gu': 'સાચા રસ્તે',
    'ta': 'சரியான பாதையில்',
  }[_lang]!;

  String get overBudget => const {
    'en': 'Over Budget',
    'hi': 'बजट से अधिक',
    'mr': 'बजेट ओलांडले',
    'gu': 'બજેટ વટાવ્યું',
    'ta': 'பட்ஜெட்டை மீறியது',
  }[_lang]!;

  String get surplus => const {
    'en': 'surplus',
    'hi': 'बचत',
    'mr': 'शिल्लक',
    'gu': 'બચત',
    'ta': 'உபரி',
  }[_lang]!;

  String get deficit => const {
    'en': 'deficit',
    'hi': 'घाटा',
    'mr': 'तूट',
    'gu': 'ખોટ',
    'ta': 'பற்றாக்குறை',
  }[_lang]!;

  String get monthlyBurnRate => const {
    'en': 'Monthly burn rate',
    'hi': 'मासिक खर्च दर',
    'mr': 'मासिक खर्च दर',
    'gu': 'માસિક ખર્ચ દર',
    'ta': 'மாதாந்திர செலவு விகிதம்',
  }[_lang]!;

  String incomeSpent(String inc, String spent) => const {
    'en': '{inc} income · {spent} spent',
    'hi': '{inc} आय · {spent} खर्च',
    'mr': '{inc} उत्पन्न · {spent} खर्च',
    'gu': '{inc} આવક · {spent} ખર્ચ',
    'ta': '{inc} வருமானம் · {spent} செலவு',
  }[_lang]!.replaceAll('{inc}', inc).replaceAll('{spent}', spent);

  // ────────────────────────── FREEDOM DAYS CARD ─────────────────────────────
  String get levelCritical => const {
    'en': 'Critical',
    'hi': 'गंभीर',
    'mr': 'गंभीर',
    'gu': 'ગંભીર',
    'ta': 'தீவிரமான',
  }[_lang]!;

  String get levelLow => const {
    'en': 'Low',
    'hi': 'कम',
    'mr': 'कमी',
    'gu': 'ઓછું',
    'ta': 'குறைவு',
  }[_lang]!;

  String get levelSafe => const {
    'en': 'Safe',
    'hi': 'सुरक्षित',
    'mr': 'सुरक्षित',
    'gu': 'સુરક્ષિત',
    'ta': 'பாதுகாப்பான',
  }[_lang]!;

  String get levelStrong => const {
    'en': 'Strong',
    'hi': 'मजबूत',
    'mr': 'मजबूत',
    'gu': 'મજબૂત',
    'ta': 'வலிமையான',
  }[_lang]!;

  // ────────────────────────── SMART ALERTS ──────────────────────────────────
  String get smartAlerts => const {
    'en': 'Smart Alerts',
    'hi': 'स्मार्ट अलर्ट',
    'mr': 'स्मार्ट अलर्ट',
    'gu': 'સ્માર્ટ એલર્ટ',
    'ta': 'ஸ்மார்ட் எச்சரிக்கைகள்',
  }[_lang]!;

  // ────────────────────────── ASSET / LIABILITY ──────────────────────────────
  String get assetVsLiability => const {
    'en': 'Asset vs Liability',
    'hi': 'संपत्ति बनाम देनदारी',
    'mr': 'मालमत्ता विरुद्ध देणे',
    'gu': 'સ્વત્વ vs જવાબદારી',
    'ta': 'சொத்து vs கடன்',
  }[_lang]!;

  String get assets => const {
    'en': 'Assets',
    'hi': 'संपत्ति',
    'mr': 'मालमत्ता',
    'gu': 'સ્વત્વ',
    'ta': 'சொத்துக்கள்',
  }[_lang]!;

  String get liabilities => const {
    'en': 'Liabilities',
    'hi': 'देनदारियां',
    'mr': 'देणे',
    'gu': 'જવાબદારીઓ',
    'ta': 'கடன்கள்',
  }[_lang]!;

  String get noTransactionsHealth => const {
    'en': 'Add transactions to see your financial health',
    'hi': 'अपनी वित्तीय स्थिति देखने के लिए लेनदेन जोड़ें',
    'mr': 'तुमची आर्थिक स्थिती पाहण्यासाठी व्यवहार जोडा',
    'gu': 'તમારી નાણાકીય સ્થિતિ જોવા વ્યવહારો ઉમેરો',
    'ta': 'உங்கள் நிதி நலனை காண பரிவர்த்தனைகள் சேர்க்கவும்',
  }[_lang]!;

  String get assetsGrowing => const {
    'en': '✅ Your assets are growing. Keep investing!',
    'hi': '✅ आपकी संपत्ति बढ़ रही है। निवेश जारी रखें!',
    'mr': '✅ तुमची मालमत्ता वाढत आहे. गुंतवणूक सुरू ठेवा!',
    'gu': '✅ તમારી સ્વત્વ વધી રહી છે. રોકાણ ચાલુ રાખો!',
    'ta': '✅ உங்கள் சொத்துக்கள் வளர்கின்றன. முதலீடு தொடருங்கள்!',
  }[_lang]!;

  String get balanceSpending => const {
    'en': '⚠️ Balance your spending with saving',
    'hi': '⚠️ अपने खर्च को बचत से संतुलित करें',
    'mr': '⚠️ तुमचा खर्च बचतीशी संतुलित करा',
    'gu': '⚠️ તમારો ખર્ચ બચત સાથે સંતુલિત કરો',
    'ta': '⚠️ உங்கள் செலவை சேமிப்புடன் சமன் செய்யுங்கள்',
  }[_lang]!;

  String get liabilitiesDominate => const {
    'en': '🔴 Liabilities dominate. Time to restrategize.',
    'hi': '🔴 देनदारी हावी है। पुनर्रणनीति का समय।',
    'mr': '🔴 देणे जास्त आहे. पुन्हा नियोजन करा.',
    'gu': '🔴 જવાબદારી હાવી છે. ફરી વ્યૂહ ઘડો.',
    'ta': '🔴 கடன்கள் மேலோங்குகின்றன. மறுதிட்டமிடு.',
  }[_lang]!;

  // ────────────────────────── ROI LABELS ────────────────────────────────────
  String get roiExcellent => const {
    'en': 'Excellent ROI',
    'hi': 'उत्कृष्ट ROI',
    'mr': 'उत्कृष्ट ROI',
    'gu': 'ઉત્કૃષ્ટ ROI',
    'ta': 'சிறந்த ROI',
  }[_lang]!;

  String get roiGood => const {
    'en': 'Good',
    'hi': 'अच्छा',
    'mr': 'चांगला',
    'gu': 'સારો',
    'ta': 'நல்லது',
  }[_lang]!;

  String get roiNeutral => const {
    'en': 'Neutral',
    'hi': 'तटस्थ',
    'mr': 'तटस्थ',
    'gu': 'તટસ્થ',
    'ta': 'நடுநிலை',
  }[_lang]!;

  String get roiPoor => const {
    'en': 'Poor ROI',
    'hi': 'खराब ROI',
    'mr': 'खराब ROI',
    'gu': 'નબળો ROI',
    'ta': 'மோசமான ROI',
  }[_lang]!;

  String get roiBad => const {
    'en': 'Bad Move',
    'hi': 'गलत कदम',
    'mr': 'चुकीचे पाऊल',
    'gu': 'ખોટો નિર્ણય',
    'ta': 'தவறான முடிவு',
  }[_lang]!;

  // ─────────────────── FUTURE INSIGHTS TAB ────────────────────────────────────
  String get futureInsightsTitle => const {
    'en': '🔮 Future Insights',
    'hi': '🔮 भविष्य की जानकारी',
    'mr': '🔮 भविष्यातील माहिती',
    'gu': '🔮 ભવિષ્યની સમજ',
    'ta': '🔮 எதிர்கால நுண்ணறிவு',
  }[_lang]!;

  String get futureInsightsSubtitle => const {
    'en': 'See the real cost of your decisions',
    'hi': 'अपने निर्णयों की असली कीमत देखें',
    'mr': 'तुमच्या निर्णयांची खरी किंमत पहा',
    'gu': 'તમારા નિર્ણયોની વાસ્તવિક કિંમત જુઓ',
    'ta': 'உங்கள் முடிவுகளின் உண்மையான விலையை காணுங்கள்',
  }[_lang]!;

  String get projection => const {
    'en': 'Projection',
    'hi': 'प्रक्षेपण',
    'mr': 'अंदाज',
    'gu': 'અંદાજ',
    'ta': 'முன்கணிப்பு',
  }[_lang]!;

  String get spendingVsOpportunityCost => const {
    'en': 'Spending vs Opportunity Cost',
    'hi': 'खर्च बनाम अवसर लागत',
    'mr': 'खर्च विरुद्ध संधी खर्च',
    'gu': 'ખર્ચ vs તક ખર્ચ',
    'ta': 'செலவு vs வாய்ப்பு செலவு',
  }[_lang]!;

  String get spendingSubtitle => const {
    'en': 'What you lose by not investing this money',
    'hi': 'इस पैसे को निवेश न करने से आप क्या खोते हैं',
    'mr': 'हे पैसे गुंतवणूक न केल्यास काय गमावता',
    'gu': 'આ પૈસા રોકાણ ન કરવાથી શું ગુમાવો છો',
    'ta': 'இந்த பணத்தை முதலீடு செய்யாவிட்டால் என்ன இழக்கிறீர்கள்',
  }[_lang]!;

  // Compound hero card
  String get invest20Percent => const {
    'en': '💡 If you invested 20% of income today...',
    'hi': '💡 यदि आप आज अपनी आय का 20% निवेश करें...',
    'mr': '💡 जर तुम्ही आज उत्पन्नाचे 20% गुंतवलं तर...',
    'gu': '💡 જો તમે આજે આવકનો 20% રોક્યો હોત...',
    'ta': '💡 இன்று வருமானத்தின் 20% முதலீடு செய்தால்...',
  }[_lang]!;

  String get today => const {
    'en': 'Today',
    'hi': 'आज',
    'mr': 'आज',
    'gu': 'આજ',
    'ta': 'இன்று',
  }[_lang]!;

  String get perMonth => const {
    'en': 'per month',
    'hi': 'प्रति माह',
    'mr': 'दर महिना',
    'gu': 'દર મહિને',
    'ta': 'மாதத்திற்கு',
  }[_lang]!;

  String inYears(int y) => {
    'en': 'In $y years',
    'hi': '$y साल में',
    'mr': '$y वर्षांत',
    'gu': '$y વર્ષ પછી',
    'ta': '$y ஆண்டுகளில்',
  }[_lang]!;

  String get atReturn => const {
    'en': 'at 12% p.a.',
    'hi': '12% प्रति वर्ष पर',
    'mr': '12% वार्षिक दराने',
    'gu': '12% વ્યાજ દર પ્રતિ વર્ષ',
    'ta': 'ஆண்டுக்கு 12% வட்டியில்',
  }[_lang]!;

  String get indexFundNote => const {
    'en': '📌 Index funds (Nifty 50 SIP) have historically returned 12-14% p.a. over 10+ year periods.',
    'hi': '📌 इंडेक्स फंड (Nifty 50 SIP) ने ऐतिहासिक रूप से 10+ वर्षों में 12-14% वार्षिक रिटर्न दिया है।',
    'mr': '📌 इंडेक्स फंड (Nifty 50 SIP) ऐतिहासिकरित्या 10+ वर्षांत 12-14% वार्षिक परतावा देतात.',
    'gu': '📌 ઇન્ડેક્સ ફંડ (Nifty 50 SIP) ઐતિહાસિક રીતે 10+ વર્ષો ઉપર 12-14% વ્યાજ આપ્યો છે.',
    'ta': '📌 இண்டெக்ஸ் ஃபண்டுகள் (Nifty 50 SIP) 10+ ஆண்டுகளில் தொடர்ந்து 12-14% வருடாந்திர வருவாயை அளித்துள்ளன.',
  }[_lang]!;

  // Scenario labels
  String get scenarioCoffeeLabel => const {
    'en': 'Daily Coffee',
    'hi': 'रोज़ाना कॉफी',
    'mr': 'दररोज कॉफी',
    'gu': 'રોજ કૉફી',
    'ta': 'தினசரி காபி',
  }[_lang]!;

  String get scenarioCoffeeDesc => const {
    'en': 'Skipping ₹50/day coffee and investing instead',
    'hi': '₹50/दिन की कॉफी छोड़कर निवेश करें',
    'mr': '₹50/दिवस कॉफी सोडून गुंतवणूक करा',
    'gu': '₹50/દિવસ કૉફી છોડીને રોકાણ કરો',
    'ta': '₹50/நாள் காபி தவிர்த்து முதலீடு செய்யுங்கள்',
  }[_lang]!;

  String get scenarioOttLabel => const {
    'en': 'OTT Subscriptions',
    'hi': 'OTT सब्स्क्रिप्शन',
    'mr': 'OTT सदस्यता',
    'gu': 'OTT સબ્સ્ક્રિપ્શન',
    'ta': 'OTT சந்தாக்கள்',
  }[_lang]!;

  String get scenarioOttDesc => const {
    'en': 'Cancelling extra streaming services you barely use',
    'hi': 'अनावश्यक स्ट्रीमिंग सेवाएं बंद करें',
    'mr': 'क्वचितच वापरल्या जाणाऱ्या स्ट्रीमिंग सेवा रद्द करा',
    'gu': 'ભાગ્યે જ વાપરો છો તે સ્ટ્રીમિંગ સેવા બંધ કરો',
    'ta': 'அரிதாக பயன்படுத்தும் ஸ்ட்ரீமிங் சேவைகளை ரத்து செய்யுங்கள்',
  }[_lang]!;

  String get scenarioShoppingLabel => const {
    'en': 'Impulse Shopping',
    'hi': 'आवेगशील खरीदारी',
    'mr': 'आवेगाने खरेदी',
    'gu': 'આવેગ ખરીદી',
    'ta': 'வெறித்தனமான கொள்முதல்',
  }[_lang]!;

  String get scenarioShoppingDesc => const {
    'en': 'One unplanned purchase you regret every month',
    'hi': 'हर महीने एक अनियोजित खरीदारी जिसका पछतावा होता है',
    'mr': 'दर महिना एक नियोजन नसलेली खरेदी जी नंतर पश्चाताप देते',
    'gu': 'દર મહિને એક અણધારી ખરીદી જે બાદ પछतावો થાય',
    'ta': 'மாதந்தோறும் ஒரு திட்டமிடப்படாத வாங்கல் வருத்தம் தரும்',
  }[_lang]!;

  String get scenarioDiningLabel => const {
    'en': 'Dining Out',
    'hi': 'बाहर खाना',
    'mr': 'बाहेर जेवणे',
    'gu': 'બહાર ખાવું',
    'ta': 'வெளியே சாப்பிடுவது',
  }[_lang]!;

  String get scenarioDiningDesc => const {
    'en': 'Eating out twice a week vs cooking at home',
    'hi': 'हफ्ते में दो बार बाहर खाना बनाम घर पर पकाना',
    'mr': 'आठवड्यातून दोनदा बाहेर जेवण विरुद्ध घरी स्वयंपाक',
    'gu': 'અઠવાડિયામાં બે વાર બહાર ખાવા vs ઘરે રસોઈ',
    'ta': 'வாரம் இருமுறை வெளியே சாப்பிடுவது vs வீட்டில் சமைப்பது',
  }[_lang]!;

  String get scenarioSipLabel => const {
    'en': 'SIP Investment',
    'hi': 'SIP निवेश',
    'mr': 'SIP गुंतवणूक',
    'gu': 'SIP રોકાણ',
    'ta': 'SIP முதலீடு',
  }[_lang]!;

  String scenarioSipDesc(String amount) => {
    'en': '10% of income (₹$amount) as monthly SIP',
    'hi': 'आय का 10% (₹$amount) मासिक SIP के रूप में',
    'mr': 'उत्पन्नाचे 10% (₹$amount) मासिक SIP म्हणून',
    'gu': 'આવકના 10% (₹$amount) માસિક SIP તરીકે',
    'ta': 'வருமானத்தின் 10% (₹$amount) மாதாந்திர SIP ஆக',
  }[_lang]!;

  String get scenarioEmergencyLabel => const {
    'en': 'Emergency Fund',
    'hi': 'आपातकालीन निधि',
    'mr': 'आपत्कालीन निधी',
    'gu': 'ઇમર્જન્સી ફંડ',
    'ta': 'அவசர நிதி',
  }[_lang]!;

  String get scenarioEmergencyDesc => const {
    'en': '5% saved monthly in liquid fund',
    'hi': 'मासिक आय का 5% लिक्विड फंड में बचत',
    'mr': 'मासिक उत्पन्नाचे 5% लिक्विड फंडात बचत',
    'gu': 'માસિક 5% લિક્વિડ ફંડમાં બચત',
    'ta': 'மாதந்தோறும் 5% லிக்விட் ஃபண்டில் சேமிப்பு',
  }[_lang]!;

  // Inflation card
  String get inflationTitle => const {
    'en': 'Inflation Reality Check',
    'hi': 'मुद्रास्फीति की वास्तविकता',
    'mr': 'महागाईची वास्तविकता',
    'gu': 'ફુગાવાની વાસ્તવિકતા',
    'ta': 'பணவீக்க உண்மை சோதனை',
  }[_lang]!;

  String inflationBody(String income, String adjusted, int years) => {
    'en': 'Your current income of $income will only buy goods worth $adjusted in $years years (at 6% inflation).',
    'hi': 'आपकी वर्तमान आय $income, $years वर्षों में केवल $adjusted के सामान ही खरीद पाएगी (6% महंगाई दर पर)।',
    'mr': 'तुमचे सध्याचे उत्पन्न $income, $years वर्षांनंतर फक्त $adjusted किमतीच्या वस्तू खरेदी करू शकेल (6% महागाई दराने).',
    'gu': 'તમારી વર્તમાન આવક $income, $years વર્ષ પછી ફક્ત $adjusted ના સામાન ખરીદી શકશે (6% ફુગાવા દરે).',
    'ta': 'உங்கள் தற்போதைய வருமானம் $income, $years ஆண்டுகளில் மட்டுமே $adjusted மதிப்புள்ள பொருட்களை வாங்க முடியும் (6% பணவீக்கத்தில்).',
  }[_lang]!;

  String get inflationCta => const {
    'en': '→ You need to grow wealth faster than inflation to stay ahead.',
    'hi': '→ आगे रहने के लिए महंगाई से तेज़ संपत्ति बढ़ानी होगी।',
    'mr': '→ पुढे राहण्यासाठी महागाईपेक्षा वेगाने संपत्ती वाढवावी लागेल.',
    'gu': '→ આગળ રહેવા માટે ફુગાવા કરતાં ઝડપી સંપત્તિ વધારવી પડશે.',
    'ta': '→ முன்னணியில் இருக்க பணவீக்கத்தை விட வேகமாக செல்வத்தை வளர்க்க வேண்டும்.',
  }[_lang]!;

  // ─────────────────── AI ADVISOR TAB ─────────────────────────────────────────
  String get advisorWelcome => const {
    'en': '🧠 Hi! I\'m MUNI, your AI financial advisor. Ask me anything about saving, investing, EMIs, or budgeting — I\'m here to help.',
    'hi': '🧠 नमस्ते! मैं MUNI हूँ, आपका AI वित्तीय सलाहकार। बचत, निवेश, EMI या बजट के बारे में कुछ भी पूछें।',
    'mr': '🧠 नमस्कार! मी MUNI आहे, तुमचा AI आर्थिक सल्लागार. बचत, गुंतवणूक, EMI किंवा बजेटबद्दल काहीही विचारा.',
    'gu': '🧠 નમસ્તે! હું MUNI છું, તમારો AI નાણાકીય સલાહકાર. બચત, રોકાણ, EMI અથવા બજેટ વિશે ગમે તે પૂછો.',
    'ta': '🧠 வணக்கம்! நான் MUNI, உங்கள் AI நிதி ஆலோசகர். சேமிப்பு, முதலீடு, EMI அல்லது பட்ஜெட் பற்றி எதையும் கேளுங்கள்.',
  }[_lang]!;

  String get clearChat => const {
    'en': 'Clear chat',
    'hi': 'चैट साफ करें',
    'mr': 'चॅट साफ करा',
    'gu': 'ચેટ સાફ કરો',
    'ta': 'அரட்டையை அழிக்க',
  }[_lang]!;

  String get muniIsTyping => const {
    'en': 'MUNI is thinking...',
    'hi': 'MUNI सोच रहा है...',
    'mr': 'MUNI विचार करत आहे...',
    'gu': 'MUNI વિચારી રહ્યો છે...',
    'ta': 'MUNI யோசிக்கிறது...',
  }[_lang]!;

  // Quick prompt labels (shown as chips)
  String get promptInvestLabel => const {
    'en': '📈 How to start investing?',
    'hi': '📈 निवेश कैसे शुरू करें?',
    'mr': '📈 गुंतवणूक कशी सुरू करावी?',
    'gu': '📈 રોકાણ કેવી રીતે શરૂ કરવું?',
    'ta': '📈 முதலீட்டை எவ்வாறு தொடங்குவது?',
  }[_lang]!;

  String get promptEmergencyLabel => const {
    'en': '🛡️ Build emergency fund',
    'hi': '🛡️ आपातकालीन फंड बनाएं',
    'mr': '🛡️ आपत्कालीन निधी तयार करा',
    'gu': '🛡️ ઇમર્જન્સી ફંડ બનાવો',
    'ta': '🛡️ அவசர நிதி உருவாக்க',
  }[_lang]!;

  String get promptEmiLabel => const {
    'en': '💳 Is this EMI worth it?',
    'hi': '💳 क्या यह EMI सही है?',
    'mr': '💳 हा EMI योग्य आहे का?',
    'gu': '💳 આ EMI યોગ્ય છે?',
    'ta': '💳 இந்த EMI மதிப்புள்ளதா?',
  }[_lang]!;

  String get promptSipFdLabel => const {
    'en': '📊 Compare SIP vs FD',
    'hi': '📊 SIP vs FD की तुलना',
    'mr': '📊 SIP vs FD तुलना करा',
    'gu': '📊 SIP vs FD ની સરખામણી',
    'ta': '📊 SIP vs FD ஒப்பீடு',
  }[_lang]!;

  String get prompt503020Label => const {
    'en': '💰 50-30-20 rule',
    'hi': '💰 50-30-20 नियम',
    'mr': '💰 50-30-20 नियम',
    'gu': '💰 50-30-20 નિયમ',
    'ta': '💰 50-30-20 விதி',
  }[_lang]!;

  String get promptLicLabel => const {
    'en': '🏦 LIC vs Term Insurance',
    'hi': '🏦 LIC vs टर्म इंश्योरेंस',
    'mr': '🏦 LIC vs टर्म विमा',
    'gu': '🏦 LIC vs ટર્મ ઇન્શ્યોરન્સ',
    'ta': '🏦 LIC vs டேர்ம் காப்பீடு',
  }[_lang]!;

  // Quick prompt query strings (the actual question sent to the AI)
  String get promptInvestQuery => const {
    'en': 'how should I start investing my salary',
    'hi': 'मुझे अपनी सैलरी का निवेश कैसे शुरू करना चाहिए',
    'mr': 'माझ्या पगारातून गुंतवणूक कशी सुरू करावी',
    'gu': 'મારે મારા પગારનું રોકાણ કેવી રીતે શરૂ કરવું',
    'ta': 'எனது சம்பளத்தை எவ்வாறு முதலீடு செய்யத் தொடங்குவது',
  }[_lang]!;

  String get promptEmergencyQuery => const {
    'en': 'how to save emergency fund',
    'hi': 'आपातकालीन फंड कैसे बचाएं',
    'mr': 'आपत्कालीन निधी कसा जमा करावा',
    'gu': 'ઇમર્જન્સી ફંડ કેવી રીતે બચાવવો',
    'ta': 'அவசர நிதியை எவ்வாறு சேமிப்பது',
  }[_lang]!;

  String get promptEmiQuery => const {
    'en': 'should I take an emi for this purchase',
    'hi': 'क्या मुझे इस खरीदारी के लिए EMI लेनी चाहिए',
    'mr': 'या खरेदीसाठी मी EMI घ्यावा का',
    'gu': 'શું મારે આ ખરીદી માટે EMI લેવી જોઈએ',
    'ta': 'இந்த கொள்முதலுக்கு EMI எடுக்க வேண்டுமா',
  }[_lang]!;

  String get promptSipFdQuery => const {
    'en': 'which is better sip or fd for long term',
    'hi': 'लंबी अवधि के लिए SIP बेहतर है या FD',
    'mr': 'दीर्घ मुदतीसाठी SIP की FD चांगले',
    'gu': 'લાંબા ગાળા માટે SIP સારું છે કે FD',
    'ta': 'நீண்ட காலத்திற்கு SIP சிறந்ததா அல்லது FD சிறந்ததா',
  }[_lang]!;

  String get prompt503020Query => const {
    'en': 'explain 50 30 20 rule for my salary',
    'hi': 'मेरी सैलरी के लिए 50 30 20 नियम समझाओ',
    'mr': 'माझ्या पगारासाठी 50 30 20 नियम समजावून सांगा',
    'gu': 'મારા પગાર માટે 50 30 20 નિયમ સમજાવો',
    'ta': 'என் சம்பளத்திற்கான 50 30 20 விதியை விளக்குங்கள்',
  }[_lang]!;

  String get promptLicQuery => const {
    'en': 'lic vs term insurance which is better',
    'hi': 'LIC बनाम टर्म इंश्योरेंस कौन बेहतर है',
    'mr': 'LIC विरुद्ध टर्म विमा कोणते चांगले',
    'gu': 'LIC vs ટર્મ ઇન્શ્યોરન્સ કયું સારું છે',
    'ta': 'LIC vs டேர்ம் காப்பீடு எது சிறந்தது',
  }[_lang]!;

  // ─────────────────── STRATEGY TAB ────────────────────────────────────────────
  String get strategyTitle => const {
    'en': '💰 Strategy',
    'hi': '💰 रणनीति',
    'mr': '💰 रणनीती',
    'gu': '💰 વ્યૂહ',
    'ta': '💰 உத்தி',
  }[_lang]!;

  String get strategySubtitle => const {
    'en': 'Your personalized money action plan',
    'hi': 'आपकी व्यक्तिगत पैसे की योजना',
    'mr': 'तुमची वैयक्तिक पैशाची कार्ययोजना',
    'gu': 'તમારી વ્યક્તિગત પૈસાની કાર્યયોજના',
    'ta': 'உங்கள் தனிப்பட்ட பண செயல் திட்டம்',
  }[_lang]!;

  // Allocation card
  String get moneyAllocation => const {
    'en': 'Money Allocation',
    'hi': 'पैसे का आवंटन',
    'mr': 'पैशाचे वाटप',
    'gu': 'પૈસાની ફાળવણી',
    'ta': 'பண ஒதுக்கீடு',
  }[_lang]!;

  String get needsLabel => const {
    'en': '🏠 Needs',
    'hi': '🏠 जरूरतें',
    'mr': '🏠 गरजा',
    'gu': '🏠 જરૂરિયાત',
    'ta': '🏠 தேவைகள்',
  }[_lang]!;

  String get needsHint => const {
    'en': 'Rent, food, transport',
    'hi': 'किराया, खाना, यातायात',
    'mr': 'भाडे, जेवण, वाहतूक',
    'gu': 'ભાડું, ખોરાક, વાહન',
    'ta': 'வாடகை, உணவு, போக்குவரத்து',
  }[_lang]!;

  String get investSaveLabel => const {
    'en': '📈 Invest & Save',
    'hi': '📈 निवेश और बचत',
    'mr': '📈 गुंतवणूक आणि बचत',
    'gu': '📈 રોકાણ અને બચત',
    'ta': '📈 முதலீடு & சேமிப்பு',
  }[_lang]!;

  String get investSaveHint => const {
    'en': 'SIP, FD, emergency fund',
    'hi': 'SIP, FD, आपातकालीन फंड',
    'mr': 'SIP, FD, आपत्कालीन निधी',
    'gu': 'SIP, FD, ઇમર્જન્સી ફંડ',
    'ta': 'SIP, FD, அவசர நிதி',
  }[_lang]!;

  String get wantsLabel => const {
    'en': '🎉 Wants',
    'hi': '🎉 इच्छाएं',
    'mr': '🎉 इच्छा',
    'gu': '🎉 ઇચ્છાઓ',
    'ta': '🎉 விருப்பங்கள்',
  }[_lang]!;

  String get wantsHint => const {
    'en': 'Entertainment, dining, travel',
    'hi': 'मनोरंजन, बाहर खाना, यात्रा',
    'mr': 'मनोरंजन, बाहेर जेवणे, प्रवास',
    'gu': 'મનોરંજન, ડાઇનિંગ, સફર',
    'ta': 'பொழுதுபோக்கு, உணவகம், பயணம்',
  }[_lang]!;

  String allocationTip(String amount) => {
    'en': '💡 Invest before spending. Set up a ₹$amount SIP on your salary day.',
    'hi': '💡 खर्च से पहले निवेश करें। वेतन दिवस पर ₹$amount का SIP सेट करें।',
    'mr': '💡 खर्च करण्यापूर्वी गुंतवणूक करा. पगाराच्या दिवशी ₹$amount SIP लावा.',
    'gu': '💡 ખર્ચ કરતા પહેલા રોકાણ કરો. પગારના દિવસે ₹$amount SIP ગોઠવો.',
    'ta': '💡 செலவு செய்வதற்கு முன் முதலீடு செய்யுங்கள். சம்பள நாளில் ₹$amount SIP அமைக்கவும்.',
  }[_lang]!;

  // Goals section
  String get yourGoals => const {
    'en': 'Your Goals',
    'hi': 'आपके लक्ष्य',
    'mr': 'तुमची उद्दिष्टे',
    'gu': 'તમારા લક્ષ્ય',
    'ta': 'உங்கள் இலக்குகள்',
  }[_lang]!;

  String get trackMilestones => const {
    'en': 'Track your financial milestones',
    'hi': 'अपने वित्तीय लक्ष्यों को ट्रैक करें',
    'mr': 'तुमचे आर्थिक मैलाचे दगड ट्रॅक करा',
    'gu': 'તમારા નાણાકીય સીમાચિહ્નો ટ્રૅક કરો',
    'ta': 'உங்கள் நிதி மைல்கற்களை கண்காணியுங்கள்',
  }[_lang]!;

  String daysLeft(int d) => {
    'en': '$d days left',
    'hi': '$d दिन बचे',
    'mr': '$d दिवस बाकी',
    'gu': '$d દિવસ બાકી',
    'ta': '$d நாட்கள் மீதம்',
  }[_lang]!;

  String percentComplete(String pct) => {
    'en': '$pct% complete',
    'hi': '$pct% पूर्ण',
    'mr': '$pct% पूर्ण',
    'gu': '$pct% પૂર્ણ',
    'ta': '$pct% முடிந்தது',
  }[_lang]!;

  // Decision scorecard
  String get decisionScorecard => const {
    'en': 'Decision Scorecard',
    'hi': 'निर्णय स्कोरकार्ड',
    'mr': 'निर्णय स्कोरकार्ड',
    'gu': 'નિર્ણય સ્કોરકાર્ડ',
    'ta': 'முடிவு மதிப்பீடு',
  }[_lang]!;

  String get decisionScorecardSubtitle => const {
    'en': 'How your recent spending scores for ROI',
    'hi': 'आपका हालिया खर्च ROI के लिए कैसे स्कोर करता है',
    'mr': 'तुमचा अलीकडील खर्च ROI साठी कसा गुण मिळवतो',
    'gu': 'તમારો તાજેતરનો ખર્ચ ROI માટે કેવો સ્કોર કરે છે',
    'ta': 'உங்கள் சமீபத்திய செலவு ROI-க்கு எவ்வாறு மதிப்பிடப்படுகிறது',
  }[_lang]!;

  String get scoreExcellent => const {
    'en': 'Excellent',
    'hi': 'उत्कृष्ट',
    'mr': 'उत्कृष्ट',
    'gu': 'ઉત્કૃષ્ટ',
    'ta': 'சிறந்தது',
  }[_lang]!;

  String get scoreGood => const {
    'en': 'Good',
    'hi': 'अच्छा',
    'mr': 'चांगला',
    'gu': 'સારો',
    'ta': 'நல்லது',
  }[_lang]!;

  String get scoreNeutral => const {
    'en': 'Neutral',
    'hi': 'तटस्थ',
    'mr': 'तटस्थ',
    'gu': 'તટસ્થ',
    'ta': 'நடுநிலை',
  }[_lang]!;

  String get scoreReview => const {
    'en': 'Review',
    'hi': 'समीक्षा',
    'mr': 'पुनरावलोकन',
    'gu': 'સમીક્ષા',
    'ta': 'மதிப்பாய்வு',
  }[_lang]!;

  String get scoreBadMove => const {
    'en': 'Bad Move',
    'hi': 'गलत कदम',
    'mr': 'चुकीचे पाऊल',
    'gu': 'ખોટો નિર્ણય',
    'ta': 'தவறான முடிவு',
  }[_lang]!;

  String get addTxnForScores => const {
    'en': 'Add transactions to see your decision scores',
    'hi': 'अपने निर्णय स्कोर देखने के लिए लेनदेन जोड़ें',
    'mr': 'तुमचे निर्णय स्कोर पाहण्यासाठी व्यवहार जोडा',
    'gu': 'તમારા નિર્ણય સ્કોર જોવા વ્યવહારો ઉમેરો',
    'ta': 'உங்கள் முடிவு மதிப்பீடுகளை காண பரிவர்த்தனைகள் சேர்க்கவும்',
  }[_lang]!;

  // Wealth rules section
  String get wealthBuildingRules => const {
    'en': 'Wealth Building Rules',
    'hi': 'संपत्ति निर्माण के नियम',
    'mr': 'संपत्ती निर्माणाचे नियम',
    'gu': 'સંપત્તિ નિર્માણ નિયમો',
    'ta': 'செல்வ உருவாக்க விதிகள்',
  }[_lang]!;

  String get rule1Title => const {
    'en': 'Pay Yourself First',
    'hi': 'पहले खुद को भुगतान करें',
    'mr': 'आधी स्वतःला द्या',
    'gu': 'પહેલા પોતાને ચૂકવો',
    'ta': 'முதலில் உங்களுக்கே செலுத்துங்கள்',
  }[_lang]!;

  String get rule1Desc => const {
    'en': 'Invest before spending — set up an auto-SIP on salary day.',
    'hi': 'खर्च से पहले निवेश करें — वेतन दिवस पर ऑटो-SIP लगाएं।',
    'mr': 'खर्च करण्यापूर्वी गुंतवणूक करा — पगाराच्या दिवशी ऑटो-SIP लावा.',
    'gu': 'ખર્ચ કરતા પહેલા રોકાણ કરો — પગારના દિવસે ઓટો-SIP ગોઠવો.',
    'ta': 'செலவு செய்வதற்கு முன் முதலீடு செய்யுங்கள் — சம்பள நாளில் ஆட்டோ-SIP அமைக்கவும்.',
  }[_lang]!;

  String get rule2Title => const {
    'en': '6-Month Emergency Fund',
    'hi': '6 महीने का आपातकालीन फंड',
    'mr': '6 महिन्यांचा आपत्कालीन निधी',
    'gu': '6 મહિનાનો ઇમર્જન્સી ફંડ',
    'ta': '6 மாத அவசர நிதி',
  }[_lang]!;

  String get rule2Desc => const {
    'en': 'Never invest without 6 months of expenses secured.',
    'hi': '6 महीने के खर्च सुरक्षित किए बिना कभी निवेश न करें।',
    'mr': '6 महिन्यांचा खर्च सुरक्षित केल्याशिवाय गुंतवणूक करू नका.',
    'gu': '6 મહિનાના ખર્ચ સુરક્ષિત કર્યા વિના ક્યારેય રોકાણ ન કરો.',
    'ta': '6 மாத செலவுகளை பாதுகாக்காமல் முதலீடு செய்யாதீர்கள்.',
  }[_lang]!;

  String get rule3Title => const {
    'en': 'Equity > FD for 5Y+',
    'hi': '5 साल+ के लिए इक्विटी > FD',
    'mr': '5+ वर्षांसाठी Equity > FD',
    'gu': '5Y+ માટે Equity > FD',
    'ta': '5Y+ க்கு Equity > FD',
  }[_lang]!;

  String get rule3Desc => const {
    'en': 'Anything you don\'t need for 5+ years belongs in equity.',
    'hi': 'जो 5+ साल के लिए नहीं चाहिए वह इक्विटी में लगाएं।',
    'mr': '5+ वर्षांसाठी लागणार नाही ते इक्विटीत गुंतवा.',
    'gu': '5+ વર્ષ માટે જરૂર ન હોય તે equity માં રોકો.',
    'ta': '5+ ஆண்டுகளுக்கு தேவைப்படாதவை equity-ல் வைக்கவும்.',
  }[_lang]!;

  String get rule4Title => const {
    'en': 'No Lifestyle Inflation',
    'hi': 'जीवनशैली मुद्रास्फीति नहीं',
    'mr': 'जीवनशैली महागाई नको',
    'gu': 'જીવનશૈલી ફુગાવો નહીં',
    'ta': 'வாழ்க்கை முறை பணவீக்கம் வேண்டாம்',
  }[_lang]!;

  String get rule4Desc => const {
    'en': 'When income rises, increase investments — not spending.',
    'hi': 'जब आय बढ़े, निवेश बढ़ाएं — खर्च नहीं।',
    'mr': 'उत्पन्न वाढल्यावर गुंतवणूक वाढवा — खर्च नाही.',
    'gu': 'જ્યારે આવક વધે, રોકાણ વધારો — ખર્ચ નહીં.',
    'ta': 'வருமானம் அதிகரிக்கும்போது முதலீடுகளை அதிகரியுங்கள் — செலவை அல்ல.',
  }[_lang]!;

  String get rule5Title => const {
    'en': 'Automate Savings',
    'hi': 'बचत को स्वचालित करें',
    'mr': 'बचत स्वयंचलित करा',
    'gu': 'બચત ઓટોમેટ કરો',
    'ta': 'சேமிப்பை தானியங்கி செய்யுங்கள்',
  }[_lang]!;

  String get rule5Desc => const {
    'en': 'Manual saving always fails. Automate everything.',
    'hi': 'मैन्युअल बचत हमेशा विफल होती है। सब कुछ स्वचालित करें।',
    'mr': 'मॅन्युअल बचत नेहमी अपयशी ठरते. सर्व काही स्वयंचलित करा.',
    'gu': 'મૅન્યુઅલ બચત હંમેશા નિષ્ફળ જાય છે. બધું ઓટોમેટ કરો.',
    'ta': 'கைமுறை சேமிப்பு எப்போதும் தோல்வியடைகிறது. எல்லாவற்றையும் தானியங்கி செய்யுங்கள்.',
  }[_lang]!;

  // ─────────────────── COMMUNITY TAB ───────────────────────────────────────────
  String get communityTitle => const {
    'en': '👥 Community',
    'hi': '👥 समुदाय',
    'mr': '👥 समुदाय',
    'gu': '👥 સમુદાય',
    'ta': '👥 சமூகம்',
  }[_lang]!;

  String get communitySubtitle => const {
    'en': 'Your environment shapes your wealth',
    'hi': 'आपका माहौल आपकी संपत्ति को आकार देता है',
    'mr': 'तुमचे वातावरण तुमच्या संपत्तीला आकार देते',
    'gu': 'તમારું વાતાવરણ તમારી સંપત્તિને આકાર આપે છે',
    'ta': 'உங்கள் சூழல் உங்கள் செல்வத்தை வடிவமைக்கிறது',
  }[_lang]!;

  // User rank card
  String get yourRank => const {
    'en': '🏆 Your Rank',
    'hi': '🏆 आपकी रैंक',
    'mr': '🏆 तुमची रँक',
    'gu': '🏆 તમારો ક્રમ',
    'ta': '🏆 உங்கள் தரவரிசை',
  }[_lang]!;

  String get topPercent => const {
    'en': 'Top 10% this week',
    'hi': 'इस हफ्ते शीर्ष 10%',
    'mr': 'या आठवड्यात शीर्ष 10%',
    'gu': 'આ અઠવાડિયે ટોચ 10%',
    'ta': 'இந்த வாரம் முதல் 10%',
  }[_lang]!;

  String get savedThisWeek => const {
    'en': 'Saved this week',
    'hi': 'इस हफ्ते बचाया',
    'mr': 'या आठवड्यात बचत',
    'gu': 'આ અઠવાડિયે બચત',
    'ta': 'இந்த வாரம் சேமித்தது',
  }[_lang]!;

  String get circlesJoined => const {
    'en': 'Circles joined',
    'hi': 'जुड़े हुए सर्कल',
    'mr': 'सामील झालेले सर्कल',
    'gu': 'જોડાયેલ વર્તુળ',
    'ta': 'சேர்ந்த வட்டங்கள்',
  }[_lang]!;

  String get challengesActive => const {
    'en': 'Challenges active',
    'hi': 'सक्रिय चुनौतियां',
    'mr': 'सक्रिय आव्हाने',
    'gu': 'સક્રિય પડકારો',
    'ta': 'செயலில் உள்ள சவால்கள்',
  }[_lang]!;

  // Wealth circles section
  String get wealthCirclesTitle => const {
    'en': 'Wealth Circles',
    'hi': 'धन मंडल',
    'mr': 'संपत्ती मंडळ',
    'gu': 'સંપત્તિ વર્તુળ',
    'ta': 'செல்வ வட்டங்கள்',
  }[_lang]!;

  String get wealthCirclesSubtitle => const {
    'en': 'Group-based accountability for better habits',
    'hi': 'बेहतर आदतों के लिए समूह-आधारित जवाबदेही',
    'mr': 'चांगल्या सवयींसाठी गट-आधारित जबाबदारी',
    'gu': 'સારી ટેવો માટે જૂથ-આધારિત જવાબદારી',
    'ta': 'சிறந்த பழக்கங்களுக்கான குழு-அடிப்படை பொறுப்பு',
  }[_lang]!;

  String membersCount(int n) => {
    'en': '$n members',
    'hi': '$n सदस्य',
    'mr': '$n सदस्य',
    'gu': '$n સભ્ય',
    'ta': '$n உறுப்பினர்கள்',
  }[_lang]!;

  String get joinButton => const {
    'en': 'Join',
    'hi': 'जुड़ें',
    'mr': 'सामील व्हा',
    'gu': 'જોડાઓ',
    'ta': 'சேரு',
  }[_lang]!;

  // Circle names & taglines
  String get circle1Name => const {
    'en': 'Fresher Investors Club',
    'hi': 'फ्रेशर निवेशक क्लब',
    'mr': 'फ्रेशर गुंतवणूकदार क्लब',
    'gu': 'ફ્રેશર ઇન્વેસ્ટર ક્લબ',
    'ta': 'புதியவர் முதலீட்டாளர் கழகம்',
  }[_lang]!;

  String get circle1Tag => const {
    'en': 'Weekly SIP accountability',
    'hi': 'साप्ताहिक SIP जवाबदेही',
    'mr': 'साप्ताहिक SIP जबाबदारी',
    'gu': 'સાપ્તાહિક SIP જવાબદારી',
    'ta': 'வாராந்திர SIP பொறுப்பு',
  }[_lang]!;

  String get circle2Name => const {
    'en': '6-Month Fund Brigade',
    'hi': '6-महीने फंड ब्रिगेड',
    'mr': '6-महिने फंड ब्रिगेड',
    'gu': '6-મહિના ફંડ બ્રિગેડ',
    'ta': '6-மாத நிதி படை',
  }[_lang]!;

  String get circle2Tag => const {
    'en': 'Emergency fund builders',
    'hi': 'आपातकालीन फंड बनाने वाले',
    'mr': 'आपत्कालीन निधी निर्माते',
    'gu': 'ઇમર્જન્સી ફંડ બનાવનાર',
    'ta': 'அவசர நிதி உருவாக்குபவர்கள்',
  }[_lang]!;

  String get circle3Name => const {
    'en': 'Finance Learners',
    'hi': 'वित्त सीखने वाले',
    'mr': 'वित्त शिकणारे',
    'gu': 'ફાઇનાન્સ શીખનારા',
    'ta': 'நிதி கற்பவர்கள்',
  }[_lang]!;

  String get circle3Tag => const {
    'en': 'Daily finance education',
    'hi': 'दैनिक वित्त शिक्षा',
    'mr': 'दैनिक वित्त शिक्षण',
    'gu': 'દૈનિક ફાઇનાન્સ શિક્ષણ',
    'ta': 'தினசரி நிதி கல்வி',
  }[_lang]!;

  // Active Challenges section
  String get activeChallenges => const {
    'en': 'Active Challenges',
    'hi': 'सक्रिय चुनौतियां',
    'mr': 'सक्रिय आव्हाने',
    'gu': 'સક્રિય પડકારો',
    'ta': 'செயலில் உள்ள சவால்கள்',
  }[_lang]!;

  String get activeChallengesSubtitle => const {
    'en': 'Build good habits through competition',
    'hi': 'प्रतिस्पर्धा के जरिए अच्छी आदतें बनाएं',
    'mr': 'स्पर्धेद्वारे चांगल्या सवयी तयार करा',
    'gu': 'સ્પર્ધા દ્વારા સારી ટેવ બનાવો',
    'ta': 'போட்டியின் மூலம் நல்ல பழக்கங்களை உருவாக்குங்கள்',
  }[_lang]!;

  // Challenge titles, time-left, descriptions
  String get challenge1Title => const {
    'en': 'No-spend Weekend',
    'hi': 'बिना खर्च का वीकेंड',
    'mr': 'खर्च-मुक्त आठवड्याचा शेवट',
    'gu': 'ખર્ચ-મુક્ત વીકઍન્ડ',
    'ta': 'செலவில்லா வார இறுதி',
  }[_lang]!;

  String get challenge1Time => const {
    'en': '2 days left',
    'hi': '2 दिन बचे',
    'mr': '2 दिवस बाकी',
    'gu': '2 દિવસ બાકી',
    'ta': '2 நாட்கள் மீதம்',
  }[_lang]!;

  String get challenge1Desc => const {
    'en': 'Skip unnecessary spends this weekend',
    'hi': 'इस वीकेंड अनावश्यक खर्च से बचें',
    'mr': 'या आठवड्याच्या शेवटी अनावश्यक खर्च टाळा',
    'gu': 'આ વીકऍন्ड બિનજરૂરી ખર્ચ ટાળો',
    'ta': 'இந்த வார இறுதியில் தேவையற்ற செலவுகளை தவிர்க்கவும்',
  }[_lang]!;

  String get challenge2Title => const {
    'en': 'Brew at Home',
    'hi': 'घर पर बनाएं',
    'mr': 'घरी बनवा',
    'gu': 'ઘરે બનાવો',
    'ta': 'வீட்டிலேயே தயாரிக்கவும்',
  }[_lang]!;

  String get challenge2Time => const {
    'en': '12 days left',
    'hi': '12 दिन बचे',
    'mr': '12 दिवस बाकी',
    'gu': '12 દિવસ બાકી',
    'ta': '12 நாட்கள் மீதம்',
  }[_lang]!;

  String get challenge2Desc => const {
    'en': 'No café coffee for 21 days',
    'hi': '21 दिनों तक कैफे कॉफी नहीं',
    'mr': '21 दिवस कॅफे कॉफी नाही',
    'gu': '21 દિવસ કૅફે કૉફી નહીં',
    'ta': '21 நாட்கள் கஃபே காபி வேண்டாம்',
  }[_lang]!;

  String get challenge3Title => const {
    'en': '₹1K SIP Start',
    'hi': '₹1K SIP शुरुआत',
    'mr': '₹1K SIP सुरुवात',
    'gu': '₹1K SIP શરૂ',
    'ta': '₹1K SIP தொடக்கம்',
  }[_lang]!;

  String get challenge3Time => const {
    'en': '6 days left',
    'hi': '6 दिन बचे',
    'mr': '6 दिवस बाकी',
    'gu': '6 દિવસ બાકી',
    'ta': '6 நாட்கள் மீதம்',
  }[_lang]!;

  String get challenge3Desc => const {
    'en': 'Start your first SIP this month',
    'hi': 'इस महीने अपना पहला SIP शुरू करें',
    'mr': 'या महिन्यात तुमचा पहिला SIP सुरू करा',
    'gu': 'આ મહિને તમારો પ્રથમ SIP શરૂ કરો',
    'ta': 'இந்த மாதம் உங்கள் முதல் SIPயை தொடங்குங்கள்',
  }[_lang]!;

  String participantsCount(int n) => {
    'en': '$n people participating',
    'hi': '$n लोग भाग ले रहे हैं',
    'mr': '$n लोक सहभागी आहेत',
    'gu': '$n લોકો ભાગ લઈ રહ્યા છે',
    'ta': '$n பேர் பங்கேற்கிறார்கள்',
  }[_lang]!;

  // Leaderboard
  String get topSaversTitle => const {
    'en': '🏆 This Week\'s Top Savers',
    'hi': '🏆 इस हफ्ते के शीर्ष बचत करने वाले',
    'mr': '🏆 या आठवड्यातील सर्वोत्कृष्ट बचतकर्ते',
    'gu': '🏆 આ અઠવાડિયાના ટોચ બચત કરનારા',
    'ta': '🏆 இந்த வாரத்தின் சிறந்த சேமிப்பாளர்கள்',
  }[_lang]!;

  String get leaderYou => const {
    'en': 'You',
    'hi': 'आप',
    'mr': 'तुम्ही',
    'gu': 'તમે',
    'ta': 'நீங்கள்',
  }[_lang]!;

  String get leaderYourCity => const {
    'en': 'Your City',
    'hi': 'आपका शहर',
    'mr': 'तुमचे शहर',
    'gu': 'તમારું શહેર',
    'ta': 'உங்கள் நகரம்',
  }[_lang]!;

  // Wisdom section
  String get wisdomOfDay => const {
    'en': '🧠 Wealth Mindset of the Day',
    'hi': '🧠 दिन का धन मानसिकता',
    'mr': '🧠 आजचे संपत्ती मानसिकता विचार',
    'gu': '🧠 આજનો સંપત્તિ વિચાર',
    'ta': '🧠 இன்றைய செல்வ மனநிலை',
  }[_lang]!;

  List<String> get wisdomQuotes => [
    const {
      'en': '"The secret to wealth is simple: spend less than you earn and invest the rest." — Warren Buffett',
      'hi': '"धन का रहस्य सरल है: कमाई से कम खर्च करें और बाकी निवेश करें।" — वॉरेन बफे',
      'mr': '"संपत्तीचे रहस्य सोपे आहे: कमाईपेक्षा कमी खर्च करा आणि उरलेले गुंतवा." — वॉरेन बफेट',
      'gu': '"સંપત્તિ નો રહસ્ય સરળ છે: કમાણી કરતા ઓછo ખર્ચ કરો અને બાકી રોકાણ કરો." — Warren Buffett',
      'ta': '"செல்வத்தின் ரகசியம் எளிதானது: சம்பாதிப்பதை விட குறைவாக செலவழித்து மீதியை முதலீடு செய்யுங்கள்." — வாரன் பஃபெட்',
    }[_lang]!,
    const {
      'en': '"Invest in yourself. Your career is the engine of your wealth." — Paul Clitheroe',
      'hi': '"खुद में निवेश करें। आपका करियर आपकी संपत्ति का इंजन है।" — पॉल क्लिथेरो',
      'mr': '"स्वतःमध्ये गुंतवणूक करा. तुमची कारकीर्द तुमच्या संपत्तीचे इंजिन आहे." — पॉल क्लिथेरो',
      'gu': '"પોતામાં રોકાણ કરો. તમારી કારકિર્દી તમારી સંપત્તિ નું એન્જિન છે." — Paul Clitheroe',
      'ta': '"உங்களில் முதலீடு செய்யுங்கள். உங்கள் தொழில் உங்கள் செல்வத்தின் இயந்திரம்." — பால் க்ளித்தரோ',
    }[_lang]!,
    const {
      'en': '"Do not save what is left after spending, but spend what is left after saving." — Warren Buffett',
      'hi': '"खर्च के बाद जो बचे उसे मत बचाओ, बल्कि बचत के बाद जो बचे उसे खर्च करो।" — वॉरेन बफे',
      'mr': '"खर्चानंतर उरलेले बचवू नका, तर बचतीनंतर उरलेले खर्च करा." — वॉरेन बफेट',
      'gu': '"ખર્ચ કર્યા પછી જે બચ્યું તે ન બચાવો, પheld બચત કર્યા પછી જે બચ્યું ખર્ચ કરો." — Warren Buffett',
      'ta': '"செலவிட்ட பிறகு மிச்சமிருப்பதை சேமிக்காதீர்கள்; சேமித்த பிறகு மிச்சமிருப்பதை செலவழியுங்கள்." — வாரன் பஃபெட்',
    }[_lang]!,
  ];
}

// ─────────────────────────────────────────────────────────────────────────────
// Delegate
// ─────────────────────────────────────────────────────────────────────────────
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLocales
      .any((l) => l.languageCode == locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
