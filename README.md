# Dotfiles
## インストール時
### まずは以下のファイルを1つずつ実行する
- init.sh  
xcodeとbrewのインストール

- brew.sh  
brewでアプリをインストール

- link.sh  
設定ファイル等のシンボリックリンクを貼る

- defaults.sh  
macの設定を変更する

- setup.sh  
諸々の設定を行う
今のところ、githubのssh接続設定のみ

- others.md
その他、手動で行う設定

### その後、アプリごとの設定
各アプリ名のディレクトリ内のシェルスクリプトを実行すればOK

## 引き継ぎ設定
- ブランチ作成

- .Brewfileを整理
    - 書き出し
    ```
    brew bundle dump
    ```
    - dotfiles内の.Brewfileを手動で更新

- link.shを整理

- defaults.shを整理

- 各アプリごとの整理
