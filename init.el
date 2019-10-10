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
 '(flycheck-display-errors-delay 0.5)
 '(flycheck-display-errors-function
   (lambda
     (errors)
     (let
         ((messages
           (mapcar
            (function flycheck-error-message)
            errors)))
       (popup-tip
        (mapconcat
         (quote identity)
         messages "
")))))
 '(package-selected-packages
   (quote
    (flycheck-popup-tip flymake-cppcheck rainbow-delimiters dired-ranger ranger xclip rainbow-mode)))
 '(safe-local-variable-values (quote ((TeX-master . t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "gray20" t)))))

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
;; (setq interprogram-paste-function
;;       (lambda ()
;;     (shell-command-to-string "xsel -b -o")))
;; (setq interprogram-cut-function
;;       (lambda (text &optional rest)
;;     (let* ((process-connection-type nil)
;;            (proc (start-process "xsel" "*Messages*" "xsel" "-b" "-i")))
;;       (process-send-string proc text)
;;                  (process-send-eof proc))))

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

;;M - mをlinum-modeの切り替えにする
(define-key global-map (kbd "M-m") "\M-x linum-mode")

;;現在行をハイライト
(global-hl-line-mode t)

;; rainbow-delimitersをpackage installして
;; 括弧の色分けをする
(require 'rainbow-delimiters)
;(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;(global-rainbow-delimiters-mode)
(require 'cl-lib)
(require 'color)
(cl-loop
 for index from 1 to rainbow-delimiters-max-face-count
 do
 (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
   (cl-callf color-saturate-name (face-foreground face) 30)))

;; バッファの自動再読み込み
(global-auto-revert-mode 1)

;; yes no to y n
(defalias 'yes-or-no-p 'y-or-n-p)

;; スクリプトっぽかったら勝手に実行ビットを立てる
;;ファイルの先頭が#!で始まってる必要がある
 (add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)



;; (require 'flymake)
;; (defun flymake-get-make-cmdline (source base-dir)
;;   (list "make"
;;         (list "-s" "-C"
;;               base-dir
;;               (concat "CHK_SOURCES=" source)
;;               "SYNTAX_CHECK_MODE=1")))


;; (require 'flymake)
;; (defun flymake-cc-init ()
;;   (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;          (local-file  (file-relative-name
;;                        temp-file
;;                        (file-name-directory buffer-file-name))))
;;     (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))

;; (push '("\\.cc$" flymake-cc-init) flymake-allowed-file-name-masks)
;; (add-hook 'c++-mode-hook
;;           '(lambda ()
;;              (flymake-mode t)))


;;flycheckとflycheck-popup-tipをpackage-installしとかないといけない？よくわからん
;; (when (require 'flycheck nil 'noerror)
;;   (custom-set-variables
;;    ;; エラーをポップアップで表示
;;    '(flycheck-display-errors-function
;;      (lambda (errors)
;;        (let ((messages (mapcar #'flycheck-error-message errors)))
;;          (popup-tip (mapconcat 'identity messages "\n")))))
;;    '(flycheck-display-errors-delay 0.5))
;;   (define-key flycheck-mode-map (kbd "C-M-n") 'flycheck-next-error)
;;   (define-key flycheck-mode-map (kbd "C-M-p") 'flycheck-previous-error)
;;   (add-hook 'c-mode-common-hook 'flycheck-mode))
;; (add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++17")))

;; (with-eval-after-load 'flycheck
;;   '(add-hook 'flycheck-mode-hook 'flycheck-popup-tip-mode))
;; (eval-after-load 'flycheck
;;   (if (display-graphic-p)
;;       (flycheck-pos-tip-mode)
;;     (flycheck-popup-tip-mode)))
