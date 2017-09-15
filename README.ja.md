# Croner
Cronerは、crontabの設定をアプリケーションとサーバー毎に設定できるタスクを追加するGemです。

*Read this in other languages: [English](README.md)*

## Installation
Gemfileに以下を追記して、追加して下さい。

```ruby
gem 'croner'
```

そしてbundle installを行って下さい。
```bash
$ bundle
```

最後に以下のコマンドを実行して初期設定を行って下さい。
```bash
$ rails g gtm_on_rails:install
```

## Configure
インストールで追加された`/config/initializers/croner.rb`の内容を変更することによって設定を変更して下さい。
#### enable_backup
cronのバックアップを取るかどうかの設定。
#### backup_path
バックアップの保存先の設定。ex. 'log'を設定するとlog内に保存される。デフォルトではRailsアプリケーションのrootに保存される。
#### keep_backups
バックアップファイルの過去分の保存ファイル数の設定。

## Usage
`config/croner/hosts/`にサーバーのホスト名のファイルを作成し、cronで設定する内容を記述して下さい。
`croner:update`タスクを実行すると、実行したサーバーのホスト名のファイルがあればその内容を追加します。無い場合は何も処理を行いません。
アプリケーション毎にcron内にブロック(開始行と終了行)の内側に内容を追加するため、既存のcronの内容に影響はありません。

## Capistrano integration
`config/deploy.rb`または`Capfile`に下記を追加することで簡単にCapistranoと連携し、deploy時にcrontabを更新することができます。
```rb
require "croner/capistrano"
```

デフォルトでは'db'ロールでのみタスクは実行されます。追加・変更したい場合は、`config/deploy.rb`に下記を追加してroleを指定して下さい。
```rb
croner_roles %w(web db)
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Author
[ykogure](https://github.com/ykogure)
