# Cas de Test - Avertissements de Réservation

Ce document décrit les cas de test ajoutés dans `SharedKhatmaMockData` pour tester les fonctionnalités d'avertissement de réservation.

## 📋 Vue d'ensemble

Deux Khatmas de test ont été ajoutées avec différentes configurations pour tester les avertissements:

1. **"Test Khatma - Cas d'Avertissements"** (ID: 0) - Tests standards avec durées normales
2. **"Test Khatma - Avertissements Rapides"** (ID: 3) - Tests avec durées courtes

---

## 🧪 Khatma 1: Cas d'Avertissements Standards

### Configuration
```dart
id: '0'
reservationWarningDays: 7    // Avertissement après 7 jours
reservationExpirationDays: 14 // Expiration après 14 jours
maxReservationsPerUser: 5
```

### Cas de Test

| Unité | Statut | Réservé depuis | État attendu | Description |
|-------|--------|---------------|--------------|-------------|
| **1** | `reserved` | 20 jours | 🔴 **EXPIRÉ** | Devrait être libéré automatiquement |
| **2** | `reserved` | 15 jours | 🔴 **EXPIRÉ** | Dépasse le seuil d'expiration (14j) |
| **3** | `reserved` | 10 jours | 🟠 **EN RETARD** | Avertissement + rappel envoyé il y a 3j |
| **4** | `reservedByCurrentUser` | 8 jours | 🟠 **EN RETARD** | Juste au-dessus du seuil (7j) |
| **5** | `reserved` | 6 jours | 🟢 **OK** | Pas encore d'avertissement |
| **6** | `reservedByCurrentUser` | 3 jours | 🟢 **OK** | Récente, pas d'avertissement |
| **7** | `reserved` | 1 jour | 🟢 **OK** | Très récente |
| **8** | `completed` | - | ✅ **COMPLÉTÉ** | Complété il y a 5 jours |
| 9-30 | `free` | - | ⚪ **LIBRE** | Disponible à la réservation |

### Comportements Visuels Attendus

#### Unité 1 (20 jours - EXPIRÉ)
```
┌─────────────────────────────────────────┐
│ ⚠️[1]  Juz 1                     🔒     │  ← Badge d'avertissement + Bordure orange
│        Réservé le: [date]               │
│        • 20 jours de retard        ↓    │  ← Texte orange et gras
│                              Fatima Ali  │  ← Nom du membre
└─────────────────────────────────────────┘
```
**Actions admin disponibles** (long press):
- Envoyer un rappel
- Libérer l'unité

#### Unité 4 (8 jours - JUSTE EN RETARD)
```
┌─────────────────────────────────────────┐
│ ⚠️[4]  Juz 4                     ✓      │  ← Badge + Bordure orange
│        Réservé le: [date]               │
│        • 8 jours de retard         ↓    │  ← Texte orange et gras
│                                    Vous  │
└─────────────────────────────────────────┘
```

#### Unité 6 (3 jours - OK)
```
┌─────────────────────────────────────────┐
│  [6]   Juz 6                     ✓      │  ← Pas de badge, bordure normale
│        Réservé le: [date]          ↓    │  ← Texte normal
│                                    Vous  │
└─────────────────────────────────────────┘
```

---

## ⚡ Khatma 2: Avertissements Rapides

### Configuration
```dart
id: '3'
reservationWarningDays: 2     // Avertissement après 2 jours
reservationExpirationDays: 4  // Expiration après 4 jours
maxReservationsPerUser: 3
unit: SplitUnit.hizb
```

### Cas de Test

| Unité | Statut | Réservé depuis | État attendu | Description |
|-------|--------|---------------|--------------|-------------|
| **1** | `reserved` | 5 jours | 🔴 **EXPIRÉ** | Dépasse expiration (4j) |
| **2** | `reservedByCurrentUser` | 3 jours | 🟠 **EN RETARD** | Au-dessus de warning (2j) |
| **3** | `reserved` | 1 jour | 🟢 **OK** | En dessous du seuil |
| 4-20 | `free` | - | ⚪ **LIBRE** | Disponible |

### Utilisation

Ce cas de test est **idéal pour le développement** car:
- Les avertissements apparaissent rapidement (après 2 jours au lieu de 7)
- L'expiration se produit rapidement (après 4 jours au lieu de 14)
- Permet de tester rapidement sans attendre longtemps

---

## 🧩 Tests à Effectuer

### 1. Test Visuel d'Avertissement
**Objectif**: Vérifier que les indicateurs visuels s'affichent correctement

**Étapes**:
1. Ouvrir "Test Khatma - Cas d'Avertissements"
2. Vérifier que les unités 1, 2, 3, 4 ont:
   - Une bordure orange
   - Un badge d'avertissement (⚠️) sur l'avatar
   - Le texte "X jours de retard" en orange et gras
3. Vérifier que les unités 5, 6, 7 n'ont PAS d'avertissement

**Résultat attendu**: Avertissements visuels corrects pour les unités en retard uniquement

---

### 2. Test Menu Admin (Long Press)
**Objectif**: Vérifier que les actions admin sont disponibles

**Étapes**:
1. Se connecter en tant qu'admin (creator1 ou modifier `_isUserAdminOrCreator` pour retourner `true`)
2. Faire un **appui long** sur l'unité 1 (20 jours)
3. Vérifier que le menu s'affiche avec:
   - "Envoyer un rappel" avec nom du membre
   - "Libérer l'unité"

**Résultat attendu**: Menu contextuel s'affiche avec les 2 options

---

### 3. Test Calcul des Jours
**Objectif**: Vérifier que `daysSinceReserved` calcule correctement

**Étapes**:
1. Pour chaque unité réservée, vérifier:
   ```dart
   final unit = khatma.units[0]; // Unité 1
   print('Days since reserved: ${unit.daysSinceReserved}'); // Devrait être ~20
   print('Should show warning: ${unit.shouldShowWarning(7)}'); // true
   print('Has expired: ${unit.hasExpired(14)}'); // true
   ```

**Résultat attendu**:
- Unité 1: `daysSinceReserved = 20`, `shouldShowWarning = true`, `hasExpired = true`
- Unité 4: `daysSinceReserved = 8`, `shouldShowWarning = true`, `hasExpired = false`
- Unité 6: `daysSinceReserved = 3`, `shouldShowWarning = false`, `hasExpired = false`

---

### 4. Test Envoi de Rappel
**Objectif**: Vérifier que l'envoi de rappel fonctionne

**Étapes**:
1. Faire un appui long sur une unité en retard
2. Sélectionner "Envoyer un rappel"
3. Vérifier le message de succès

**Résultat attendu**:
- SnackBar vert avec "Rappel envoyé avec succès"
- (TODO: Vérifier que `lastReminderSent` est mis à jour)

---

### 5. Test Libération d'Unité
**Objectif**: Vérifier que la libération manuelle fonctionne

**Étapes**:
1. Faire un appui long sur une unité en retard
2. Sélectionner "Libérer l'unité"
3. Confirmer dans le dialogue
4. Vérifier le message de succès

**Résultat attendu**:
- Dialogue de confirmation s'affiche
- SnackBar vert avec "L'unité a été libérée avec succès"
- (TODO: Vérifier que l'unité passe à `UnitStatus.free`)

---

### 6. Test Expiration Automatique
**Objectif**: Vérifier la détection des unités expirées

**Étapes**:
1. Pour les unités 1 et 2, vérifier:
   ```dart
   final unit1 = khatma.units[0];
   print('Has expired: ${unit1.hasExpired(14)}'); // true
   ```
2. Implémenter la fonction de vérification automatique (Cloud Function ou service background)
3. Vérifier que les unités expirées sont libérées

**Résultat attendu**: Les unités dépassant `reservationExpirationDays` sont identifiées correctement

---

### 7. Test Khatma Rapide
**Objectif**: Tester avec des durées courtes

**Étapes**:
1. Ouvrir "Test Khatma - Avertissements Rapides" (ID: 3)
2. Vérifier que l'unité 1 (5j) est marquée comme EXPIRÉE
3. Vérifier que l'unité 2 (3j) affiche un avertissement
4. Vérifier que l'unité 3 (1j) n'a PAS d'avertissement

**Résultat attendu**: Les seuils de 2 et 4 jours sont correctement appliqués

---

## 🔧 Configuration pour les Tests

### Activer le Mode Admin
Pour tester les actions admin, modifier temporairement:

```dart
// Dans khatma_details_page.dart
bool _isUserAdminOrCreator(KhatmaDetailsState state) {
  return true; // Force admin mode pour les tests
}
```

### Ajuster les Durées
Pour tester avec différentes durées:

```dart
SharedKhatma(
  reservationWarningDays: 1,  // Avertir après 1 jour
  reservationExpirationDays: 2, // Expirer après 2 jours
)
```

---

## 📊 Tableau Récapitulatif

### États Possibles

| État | Condition | Bordure | Badge | Couleur Texte | Actions Admin |
|------|-----------|---------|-------|---------------|---------------|
| **EXPIRÉ** | `days >= expirationDays` | 🟠 Orange | ⚠️ Oui | 🟠 Orange | ✅ Oui |
| **EN RETARD** | `days >= warningDays` | 🟠 Orange | ⚠️ Oui | 🟠 Orange | ✅ Oui |
| **OK** | `days < warningDays` | ⚪ Normale | ❌ Non | ⚪ Normal | ❌ Non |
| **COMPLÉTÉ** | `status == completed` | ⚪ Normale | ❌ Non | ⚪ Normal | ❌ Non |
| **LIBRE** | `status == free` | ⚪ Normale | ❌ Non | ⚪ Normal | ❌ Non |

---

## 🎯 Checklist de Validation

- [ ] Les bordures orange s'affichent pour les unités en retard
- [ ] Les badges d'avertissement apparaissent correctement
- [ ] Le texte "X jours de retard" s'affiche en orange et gras
- [ ] Le menu contextuel (long press) fonctionne pour les admins
- [ ] L'option "Envoyer un rappel" affiche un message de succès
- [ ] L'option "Libérer l'unité" affiche une confirmation puis un succès
- [ ] Les calculs de jours sont corrects (daysSinceReserved)
- [ ] Les méthodes `shouldShowWarning()` et `hasExpired()` retournent les bonnes valeurs
- [ ] Les unités OK (< 7 jours) n'ont PAS d'avertissement
- [ ] Les unités complétées n'ont PAS d'avertissement
- [ ] La Khatma rapide (2j/4j) fonctionne correctement

---

## 🐛 Problèmes Connus / À Résoudre

1. **Fichiers Freezed non régénérés**: Exécuter `flutter pub run build_runner build --delete-conflicting-outputs`
2. **Localisations non générées**: Exécuter `flutter gen-l10n`
3. **Vérification des rôles**: Implémenter `_isUserAdminOrCreator()` avec la vraie logique
4. **Envoi de rappel**: Implémenter `controller.sendReminderForUnit()`
5. **Libération d'unité**: Implémenter `controller.freeUnit()`
6. **Expiration automatique**: Créer une Cloud Function ou service background

---

## 📝 Notes pour les Développeurs

### Créer de Nouveaux Cas de Test

Pour ajouter un nouveau cas de test:

```dart
SharedKhatmaUnit(
  unitNumber: X,
  status: UnitStatus.reserved,
  reservedByUserId: 'userY',
  reservedByUserName: 'Nom du Membre',
  reservedDate: DateTime.now().subtract(const Duration(days: N)),
  lastReminderSent: DateTime.now().subtract(const Duration(days: M)), // Optionnel
)
```

### Calcul du Nombre de Jours

Pour déterminer combien de jours utiliser:
- **OK**: N < `reservationWarningDays` (ex: 3 jours si warning = 7)
- **EN RETARD**: N >= `reservationWarningDays` (ex: 8 jours si warning = 7)
- **EXPIRÉ**: N >= `reservationExpirationDays` (ex: 15 jours si expiration = 14)

### Tester Différents Scénarios

```dart
// Scénario: Avertissements fréquents (quotidiens)
reservationWarningDays: 0  // Avertir immédiatement
reservationExpirationDays: 1 // Expirer après 1 jour

// Scénario: Khatma longue durée (Ramadan)
reservationWarningDays: 10
reservationExpirationDays: 20

// Scénario: Pas d'expiration automatique
reservationWarningDays: 7
reservationExpirationDays: null  // Jamais expirer
```
