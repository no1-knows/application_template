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