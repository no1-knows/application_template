#--------------------------------------------
# Bootstrap/Jquery
#--------------------------------------------

run "yarn add bootstrap jquery popper.js"

remove_file "app/assets/stylesheets/application.css"
create_file "app/assets/stylesheets/application.scss" do <<-EOF
/*
 *= require_tree .
 *= require_self
*/
EOF
end

create_file "app/javascript/stylesheets/application.scss" do <<-EOF
@import "~bootstrap/scss/bootstrap";
EOF
end

inject_into_file "app/javascript/packs/application.js", after: "// const imagePath = (name) => images(name, true)" do  <<-EOF

import 'bootstrap'
import '../stylesheets/application'


document.addEventListener("turbolinks:load", function() {

$('#notice').append('この文章はjQueryのappendで表示しています。<br>記入したファイルはapp/javascript/packs/application.jsです。<br><br>画面下部の【NEW USER】ボタンが赤色ならBootstrap設定完了です。');
$('a').addClass('btn btn-outline-danger text-danger');

})


EOF
end

after_bundle do
inject_into_file "config/webpack/environment.js", after: "const { environment } = require('@rails/webpacker')" do <<-EOF

  const webpack = require('webpack')
  environment.plugins.prepend(
    'Provide',
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      jquery: 'jquery',
      Popper: 'popper.js/dist/popper'
    })
  )

EOF
  end
end