#--------------------------------------------
# N+1問題対応
#--------------------------------------------
inject_into_file "Gemfile", after:"group :development do" do <<-EOF

  gem 'bullet'
EOF
end
run 'bundle install'

after_bundle do
  inject_into_file "config/environments/development.rb", after: "Rails.application.configure do" do <<-EOF


    config.after_initialize do
      Bullet.enable = true # Bulletプラグインを有効
      Bullet.alert = true # JavaScriptでの通知
      Bullet.bullet_logger = true # log/bullet.logへの出力
      Bullet.console = true # ブラウザのコンソールログに記録
      Bullet.rails_logger = true # Railsログに出力
    end
EOF
  end
end