#!/bin/bash

echo "macOSのデフォルト設定を開始します..."

# システム設定のバックアップを作成
echo "現在の設定をバックアップ中..."
defaults export -g "./defaults_backup_$(date +%Y%m%d).plist"

########################
# キーボードとマウスとトラックパッドの設定 #
########################
echo "キーボードとマウスの設定を適用中..."
# キーボード
## キーボードの入力速度 最大
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2
# マウス
## マウスの軌道速度 最大
defaults write -g com.apple.mouse.scaling -float 3.0
# トラックパッド
## トラックパッド タップでクリック
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool "true"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

###################
# ディスプレイ設定 #
###################
echo "ディスプレイの設定を適用中..."
# 表示
## スクリーンセーバオフの設定変更
defaults -currentHost write com.apple.screensaver idleTime 0
## バッテリーの残量を割合で表示
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
## バッテリー駆動時のディスプレイオフの設定変更（30分後）
sudo pmset -b displaysleep 30
## 電源アダプタのディスプレイオフの設定変更（2時間後）
sudo pmset -c displaysleep 120

###################
# Dock設定 #
###################
# Dock
## サイズ変更
defaults write com.apple.dock tilesize -int 45
##自動的に表示
defaults write com.apple.dock autohide -bool true
## 表示するアプリをリセット
defaults write com.apple.dock persistent-apps -array

###################
# メニューバー設定 #
###################
# メニューバーの表示変更
## Bluetoohを表示
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.bluetooth" -bool true
## サウンドを表示
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.airplay" -bool true
## 音量バーを表示
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" -bool true
## 秒を表示の設定変更
defaults write com.apple.menuextra.clock ShowSeconds -bool true
## 時間を秒まで表示
defaults write com.apple.menuextra.clock DateFormat -string "HH:mm:ss"

###################
# Finder設定 #
###################
# Finderの設定
## 隠しファイルを常にファインダーに表示する
defaults write com.apple.finder AppleShowAllFiles -bool YES
## 全ての拡張子のファイルを表示する
defaults write -g AppleShowAllExtensions -bool true
## .DS_Storeファイルを作らせない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
## 常にカラム表示
defaults write com.apple.Finder FXPreferredViewStyle -string "clmv"

###################
# その他の設定 #
###################
# spotlightのショートカットをオフ
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/></dict>"

# 起動音をオフ
sudo nvram StartupMute=%01

# UTF-8 only
defaults write com.apple.terminal StringEncodings -array 4

for app in "Dock" \
	"Finder" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done
