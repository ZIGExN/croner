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

## Usage
`config/croner/hosts/`にサーバーのホスト名のファイルを作成し、cronで設定する内容を記述して下さい。
`croner:update`タスクを実行すると、実行したサーバーのホスト名のファイルがあればその内容を追加します。無い場合は何も処理を行いません。
アプリケーション毎にcron内にブロック(開始行と終了行)の内側に内容を追加するため、既存のcronの内容に影響はありません。

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Author
[ykogure](https://github.com/ykogure)
