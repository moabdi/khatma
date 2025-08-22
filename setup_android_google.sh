#!/bin/bash

# 🔧 Script de configuration Google Sign-In Android
# Résout l'erreur ApiException: 10 (DEVELOPER_ERROR)

echo "🚀 Configuration Google Sign-In Android"
echo "======================================="

# Vérifier qu'on est dans un projet Flutter
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ Erreur: Exécutez ce script depuis la racine de votre projet Flutter"
    exit 1
fi

# Vérifier qu'on a le dossier android
if [ ! -d "android" ]; then
    echo "❌ Erreur: Dossier android non trouvé"
    exit 1
fi

echo ""
echo "📱 ÉTAPE 1: Récupération des informations Android"
echo "================================================"

# Récupérer le package name
PACKAGE_NAME=$(grep -r "applicationId" android/app/build.gradle | head -1 | sed 's/.*applicationId "//' | sed 's/".*//')
echo "📦 Package Name: $PACKAGE_NAME"

# Vérifier si google-services.json existe
if [ -f "android/app/google-services.json" ]; then
    echo "✅ google-services.json trouvé"
    
    # Vérifier le package name dans google-services.json
    JSON_PACKAGE=$(grep -o '"package_name":"[^"]*' android/app/google-services.json | head -1 | sed 's/"package_name":"//')
    echo "📋 Package dans JSON: $JSON_PACKAGE"
    
    if [ "$PACKAGE_NAME" != "$JSON_PACKAGE" ]; then
        echo "⚠️  ATTENTION: Package name différent entre build.gradle et google-services.json"
        echo "   build.gradle: $PACKAGE_NAME"
        echo "   google-services.json: $JSON_PACKAGE"
    else
        echo "✅ Package names correspondent"
    fi
else
    echo "❌ google-services.json NON TROUVÉ dans android/app/"
    echo "   Téléchargez-le depuis Firebase Console"
fi

echo ""
echo "🔑 ÉTAPE 2: Génération SHA1 Fingerprint"
echo "======================================="

cd android

# Générer le SHA1 avec gradlew
echo "🔄 Génération du SHA1 fingerprint..."
if ./gradlew signingReport > /tmp/signing_report.txt 2>&1; then
    echo "✅ Rapport de signature généré"
    
    # Extraire le SHA1
    SHA1=$(grep -A 10 "Variant: debug" /tmp/signing_report.txt | grep "SHA1:" | head -1 | sed 's/.*SHA1: //')
    
    if [ ! -z "$SHA1" ]; then
        echo "🔑 SHA1 Debug: $SHA1"
        echo ""
        echo "📋 INFORMATIONS POUR FIREBASE CONSOLE:"
        echo "======================================"
        echo "Package Name: $PACKAGE_NAME"
        echo "SHA1 Fingerprint: $SHA1"
        echo ""
        echo "🔗 Étapes suivantes:"
        echo "1. Allez sur Firebase Console: https://console.firebase.google.com"
        echo "2. Sélectionnez votre projet"
        echo "3. Project Settings (⚙️) > General > Your apps"
        echo "4. Cliquez sur votre app Android"
        echo "5. Ajoutez cette SHA1: $SHA1"
        echo "6. Téléchargez le nouveau google-services.json"
        echo "7. Remplacez android/app/google-services.json"
    else
        echo "❌ Impossible d'extraire le SHA1 du rapport"
        echo "Contenu du rapport:"
        cat /tmp/signing_report.txt
    fi
else
    echo "❌ Erreur lors de la génération du rapport de signature"
    echo "Essayez manuellement avec:"
    echo "./gradlew signingReport"
fi

# Nettoyer le fichier temporaire
rm -f /tmp/signing_report.txt

cd ..

echo ""
echo "🧹 ÉTAPE 3: Nettoyage et préparation"
echo "===================================="

echo "🔄 Nettoyage Flutter..."
flutter clean > /dev/null 2>&1
echo "✅ Flutter clean terminé"

echo "🔄 Récupération des dépendances..."
flutter pub get > /dev/null 2>&1
echo "✅ Dependencies récupérées"

echo "🔄 Nettoyage Android..."
cd android
./gradlew clean > /dev/null 2>&1
echo "✅ Android clean terminé"
cd ..

echo ""
echo "🧪 ÉTAPE 4: Vérifications de configuration"
echo "=========================================="

# Vérifier les dépendances Google Play Services
PLAY_SERVICES=$(grep -r "com.google.android.gms:play-services-auth" android/app/build.gradle)
if [ ! -z "$PLAY_SERVICES" ]; then
    echo "✅ Google Play Services Auth trouvé"
    echo "   $PLAY_SERVICES"
else
    echo "⚠️  Google Play Services Auth pas trouvé"
    echo "   Ajoutez dans android/app/build.gradle:"
    echo "   implementation 'com.google.android.gms:play-services-auth:20.7.0'"
fi

# Vérifier le plugin Google Services
GOOGLE_SERVICES_PLUGIN=$(grep -r "com.google.gms.google-services" android/app/build.gradle)
if [ ! -z "$GOOGLE_SERVICES_PLUGIN" ]; then
    echo "✅ Plugin Google Services trouvé"
else
    echo "⚠️  Plugin Google Services pas trouvé"
    echo "   Ajoutez dans android/app/build.gradle:"
    echo "   apply plugin: 'com.google.gms.google-services'"
fi

# Vérifier la version Gradle
GRADLE_VERSION=$(grep -r "com.android.tools.build:gradle" android/build.gradle | head -1)
if [ ! -z "$GRADLE_VERSION" ]; then
    echo "✅ Version Gradle Android"
    echo "   $GRADLE_VERSION"
fi

echo ""
echo "🎯 RÉSUMÉ ET ACTIONS SUIVANTES"
echo "============================="
echo ""
echo "📋 INFORMATIONS RÉCUPÉRÉES:"
echo "• Package Name: $PACKAGE_NAME"
if [ ! -z "$SHA1" ]; then
    echo "• SHA1 Debug: $SHA1"
fi
echo ""
echo "✅ ACTIONS TERMINÉES:"
echo "• Nettoyage Flutter et Android"
echo "• Vérification de la configuration"
echo "• Génération du SHA1 fingerprint"
echo ""
echo "🔴 ACTIONS REQUISES:"
echo "1. Copiez le SHA1 ci-dessus"
echo "2. Ajoutez-le dans Firebase Console"
echo "3. Téléchargez le nouveau google-services.json"
echo "4. Remplacez android/app/google-services.json"
echo "5. Exécutez: flutter run"
echo ""
echo "🔗 Liens utiles:"
echo "• Firebase Console: https://console.firebase.google.com"
echo "• Documentation: https://firebase.google.com/docs/android/setup"
echo ""

# Proposer de tester immédiatement
echo "🧪 Voulez-vous tester maintenant ? (après avoir configuré Firebase)"
echo "Tapez 'y' pour lancer flutter run, ou n'importe quoi d'autre pour terminer:"
read -r response

if [ "$response" = "y" ] || [ "$response" = "Y" ]; then
    echo "🚀 Lancement de l'application..."
    flutter run
else
    echo "👋 Configuration terminée. N'oubliez pas de configurer Firebase Console !"
fi