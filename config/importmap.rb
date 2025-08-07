# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "embla-carousel", to: "https://cdn.jsdelivr.net/npm/embla-carousel/embla-carousel.esm.js"
pin_all_from "app/javascript/controllers", under: "controllers"
