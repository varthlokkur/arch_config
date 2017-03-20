
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(setq racer-rust-src-path "~/.local/share/rust_src/src")
(setq racer-cmd "~/.cargo/bin/racer")

(add-hook 'rust-mode-hook 'cargo-minor-mode)
(add-hook 'rust-mode-hook '(lambda()
                                                             (interactive)
                                                             (setenv "$TERM" "ansi-term")
                                                             (setq tab-width 4
                                                                        indent-tabs-mode nill
                                                                        rust-indent-offset 4
                                                                        
                                                              )
                                                              (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
                                                      )
)

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'rust-mode-hook #'company-mode)


(provide 'hooks)