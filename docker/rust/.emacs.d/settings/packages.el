(require 'package)

(setq ml-package
   '(
       el-get
       company
       company-racer
       flycheck
       magit
       flycheck-rust
       rust-mode  
       cargo
       racer
   )
)

;: cargo
;: C-c C-c C-b to run cargo build
;: C-c C-c C-r to run cargo run
;: C-c C-c C-t to run cargo test

(add-to-list 'package-archives '("gnu", "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa", "http://melpa.org/packages/") t)

(package-initialize)

(global-company-mode)


(provide 'packages)
