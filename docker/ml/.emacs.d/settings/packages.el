(require 'package)

(setq ml-package
   '(
       el-get
       company-mode
       flycheck
       projectile
       yasnippet
   )
)

(add-to-list 'package-archives '("gnu", "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa", "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(provide 'packages)
