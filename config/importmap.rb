# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@stripe/stripe-js", to: "https://ga.jspm.io/npm:@stripe/stripe-js@2.1.7/dist/stripe.esm.js"
pin "@rails/request.js", to: "https://ga.jspm.io/npm:@rails/request.js@0.0.9/src/index.js"
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
