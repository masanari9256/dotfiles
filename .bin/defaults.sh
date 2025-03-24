#!/bin/bash

# カウンター設定
SUCCESS_COUNT=0
FAILED_COUNT=0

# コマンド実行関数
execute_command() {
    local command="$1"
    echo "実行コマンド: $command"
    echo "実行結果:"
    eval "$command"
    local exit_status=$?
    if [ $exit_status -eq 0 ]; then
        ((SUCCESS_COUNT++))
        echo "ステータス: ✓ 成功 (終了コード: $exit_status)"
    else
        ((FAILED_COUNT++))
        echo "ステータス: ✗ 失敗 (終了コード: $exit_status)"
    fi
    echo "----------------------------------------"
}

echo "macOSのデフォルト設定を開始します..."

# システム設定のバックアップを作成
echo "現在の設定をバックアップ中..."
execute_command "defaults export -g './defaults_backup_$(date +%Y%m%d).plist'"

########################
# キーボードとマウスとトラックパッドの設定 #
########################
echo "キーボードとマウスの設定を適用中..."
# キーボード
## キーボードの入力速度 最大
execute_command "defaults write -g InitialKeyRepeat -int 15"
execute_command "defaults write -g KeyRepeat -int 2"

# マウス
## マウスの軌道速度 最大
execute_command "defaults write -g com.apple.mouse.scaling -float 3.0"

# トラックパッド
## トラックパッド タップでクリック
execute_command "defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true"
execute_command "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true"

###################
# ディスプレイ設定 #
###################
echo "ディスプレイの設定を適用中..."
# 表示
## スクリーンセーバオフの設定変更
execute_command "defaults -currentHost write com.apple.screensaver idleTime 0"
## バッテリーの残量を割合で表示
execute_command "defaults write com.apple.menuextra.battery ShowPercent -string YES"
## バッテリー駆動時のディスプレイオフの設定変更（30分後）
execute_command "sudo pmset -b displaysleep 30"
## 電源アダプタのディスプレイオフの設定変更（2時間後）
execute_command "sudo pmset -c displaysleep 120"

###################
# Dock設定 #
###################
echo "Dockの設定を適用中..."
## サイズ変更
execute_command "defaults write com.apple.dock tilesize -int 45"
## 自動的に表示
execute_command "defaults write com.apple.dock autohide -bool true"
## 表示するアプリをリセット
execute_command "defaults write com.apple.dock persistent-apps -array"
## 仮想デスクトップの自動並べ替えを無効
execute_command "defaults write com.apple.dock mru-spaces -bool false"

###################
# メニューバー設定 #
###################
echo "メニューバーの設定を適用中..."
## Bluetoohを表示
execute_command "defaults write com.apple.systemuiserver 'NSStatusItem Visible com.apple.menuextra.bluetooth' -bool true"
## サウンドを表示
execute_command "defaults write com.apple.systemuiserver 'NSStatusItem Visible com.apple.menuextra.airplay' -bool true"
## 音量バーを表示
execute_command "defaults write com.apple.systemuiserver 'NSStatusItem Visible com.apple.menuextra.volume' -bool true"
## 秒を表示の設定変更
execute_command "defaults write com.apple.menuextra.clock ShowSeconds -bool true"
## 時間を秒まで表示
execute_command "defaults write com.apple.menuextra.clock DateFormat -string 'HH:mm:ss'"

###################
# Finder設定 #
###################
echo "Finderの設定を適用中..."
## 隠しファイルを常にファインダーに表示する
execute_command "defaults write com.apple.finder AppleShowAllFiles -bool YES"
## 全ての拡張子のファイルを表示する
execute_command "defaults write -g AppleShowAllExtensions -bool true"
## .DS_Storeファイルを作らせない
execute_command "defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE"
## 常にカラム表示
execute_command "defaults write com.apple.Finder FXPreferredViewStyle -string 'clmv'"
# 検索時にデフォルトでカレントディレクトリを検索する
execute_command "defaults write com.apple.finder FXDefaultSearchScope -string 'SCcf'"

###################
# その他の設定 #
###################
echo "その他の設定を適用中..."
# spotlightのショートカットをオフ
execute_command "defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 '<dict><key>enabled</key><false/></dict>'"
# 起動音をオフ
execute_command "sudo nvram StartupMute=%01"
# UTF-8 only
execute_command "defaults write com.apple.terminal StringEncodings -array 4"

# アプリケーションの再起動
echo "設定を反映するためにアプリケーションを再起動しています..."
for app in "Dock" "Finder" "SystemUIServer"; do
    execute_command "killall '${app}' &> /dev/null"
done

echo "========================================"
echo "設定の適用が完了しました"
echo "成功: $SUCCESS_COUNT"
echo "失敗: $FAILED_COUNT"
echo "========================================"
