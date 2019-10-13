# application_template.rb

txt = <<-TXT

＿人人人人人人人人人人人人人人人人人人＿
＞　Rails Application Templates　＜
￣Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y￣

TXT
puts txt

require_relative './application_templates/'


#Gemfileに追加
#group :development, :test do

#  # テストデータ
#  gem 'factory_bot_rails'

#end

#bootstrap form
#postgresql
#
#--------------------------------------------
# PostgreSQL設定　（RubyMineでposgreでアプリ作成→postgresでサーバー起動）
#--------------------------------------------
#after_bundle do
#  rails_command "export PGDATA='/usr/local/var/postgres'"
#end
#
##--------------------------------------------
## GEM導入
##--------------------------------------------
#
## エラー表示方法変更 /  静的コード解析
#
#inject_into_file "Gemfile", after:"group :development do" do <<-EOF
#
#  gem "better_errors"
#  gem "binding_of_caller"  
#  gem 'rubocop', require: false
#EOF
#end

#
#--------------------------------------------
# ロケール対応
#--------------------------------------------
#gem 'rails-i18n'
#run 'bundle install'
#
#after_bundle do
#  inject_into_file "config/application.rb", after: "# the framework and any gems in your application." do <<-EOF
#
#    config.i18n.default_locale = :ja
#    config.time_zone = 'Asia/Tokyo'
#
#EOF
#end
#end

##--------------------------------------------
## N+1問題対応
##--------------------------------------------
#inject_into_file "Gemfile", after:"group :development do" do <<-EOF
#
#  gem 'bullet'
#EOF
#end
#run 'bundle install'
#
#after_bundle do
#  inject_into_file "config/environments/development.rb", after: "Rails.application.configure do" do <<-EOF
#
#
#    config.after_initialize do
#      Bullet.enable = true # Bulletプラグインを有効
#      Bullet.alert = true # JavaScriptでの通知
#      Bullet.bullet_logger = true # log/bullet.logへの出力
#      Bullet.console = true # ブラウザのコンソールログに記録
#      Bullet.rails_logger = true # Railsログに出力
#    end
#EOF
#  end
#end
#  
#--------------------------------------------
# Bootstrap/Jquery
#--------------------------------------------
#
#run "yarn add bootstrap jquery popper.js"
#
#remove_file "app/assets/stylesheets/application.css"
#create_file "app/assets/stylesheets/application.scss" do <<-EOF
#/*
# *= require_tree .
# *= require_self
#*/
#EOF
#end
#
#create_file "app/javascript/stylesheets/application.scss" do <<-EOF
#@import "~bootstrap/scss/bootstrap";
#EOF
#end
#
#inject_into_file "app/javascript/packs/application.js", after: "// const imagePath = (name) => images(name, true)" do  <<-EOF
#
#import 'bootstrap'
#import '../stylesheets/application'
#
#
#document.addEventListener("turbolinks:load", function() {
#
#$('#notice').append('この文章はjQueryのappendで表示しています。<br>記入したファイルはapp/javascript/packs/application.jsです。<br><br>画面下部の【NEW USER】ボタンが赤色ならBootstrap設定完了です。');
#$('a').addClass('btn btn-outline-danger text-danger');
#
#})
#
#
#EOF
#end
#
#after_bundle do
#inject_into_file "config/webpack/environment.js", after: "const { environment } = require('@rails/webpacker')" do <<-EOF
#
#  const webpack = require('webpack')
#  environment.plugins.prepend(
#    'Provide',
#    new webpack.ProvidePlugin({
#      $: 'jquery',
#      jQuery: 'jquery',
#      jquery: 'jquery',
#      Popper: 'popper.js/dist/popper'
#    })
#  )
#
#EOF
#  end
#end
#


##--------------------------------------------
## Simple_form / Client_side_validation
##--------------------------------------------
#
#gem 'simple_form'
#gem 'client_side_validations'
#gem 'client_side_validations-simple_form'
#run 'bundle install'
#
#after_bundle do
#
#  run "rails generate simple_form:install --bootstrap"
#  run "rails g client_side_validations:install"
#
#  run "yarn add @client-side-validations/simple-form"
#
#  inject_into_file "app/javascript/packs/application.js", after: "// const imagePath = (name) => images(name, true)" do <<-EOF
#
#import '@client-side-validations/simple-form/dist/simple-form.bootstrap4'
#EOF
#  end
#end



#
##--------------------------------------------
## Rspec
##--------------------------------------------
#
#inject_into_file "Gemfile", after:"group :development, :test do" do <<-EOF
#
#  gem 'rspec-rails'
#  gem 'factory_bot_rails'
#EOF
#end
#run 'bundle install'
#
#after_bundle do
#  
#  run "rails generate rspec:install"
#  #generate(rspec:install)
#  
#  inject_into_file ".rspec", after: "--require spec_helper" do 
#    "\n--format documentation"
#  end
#  
#  inject_into_file "config/application.rb", after: "# the framework and any gems in your application." do <<-EOF
#
#    config.generators do |g|
#      g.assets false             # CSS/JSファイル生成せず
#      g.helper false             # ヘルパー生成せず
#      g.jbuilder false
#      g.test_framework :rspec,   # テストフレームワークはrspecを使用の場合
#                        fixtures: true,
#                        view_specs: false,
#                        helper_specs: false,
#                        routing_specs: false,
#                        controller_specs: false
#    end
#EOF
#  end
#end


#
#
##--------------------------------------------
## サンプルデータの投入
##--------------------------------------------
#after_bundle do
#  generate(:scaffold, "sample name:string age:integer")
#  route "root to: 'samples#index'"
#  rails_command "db:migrate"
#
#  inject_into_file "app/model/sample.rb", after: "class Sample < ApplicationRecord" do 
#    "\n validates :name, presence: true"
#  end
#end
#
#
#
##--------------------------------------------
## rubocopの実行
##--------------------------------------------
#after_bundle do
#  run "rubocop --auto-correct"
#  run "rubocop --auto-gen-config"
#end