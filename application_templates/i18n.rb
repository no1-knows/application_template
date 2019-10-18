#--------------------------------------------
# ロケール対応
#
# simple_formは独自の記載方法があるので公式を確認
#
# 参考：http://alfa.hatenablog.jp/entry/2013/12/03/221308
#
#--------------------------------------------
gem 'rails-i18n'
run 'bundle install'

after_bundle do
  inject_into_file "config/application.rb", after: "# the framework and any gems in your application." do <<-EOF

    config.i18n.default_locale = :ja
    config.time_zone = 'Asia/Tokyo'
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

EOF
end
end

create_file "config/locales/ja.yml" do <<-EOF
ja:
  # 共通の使いまわす可能性のあるワードは dictionary を起点にする。
  dictionary:
    messages:
      hello_sample: 'こんにちは%{sample_name}さん'
    words:
      sample: &sample 'ユーザ情報'        # &sample はエイリアスで *sample で参照できる。(同一ファイル内のみ有効)
      sample_copy: *sample                # => 'ユーザ情報' となる。
      site_name: '翻訳したサイト名'
 
  # simpleformの書き方
  simple_form:
    labels:
      sample:
        name: '名前'
        age: '年齢'
    hints:
      sample:
        name: 'なまえを入力してください'
        age: '半角数字のみ使えます'
    placeholders:
      sample:
        name: 'なまえ'
        age: '****'

  # モデルは全て activerecord を起点にする。
  # これにより、User.model_name.human / User.human_attribute_name({attr_name})でアクセス可能。
#  activerecord:
#    models:
#      sample: 'サンプル情報'
#    attributes:
#      sample:
#        name: '名前'
#        age: '年齢'
#    errors:
#      nanikano_model_error: 'モデルで何かのエラー'  # 特定のモデルに属さないエラーはこの階層に書く。
#      models:
#        sample:
#          blank: 'urlかmailが空白です。' # モデル内で使いまわすエラーはこの階層に書く。
#          attributes:
#            name:
#              blank: '名前が空白です。'  # errosの中に同じ定義がある場合、ネストが深いほうが優先順位が高い
  
  # 全モデルで共通のアトリビュートはattributesを起点にattribute名を直下に記述する。
  # validation errorやhuman_attribute_nameで取得できる。
  # (ネストの深いものが優先されるため、activerecord.attributes内の優先度が最も高い。)
  attributes:
    sample_id: 'サンプル'

  # ヘルパー関数はhelpersを起点にする。
  # ヘルパー関数内で tメソッドを使用すると、呼び出し元のビューに基づいたパスが呼び出される。
  # 例えばsamplesのshowから呼ばれたヘルパー関数内で t('.hoge') を実行した場合 samples.show.hoge が参照される。
  # 呼び出し元によって文言を変えたい場合はビュー側に記述する。(そんなことあるかわからないけど。)
  helpers:
    sample:
      welcome: 'ようこそ！'
  
  # ビューはビューを格納しているフォルダ名を起点にし、ビュー名毎に記述する。
  # 対応するビューの中ではツリーを省略できる。<%= t '.title' %>
  samples:
    index:
      title: 'サンプル一覧'
    show:
      title: '%{sample_name}さんのサンプル情報'
    edit:
      title: '%{sample_name}さんのサンプル情報を編集'

  # ActionMailerを継承したMailerはクラス名を起点にする。
  nanikano_mailer:
    alert_email:
      subject: 'タイトル'
      body:    '本文'

  # グローバルな感じのエラーはerrorsを起点にする。
  errors:
    nanikano_error: 'よくわからないけど例外です。'
EOF
end