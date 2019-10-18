# application_template.rb

txt = <<-TXT

＿人人人人人人人人人人人人人人人人人人＿
＞　Rails Application Templates　＜
￣Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y￣

TXT
puts txt



#Gemfileに追加
#group :development, :test do
#  # テストデータ
#  gem 'factory_bot_rails'
#end

#--------------------------------------------
# PostgreSQL設定　（RubyMineでposgreでアプリ作成→postgresでサーバー起動）
#--------------------------------------------
#after_bundle do
#  run "export PGDATA='/usr/local/var/postgres'"
#end
# ユーザーを作成
#rails_user


#--------------------------------------------
# エラー表示方法変更 /  静的コード解析
#--------------------------------------------
#inject_into_file "Gemfile", after:"group :development do" do <<-EOF
#
#  gem "better_errors"
#  gem "binding_of_caller"  
#  gem 'rubocop', require: false
#EOF
#end
#run 'bundle install'

#--------------------------------------------
# 外部テンプレートで読み込み
#--------------------------------------------

@template_path = File.dirname(__FILE__) + '/application_templates'

#
apply "#{@template_path}/i18n.rb"
#
#apply "#{@template_path}/bullet.rb"
#
apply "#{@template_path}/bootstrap_jquery.rb"

apply "#{@template_path}/simpleform_clientsidevalidation.rb"

apply "#{@template_path}/rspec.rb"



#--------------------------------------------
# サンプルデータの投入
#--------------------------------------------
after_bundle do
  generate(:scaffold, "sample name:string age:integer")
  route "root to: 'samples#index'"



  rails_command "db:create"
  rails_command "db:migrate"

  inject_into_file "app/models/sample.rb", after: "class Sample < ApplicationRecord" do
    "\n validates :name, presence: true"
  end
end

#
#
##--------------------------------------------
## rubocopの実行
##--------------------------------------------
#after_bundle do
#  run "rubocop --auto-correct"
#  run "rubocop --auto-gen-config"
#end