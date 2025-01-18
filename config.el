;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;;
(after! evil-mode
  '(evil-ex-define-cmd "W[rite]" 'evil-save))

(pixel-scroll-precision-mode t)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
;(setq doom-font "Fira Code-12")
;;(setq doom-font (font-spec :family "Fira Code" :size 16))
(setq doom-font (font-spec :family "IBM Plex Mono Text" :size 20 :weight 'semi-bold)
      doom-variable-pitch-font (font-spec :family "IBM Plex Mono Text" :size 20 :weight 'bold))
(setq line-spacing 0.1)
;(setq doom-font (font-spec :family "Liberation Mono" :size 16 :weight 'regular))
;
(+global-word-wrap-mode +1)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(setq window-divider-default-right-width 4)
(setq window-divider-default-bottom-width 4)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(setq kill-whole-line t)
; (setq confirm-kill-emacs t)


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd'
;; (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(use-package! treesit-auto
  :config
  ;(treesit-auto-install 'prompt)
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))
(after! lsp
  (setq read-process-output-max (* 1024 1024)))


;;(setq inferior-lisp-program "ros dynamic-space-size=4100 -Q run")

(setq sly-lisp-implementations
      '(;;(ros ("C:\\msys64\\mingw64\\bin\\ros.exe" "dynamic-space-size=4100" "-Q" "run"))
        (sbcl ("sbcl" "--dynamic-space-size" "4GB"))))

;;(setq inferior-lisp-program "sbcl --dynamic-space-size 4GB")
;;(setq sly-lisp-implementations
      ;;'((sbcl ("C:\\Program Files\\SBCL\\sbcl.exe")))) ;; "--dynamic-space-size" "4GB"))))

(use-package! sly
 :config
 (setq
  sly-complete-symbol-function #'sly-flex-completions))

(use-package! symbol-overlay
  :bind ("s-'" . symbol-overlay-put)
  :defer nil
  :init
  (setq symbol-overlay-ignore-functions nil            ;; don't ignore keywords in various languages
        symbol-overlay-map (make-sparse-keymap))       ;; disable special cmds on overlays
  (defun enable-symbol-overlay-mode ()
    (unless (or (minibufferp)
                (derived-mode-p 'magit-mode)
                (derived-mode-p 'xref--xref-buffer-mode))
      (symbol-overlay-mode t)))
  (define-global-minor-mode global-symbol-overlay-mode ;; name of the new global mode
    symbol-overlay-mode                                ;; name of the minor mode
    enable-symbol-overlay-mode)
  :config
  (global-symbol-overlay-mode))                         ;; enable it


(defun powershell (&optional buffer)
  "Launches a powershell in buffer *powershell* and switches to it."
  (interactive)
  (let ((buffer (or buffer "*Powershell*"))
        (powershell-prog "c:\\Program Files\\PowerShell\\7\\pwsh.exe"))
    (make-comint-in-buffer "shell" "*Powershell*" powershell-prog)
    (switch-to-buffer buffer)))

;; TODO: Get this to work correctly..
;; Set popup rule for powershell buffer
(set-popup-rules!
 '(("^\\*Powershell" :vslot 3 :side 'bottom :size 0.35  :modeline t :select t)))
