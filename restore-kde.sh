#!/bin/bash

set -e

echo "📥 Clonage de la configuration KDE depuis GitHub..."

cd ~ || exit 1

# Clone dans un dossier temporaire
CLONE_DIR="kde-config-restore-$(date +%Y%m%d-%H%M%S)"
git clone https://github.com/RelaxDMJ/kde-config.git "$CLONE_DIR" || exit 1

# Sauvegarde de la configuration actuelle
BACKUP_DIR="kde-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p ~/"$BACKUP_DIR"/.config ~/"$BACKUP_DIR"/.local/share

echo "💾 Sauvegarde de la configuration actuelle dans ~/$BACKUP_DIR..."
cp -ru ~/.config/plasma* ~/"$BACKUP_DIR"/.config/ 2>/dev/null || true
cp -u ~/.config/kglobalshortcutsrc ~/.config/kwinrc ~/.config/kdeglobals ~/"$BACKUP_DIR"/.config/ 2>/dev/null || true
cp -ru ~/.local/share/plasma* ~/.local/share/icons ~/.local/share/fonts ~/"$BACKUP_DIR"/.local/share/ 2>/dev/null || true

# Application de la configuration GitHub
echo "📁 Restauration de la configuration depuis le dépôt..."

cp -ru "$CLONE_DIR"/.config/* ~/.config/ 2>/dev/null || true
cp -u "$CLONE_DIR"/.config/kglobalshortcutsrc ~/.config/ 2>/dev/null || true
cp -u "$CLONE_DIR"/.config/kwinrc ~/.config/ 2>/dev/null || true
cp -u "$CLONE_DIR"/.config/kdeglobals ~/.config/ 2>/dev/null || true
cp -ru "$CLONE_DIR"/.local/share/* ~/.local/share/ 2>/dev/null || true

echo "✅ Configuration KDE restaurée avec succès."

# Redémarrage optionnel
read -rp "🔁 Redémarrer Plasma pour appliquer les changements ? (o/n) : " confirm
if [[ $confirm == "o" || $confirm == "O" ]]; then
    echo "⏳ Redémarrage de la session graphique..."
    qdbus org.kde.LogoutPrompt /LogoutPrompt logoutAndReboot
else
    echo "ℹ️ Redémarre manuellement ta session pour appliquer les changements."
fi
