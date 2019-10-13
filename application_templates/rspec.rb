#--------------------------------------------
# Rspec
#--------------------------------------------

inject_into_file "Gemfile", after:"group :development, :test do" do <<-EOF

  gem 'rspec-rails'
  gem 'factory_bot_rails'
EOF
end
run 'bundle install'

after_bundle do
  
  run "rails generate rspec:install"
  #generate(rspec:install)
  
  inject_into_file ".rspec", after: "--require spec_helper" do 
    "\n--format documentation"
  end
  
  inject_into_file "config/application.rb", after: "# the framework and any gems in your application." do <<-EOF

    config.generators do |g|
      g.assets false             # CSS/JSファイル生成せず
      g.helper false             # ヘルパー生成せず
      g.jbuilder false
      g.test_framework :rspec,   # テストフレームワークはrspecを使用の場合
                        fixtures: true,
                        view_specs: false,
                        helper_specs: false,
                        routing_specs: false,
                        controller_specs: false
    end
EOF
  end
end