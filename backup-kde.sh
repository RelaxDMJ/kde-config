#!/bin/bash

# Répertoire de sauvegarde
cd ~/kde-config-backup || exit 1

echo "🔄 Copie des fichiers de configuration KDE..."

# Copie de fichiers essentiels (ajuste selon tes besoins)
cp -ru ~/.config/plasma* .config/
cp -u ~/.config/kglobalshortcutsrc .config/
cp -u ~/.config/kwinrc .config/
cp -u ~/.config/kdeglobals .config/
cp -ru ~/.local/share/plasma* .local/share/
cp -ru ~/.local/share/icons .local/share/
cp -ru ~/.local/share/fonts .local/share/

# Ajout et commit
echo "📦 Préparation du commit..."
git add .
git commit -m "Backup du $(date +%F)"

# Push vers GitHub
echo "🚀 Envoi vers GitHub..."
git push

echo "✅ Sauvegarde KDE envoyée avec succès."
