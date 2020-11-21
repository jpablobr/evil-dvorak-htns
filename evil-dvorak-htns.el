;;; evil-dvorak-htns.el --- hjkl => htns

;; Copyright (C) 2020 Pablo Barrantes
;; Author: Pablo Barrantes
;; Created: Oct 30 2020
;; Keywords:  dvorak evil htns vim
;; Version: 0.1

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; hjkl => htns

;; Install:

;; Drop evil-dvorak-htns.el. somewhere in your load-path.
;; (add-to-list 'load-path "~/emacs.d/vendor")
;; (require 'evil-dvorak-htns)
;; (global-evil-dvorak-htns-mode 1)

;;; Code:

(require 'evil)

(define-minor-mode evil-dvorak-htns-mode
  "Dvorak htns for evil-mode"
  :lighter " D"
  :keymap (make-sparse-keymap))

(defun enable-evil-dvorak-htns-mode ()
  "Enable evil-dvorak-htns in current buffer."
  (evil-dvorak-htns-mode 1))

(defun disable-evil-dvorak-htns-mode ()
  "Disable evil-dvorak-htns in current buffer."
  (evil-dvorak-htns-mode -1))

(define-globalized-minor-mode global-evil-dvorak-htns-mode
  evil-dvorak-htns-mode enable-evil-dvorak-htns-mode
  "Dvorak htns evil-mode global mode.")

(defun evil-dvorak-htns-minibuffer-setup-hook ()
  (evil-dvorak-htns-mode 0))
(add-hook 'minibuffer-setup-hook
          'evil-dvorak-htns-minibuffer-setup-hook)

(defadvice load (after give-my-keybindings-priority)
  "Try to ensure that evil-dvorak-htns keybindings always have priority."
  (if (not (eq (car (car minor-mode-map-alist)) 'evil-dvorak-htns-mode))
      (let ((htns-keys (assq 'evil-dvorak-htns-mode minor-mode-map-alist)))
        (assq-delete-all 'evil-dvorak-htns-mode minor-mode-map-alist)
        (add-to-list 'minor-mode-map-alist htns-keys))))
(ad-activate 'load)

;; hjkl => htns
(evil-define-key '(visual normal motion) 'evil-dvorak-htns-mode
  "h" 'evil-backward-char
  "t" 'evil-next-visual-line
  "n" 'evil-previous-visual-line
  "s" 'evil-forward-char)

(provide 'evil-dvorak-htns)

;;; evil-dvorak-htns.el ends here
