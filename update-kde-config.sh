#!/bin/bash

echo "🔄 Remplacement de la configuration KDE sur GitHub..."

# Aller dans le répertoire du repository
cd ~/kde-config || { echo "❌ Erreur: répertoire kde-config introuvable"; exit 1; }

echo "🗑️  Suppression de l'ancienne configuration..."
# Supprimer tous les anciens fichiers de config (garder .git, README.md et scripts)
rm -rf .config .local/share icons plasma-systemmonitor plasma-workspace plasma
rm -f kde* plasma* *.rc

echo "📁 Création des dossiers nécessaires..."
mkdir -p .config .local/share

echo "📋 Copie de la configuration actuelle..."

# Copier les fichiers de configuration principaux
cp ~/.config/kdeglobals ./ 2>/dev/null || echo "⚠️  kdeglobals non trouvé"
cp ~/.config/kwinrc ./ 2>/dev/null || echo "⚠️  kwinrc non trouvé"
cp ~/.config/plasmarc ./ 2>/dev/null || echo "⚠️  plasmarc non trouvé"
cp ~/.config/plasmashellrc ./ 2>/dev/null || echo "⚠️  plasmashellrc non trouvé"
cp ~/.config/kglobalshortcutsrc ./ 2>/dev/null || echo "⚠️  kglobalshortcutsrc non trouvé"
cp ~/.config/plasmanotifyrc ./ 2>/dev/null || echo "⚠️  plasmanotifyrc non trouvé"
cp ~/.config/plasma-localerc ./ 2>/dev/null || echo "⚠️  plasma-localerc non trouvé"
cp ~/.config/plasma-welcomerc ./ 2>/dev/null || echo "⚠️  plasma-welcomerc non trouvé"
cp ~/.config/plasmaparc ./ 2>/dev/null || echo "⚠️  plasmaparc non trouvé"

# Copier le fichier principal des applets
cp ~/.config/plasma-org.kde.plasma.desktop-appletsrc ./ 2>/dev/null || echo "⚠️  plasma-org.kde.plasma.desktop-appletsrc non trouvé"

# Copier les dossiers de configuration
echo "📂 Copie des dossiers de configuration..."
cp -r ~/.config/plasma* .config/ 2>/dev/null || true
cp -r ~/.local/share/plasma* .local/share/ 2>/dev/null || true
cp -r ~/.local/share/icons .local/share/ 2>/dev/null || true

# Copier d'autres dossiers importants s'ils existent
[ -d ~/.local/share/fonts ] && cp -r ~/.local/share/fonts .local/share/
[ -d ~/.config/autostart ] && cp -r ~/.config/autostart .config/

echo "📦 Préparation du commit..."
# Vérifier s'il y a des changements
if git diff --quiet && git diff --staged --quiet; then
    echo "ℹ️  Aucun changement détecté dans la configuration"
else
    # Ajout et commit
    git add .
    git commit -m "Remplacement complet - Configuration KDE actuelle $(date '+%Y-%m-%d %H:%M')"
    
    # Push vers GitHub
    echo "🚀 Envoi vers GitHub..."
    git push
    
    echo "✅ Configuration KDE remplacée avec succès sur GitHub!"
fi

echo "🎉 Opération terminée!"
