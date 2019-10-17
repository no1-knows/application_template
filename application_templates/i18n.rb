#--------------------------------------------
# ロケール対応
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