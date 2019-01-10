;;; package.el
(require 'package)
;; MELPAを追加
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq inhibit-startup-message t)
(add-to-list 'default-frame-alist' (font . "DejaVu Sans Mono-11"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (dired-ranger ranger xclip rainbow-mode)))
 '(safe-local-variable-values (quote ((TeX-master . t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;左側に行数を表示させる
(require 'linum) 
(global-linum-mode)
(setq linum-format "%3d ")
(setq scroll-conservatively 1)
;;列数
(line-number-mode t) 
(column-number-mode t)

;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

;; 対応する括弧を光らせる
(show-paren-mode 1)

;; ウィンドウ内に収まらないときだけ、カッコ内も光らせる
(setq show-paren-style 'mixed)
(set-face-background 'show-paren-match-face "grey")
(set-face-foreground 'show-paren-match-face "black")

;;空白を一度に全部削除
(setq c-hungry-delete-key t)

;; for CUDA Program
(setq auto-mode-alist
      (cons (cons "\\.cu$" 'c++-mode) auto-mode-alist))
;;今いる関数名を表示する
(which-function-mode 1)

;;; テーマ
(load-theme 'tango-dark t)

;; クリップボードと同期
(setq interprogram-paste-function
      (lambda ()
    (shell-command-to-string "xsel -b -o")))
(setq interprogram-cut-function
      (lambda (text &optional rest)
    (let* ((process-connection-type nil)
           (proc (start-process "xsel" "*Messages*" "xsel" "-b" "-i")))
      (process-send-string proc text)
                 (process-send-eof proc))))

;; タブにスペースを使用する
(setq-default tab-width 2 indent-tabs-mode nil)


;;ranger dired
;;(setq dired-dwim-target t)
;;(ranger-override-dired-mode t)
(setq ranger-preview-file t)
(setq ranger-dont-show-binary t)
(setq ranger-show-literal t)
;;(setq ranger-width-preview 0.55)
;;dired を殺してdired-rangerにする
(define-key global-map (kbd "C-x d") "\M-x ranger")

;;現在行をハイライト
(global-hl-line-mode t)
(custom-set-faces
'(hl-line ((t (:background "gray40" t))))
)
