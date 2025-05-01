// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Khatma';

  @override
  String get newKhatma => 'Nouvelle khatma';

  @override
  String get editKhatma => 'Éditer la khatma';

  @override
  String get recurrence => 'Récurrence';

  @override
  String get schedule => 'Calendrier';

  @override
  String get name => 'Nom';

  @override
  String get nameHint => 'Entrez le nom de la Khatma';

  @override
  String get descriptionHint => 'Entrez une description (facultatif)';

  @override
  String get description => 'Description';

  @override
  String get share => 'Partager';

  @override
  String get splitUnit => 'Unité de division';

  @override
  String get add => 'Ajouter';

  @override
  String get create => 'Créer';

  @override
  String get apply => 'Appliquer';

  @override
  String get save => 'Sauvegarder';

  @override
  String get cancel => 'Annuler';

  @override
  String get edit => 'Modifier';

  @override
  String get close => 'Fermer';

  @override
  String get delete => 'Supprimer';

  @override
  String get ok => 'OK';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get next => 'Suivant';

  @override
  String get submit => 'Soumettre';

  @override
  String get previous => 'Précédent';

  @override
  String get finish => 'Terminer';

  @override
  String get copy => 'Copier';

  @override
  String get copied => 'Copié';

  @override
  String get copiedToClipboard => 'Copié dans le presse-papiers';

  @override
  String get shareKhatma => 'Partager la khatma';

  @override
  String get loading => 'Chargement';

  @override
  String get loadingKhatma => 'Chargement de la khatma';

  @override
  String get loadingKhatmaList => 'Chargement de la liste des khatmas';

  @override
  String get startDate => 'Date de début';

  @override
  String get endDate => 'Date de fin';

  @override
  String get every => 'Chaque';

  @override
  String get repeat => 'Répéter';

  @override
  String get noRepeat => 'Pas de répétition';

  @override
  String get autoRepeatDescription => 'Reprise automatique après achèvement';

  @override
  String repeatEverySelectedDaysDescription(Object count, Object days) {
    return 'La khatma sera répétée tous les $days pour chaque $count semaines';
  }

  @override
  String repeatEverySelectedDayDescription(Object days) {
    return 'La khatma sera répétée tous les $days pour chaque semaine';
  }

  @override
  String repeatEveryTimePeriodsDescription(Object count, Object unit) {
    return 'La khatma sera répétée tous les $count ${unit}s';
  }

  @override
  String repeatEveryTimePeriodDescription(Object unit) {
    return 'La khatma sera répétée tous les $unit';
  }

  @override
  String get noRepeatDescription => 'Cette khatma ne se renouvellera pas';

  @override
  String get repeatDescription => 'Re-création active de la khatma';

  @override
  String get repeatEvery => 'Répéter tous les';

  @override
  String get icon => 'Icône';

  @override
  String get color => 'Couleur';

  @override
  String get chooseColor => 'Choisir la couleur';

  @override
  String get chooseIcon => 'Choisir l\'icône';

  @override
  String get khatmaList => 'Liste des khatmas';

  @override
  String get quran => 'Coran';

  @override
  String get khatma => 'Khatma';

  @override
  String get home => 'Accueil';

  @override
  String get settings => 'Paramètres';

  @override
  String get about => 'À propos';

  @override
  String get language => 'Langue';

  @override
  String get chooseLanguage => 'Choisir la langue';

  @override
  String get chooseTheme => 'Choisir le thème';

  @override
  String get readMode => 'Mode de lecture';

  @override
  String get readLess => 'Lire moins';

  @override
  String get showMore => 'montrer plus';

  @override
  String get showLess => 'montrer moins';

  @override
  String get completed => 'Terminé';

  @override
  String get completedParts => 'Parties complétées';

  @override
  String get remainingParts => 'Parties restantes';

  @override
  String get parts => 'Parties';

  @override
  String readedParts(Object count) {
    return '$count parties';
  }

  @override
  String get confirmDelete => 'Êtes-vous sûr de vouloir supprimer cette khatma ?';

  @override
  String successCompleteParts(Object count) {
    return '$count parties complétées avec succès';
  }

  @override
  String remainingPartsOfTotal(Object remaining, Object total) {
    return '$remaining sur $total parties';
  }

  @override
  String completeParts(Object count) {
    return 'Compléter ($count parties)';
  }

  @override
  String get chooseKhatmaStyle => 'Choisissez le style de votre khatma';

  @override
  String get khatmaStyle => 'Style de Khatma';

  @override
  String khatmaSplitUnit(String unit) {
    String _temp0 = intl.Intl.selectLogic(
      unit,
      {
        'sourat': 'Sourate',
        'juzz': 'Juzz',
        'hizb': 'Hizb',
        'half': 'Demi-Hizb',
        'rubue': 'Quart de Hizb',
        'thumun': 'Huitième de Hizb',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String khatmaSplitUnitDesc(String unit) {
    String _temp0 = intl.Intl.selectLogic(
      unit,
      {
        'sourat': 'Sourate (114 parties)',
        'juzz': 'Juzz (30 parties)',
        'hizb': 'Hizb (60 parties)',
        'half': 'Demi-Hizb (120 parties)',
        'rubue': 'Quart de Hizb (240 parties)',
        'thumun': 'Huitième de Hizb (480 parties)',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String repeatInterval(String recurrence) {
    String _temp0 = intl.Intl.selectLogic(
      recurrence,
      {
        'auto': 'Auto',
        'daily': 'Jour',
        'weekly': 'Semaine',
        'monthly': 'Mois',
        'yearly': 'Année',
        'other': 'Autre',
      },
    );
    return '$_temp0';
  }

  @override
  String timePeriods(String period) {
    String _temp0 = intl.Intl.selectLogic(
      period,
      {
        'daily': 'Jour',
        'weekly': 'Semaine',
        'monthly': 'Mois',
        'yearly': 'Année',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String weekDay(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': 'Lundi',
        '2': 'Mardi',
        '3': 'Mercredi',
        '4': 'Jeudi',
        '5': 'Vendredi',
        '6': 'Samedi',
        '7': 'Dimanche',
        'other': 'Autre',
      },
    );
    return '$_temp0';
  }

  @override
  String shortWeekDay(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': 'L',
        '2': 'M',
        '3': 'M',
        '4': 'J',
        '5': 'V',
        '6': 'S',
        '7': 'D',
        'other': 'A',
      },
    );
    return '$_temp0';
  }

  @override
  String repeatOption(String scheduler) {
    String _temp0 = intl.Intl.selectLogic(
      scheduler,
      {
        'true': 'La répétition automatique est activée',
        'false': 'La répétition automatique est désactivée',
        'other': 'Autre',
      },
    );
    return '$_temp0';
  }

  @override
  String shareVisibility(String share) {
    String _temp0 = intl.Intl.selectLogic(
      share,
      {
        'other': 'Privé',
        'public': 'Public',
        'group': 'Groupe',
      },
    );
    return '$_temp0';
  }

  @override
  String shareVisibilityDesc(String share) {
    String _temp0 = intl.Intl.selectLogic(
      share,
      {
        'other': 'Cette khatma est privée',
        'public': 'Tout le monde peut accéder et participer',
        'group': 'Partagé seulement par code ou QR code',
      },
    );
    return '$_temp0';
  }

  @override
  String shareVisibilityDescription(String share) {
    String _temp0 = intl.Intl.selectLogic(
      share,
      {
        'other': 'La khatma restera privée et exclusive à l\'organisateur',
        'public': 'Tout le monde est invité à accéder et rejoindre la khatma',
        'group': 'La khatma sera partagée uniquement avec ceux qui reçoivent un numéro spécifique ou un QR code',
      },
    );
    return '$_temp0';
  }

  @override
  String maxParticipants(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# participants',
      one: '1 participant',
      zero: 'Pas de participants',
    );
    return '$_temp0';
  }

  @override
  String get maxPartToRead => 'Lecture maximale autorisée';

  @override
  String get maxPartToReserve => 'Réservations simultanées';

  @override
  String get title => 'Titre';

  @override
  String get areYouSure => 'Êtes-vous sûr ?';

  @override
  String get confirmDeleteKhatma => 'Après suppression, cette khatma sera définitivement supprimée';

  @override
  String get congratulation => 'Félicitations !';

  @override
  String get emailInputLabel => 'Entrez votre email';

  @override
  String get passwordInputLabel => 'Entrez votre mot de passe';

  @override
  String themeMode(String mode) {
    String _temp0 = intl.Intl.selectLogic(
      mode,
      {
        'light': 'Clair',
        'dark': 'Sombre',
        'system': 'Système',
        'other': 'Système',
      },
    );
    return '$_temp0';
  }

  @override
  String get theme => 'Thème';
}
