 (global-set-key (kbd "C-x C-f") 'find-file-at-point)
 (global-set-key (kbd "C-x C-r") 'ffap-read-only)
 (global-set-key (kbd "C-x C-v") 'ffap-alternate-file)
 (global-set-key (kbd "C-x 4 f") 'ffap-other-window)
 (global-set-key (kbd "C-x 5 f") 'ffap-other-frame)
 (global-set-key (kbd "C-x 4 r") 'ffap-read-only-other-window)
 (global-set-key (kbd "C-x 5 r") 'ffap-read-only-other-frame)
 (global-set-key (kbd "C-x d" ) 'dired-at-point)
 (global-set-key (kbd "C-x 4 d") 'ffap-dired-other-window)
 (global-set-key (kbd "C-x 5 d") 'ffap-dired-other-frame)
 (add-hook 'gnus-summary-mode-hook 'ffap-gnus-hook)
 (add-hook 'gnus-article-mode-hook 'ffap-gnus-hook)
 (add-hook 'vm-mode-hook 'ffap-ro-mode-hook)
 (add-hook 'rmail-mode-hook 'ffap-ro-mode-hook)