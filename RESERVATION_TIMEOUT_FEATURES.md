# Fonctionnalités de Timeout pour les Réservations

## Vue d'ensemble

Ce document décrit les nouvelles fonctionnalités ajoutées pour gérer les unités réservées trop longtemps dans l'application Khatma.

## Nouvelles Fonctionnalités

### 1. Paramètres Configurables de Timeout

Deux nouveaux champs ont été ajoutés au modèle `SharedKhatma`:

```dart
@Default(7) int reservationWarningDays,        // Afficher un avertissement après X jours
int? reservationExpirationDays,                // Libérer automatiquement après X jours (null = jamais)
```

**Utilisation:**
- `reservationWarningDays`: Nombre de jours après lequel un avertissement visuel apparaît (par défaut: 7 jours)
- `reservationExpirationDays`: Nombre de jours après lequel l'unité est automatiquement libérée (null = pas d'expiration automatique)

### 2. Suivi des Rappels

Le modèle `SharedKhatmaUnit` a été enrichi avec:

```dart
DateTime? lastReminderSent,  // Suivi de l'envoi des rappels
```

### 3. Méthodes Utilitaires pour les Unités

Nouvelles méthodes ajoutées à `SharedKhatmaUnit`:

```dart
// Retourne le nombre de jours depuis la réservation
int? get daysSinceReserved

// Vérifie si l'unité doit afficher un avertissement
bool shouldShowWarning(int warningThresholdDays)

// Vérifie si l'unité a expiré et doit être libérée
bool hasExpired(int? expirationDays)
```

### 4. Indicateurs Visuels d'Avertissement

Lorsqu'une unité est réservée depuis trop longtemps:

#### Bordure Orange
- Une bordure orange de 2px entoure la tuile de l'unité

#### Badge d'Avertissement
- Un badge orange avec une icône d'avertissement apparaît sur l'avatar de l'unité

#### Texte Coloré
- Le sous-titre affiche "X jours de retard" en orange
- Le texte est en gras pour attirer l'attention

```dart
// Exemple visuel:
┌─────────────────────────────────────┐
│ [⚠️ 5]  Hizb 5                      │
│         Réservé le: 2025-01-05      │
│         • 7 jours de retard         │  ← Orange et gras
└─────────────────────────────────────┘
   ↑ Badge d'avertissement
```

### 5. Actions Admin (Long Press)

Les créateurs et administrateurs peuvent faire un appui long sur une unité en retard pour afficher un menu avec:

#### Envoyer un Rappel
```dart
onSendReminder: () => _sendReminder(unit, controller)
```
- Envoie une notification au membre qui a réservé l'unité
- Affiche un message de confirmation

#### Libérer l'Unité
```dart
onFreeUnit: () => _freeUnit(unit, controller)
```
- Libère manuellement l'unité réservée
- Demande une confirmation avant l'action
- Affiche un message de succès

### 6. Widget UnitTile Amélioré

Nouveaux paramètres ajoutés au widget `UnitTile`:

```dart
UnitTile(
  unit: unit,
  onTap: onTapCallback,
  reservationWarningDays: 7,              // Seuil d'avertissement
  isUserAdminOrCreator: true,             // Activer les actions admin
  onSendReminder: () => sendReminder(),   // Callback pour envoyer un rappel
  onFreeUnit: () => freeUnit(),           // Callback pour libérer l'unité
)
```

## Traductions Ajoutées

Les nouvelles clés de traduction dans `app_*.arb`:

| Clé | Français | English | العربية |
|-----|----------|---------|---------|
| `reservationOverdue` | Réservation en retard | Reservation overdue | الحجز متأخر |
| `daysOverdue` | {days} jours de retard | {days} days overdue | متأخر {days} أيام |
| `sendReminder` | Envoyer un rappel | Send reminder | إرسال تذكير |
| `freeUnit` | Libérer l'unité | Free unit | تحرير الوحدة |
| `confirmFreeUnit` | Êtes-vous sûr de vouloir libérer cette unité? | Are you sure you want to free this unit? | هل أنت متأكد من أنك تريد تحرير هذه الوحدة؟ |
| `unitFreedSuccess` | L'unité a été libérée avec succès | Unit freed successfully | تم تحرير الوحدة بنجاح |
| `reminderSentSuccess` | Rappel envoyé avec succès | Reminder sent successfully | تم إرسال التذكير بنجاح |

## Prochaines Étapes (TODO)

### 1. Régénérer les Fichiers Freezed
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 2. Régénérer les Fichiers de Localisation
```bash
flutter gen-l10n
```

### 3. Implémenter la Logique Backend

#### a. Vérification des Rôles Utilisateur
```dart
// Dans khatma_details_page.dart
bool _isUserAdminOrCreator(KhatmaDetailsState state) {
  final currentUserId = ref.read(authProvider).currentUserId;
  return currentUserId == state.khatma.creatorId ||
         state.khatma.participants
             .firstWhere((p) => p.userId == currentUserId)
             .role == ParticipantRole.admin;
}
```

#### b. Envoyer un Rappel
```dart
// Dans khatma_details_controller.dart
Future<void> sendReminderForUnit(SharedKhatmaUnit unit) async {
  // 1. Créer une notification push
  // 2. Envoyer un email (optionnel)
  // 3. Mettre à jour lastReminderSent
  final updatedUnit = unit.copyWith(
    lastReminderSent: DateTime.now(),
  );
  // 4. Sauvegarder dans Firestore
}
```

#### c. Libérer une Unité
```dart
// Dans khatma_details_controller.dart
Future<void> freeUnit(SharedKhatmaUnit unit) async {
  final freedUnit = unit.copyWith(
    status: UnitStatus.free,
    reservedByUserId: null,
    reservedByUserName: null,
    reservedDate: null,
  );
  // Sauvegarder dans Firestore
}
```

#### d. Expiration Automatique (Tâche Planifiée)
```dart
// Cloud Function ou Service Background
void checkExpiredReservations() async {
  final khatmas = await getAllActiveKhatmas();

  for (final khatma in khatmas) {
    if (khatma.reservationExpirationDays == null) continue;

    for (final unit in khatma.units) {
      if (unit.hasExpired(khatma.reservationExpirationDays)) {
        // Libérer automatiquement
        await freeUnit(unit);

        // Envoyer une notification à l'utilisateur
        await sendExpirationNotification(unit.reservedByUserId);
      }
    }
  }
}
```

## Flux d'Utilisation

### Scénario 1: Unité Normale
1. Utilisateur réserve une unité
2. Aucun avertissement pendant les 7 premiers jours
3. Utilisateur complète la lecture et marque l'unité comme complétée

### Scénario 2: Unité en Retard (Warning)
1. Utilisateur réserve une unité
2. Après 7 jours, une bordure orange apparaît
3. Le sous-titre affiche "7 jours de retard" en orange
4. Un badge d'avertissement apparaît sur l'avatar

### Scénario 3: Action Admin
1. Admin voit une unité en retard (bordure orange)
2. Admin fait un appui long sur l'unité
3. Menu contextuel s'affiche avec 2 options:
   - **Envoyer un rappel**: Notifie le membre
   - **Libérer l'unité**: Libère manuellement l'unité
4. Admin choisit une action
5. Message de confirmation s'affiche

### Scénario 4: Expiration Automatique
1. Unité réservée depuis 14 jours (si expirationDays = 14)
2. Tâche planifiée détecte l'expiration
3. Unité automatiquement libérée
4. Notification envoyée à l'utilisateur

## Configuration Recommandée

### Khatma Courte Durée (1 semaine)
```dart
SharedKhatma(
  reservationWarningDays: 2,    // Avertir après 2 jours
  reservationExpirationDays: 4, // Expirer après 4 jours
)
```

### Khatma Durée Moyenne (1 mois)
```dart
SharedKhatma(
  reservationWarningDays: 7,     // Avertir après 7 jours
  reservationExpirationDays: 14, // Expirer après 14 jours
)
```

### Khatma Longue Durée (Ramadan)
```dart
SharedKhatma(
  reservationWarningDays: 10,    // Avertir après 10 jours
  reservationExpirationDays: 20, // Expirer après 20 jours
)
```

### Khatma Sans Expiration
```dart
SharedKhatma(
  reservationWarningDays: 7,
  reservationExpirationDays: null, // Jamais expirer automatiquement
)
```

## Fichiers Modifiés

1. **lib/src/features/shared_khatma/domain/shared_khatma.dart**
   - Ajout de `reservationWarningDays` et `reservationExpirationDays`
   - Ajout de `lastReminderSent` à `SharedKhatmaUnit`
   - Ajout des méthodes utilitaires

2. **lib/src/features/shared_khatma/presentation/widgets/unit_tile.dart**
   - Ajout des indicateurs visuels d'avertissement
   - Ajout du menu contextuel pour les actions admin
   - Support du long press pour les admins

3. **lib/src/features/shared_khatma/presentation/khatma_details_page.dart**
   - Ajout des callbacks pour les actions admin
   - Intégration des nouveaux paramètres au widget UnitTile

4. **lib/src/i18n/app_*.arb**
   - Ajout de 7 nouvelles clés de traduction

## Tests Suggérés

1. **Test d'Avertissement Visuel**
   - Créer une unité avec une date de réservation ancienne
   - Vérifier que la bordure orange apparaît
   - Vérifier que le badge d'avertissement est visible

2. **Test du Menu Admin**
   - Se connecter en tant qu'admin
   - Faire un appui long sur une unité en retard
   - Vérifier que le menu s'affiche correctement

3. **Test d'Expiration**
   - Créer une unité avec une date d'expiration dépassée
   - Exécuter la fonction de vérification
   - Vérifier que l'unité est libérée automatiquement

4. **Test de Localisation**
   - Tester l'application en français, anglais et arabe
   - Vérifier que tous les textes sont correctement traduits
