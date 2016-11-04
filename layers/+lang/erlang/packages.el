;;; packages.el --- Erlang Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq erlang-packages
  '(
    company
    erlang
    ggtags
    helm-gtags
    flycheck
    ))

(defun erlang/post-init-company ()
  (add-hook 'erlang-mode-hook 'company-mode))

(defun erlang/init-erlang ()
  (use-package erlang
    :defer t
    :init
    (progn
      ;; explicitly run prog-mode hooks since erlang mode does is not
      ;; derived from prog-mode major-mode
      (add-hook 'erlang-mode-hook 'spacemacs/run-prog-mode-hooks)
      (setq erlang-root-dir "/usr/local/Cellar/erlang-r19/19.0.2/lib/erlang/erts-8.0.2")
      (add-to-list 'exec-path "/usr/local/Cellar/erlang-r19/19.0.2/lib/erlang/erts-8.0.2/bin")
      (setq erlang-man-root-dir "/usr/local/Cellar/erlang-r19/19.0.2/lib/erlang/erts-8.0.2/bin")
      (add-hook 'erlang-mode-hook
                (lambda ()
                  (setq mode-name "Erlang")
                  ;; when starting an Erlang shell in Emacs, with a custom node name
                  (setq inferior-erlang-machine-options '("-sname" "heller"))
                  ))
      (setq erlang-compile-extra-opts '(debug_info (i . ../../../inlcude) (i . ../../include) (i . ../include) (i . include))))
    :config
    ;; (erlang-compile)
    (require 'erlang-start)))

(defun erlang/post-init-flycheck ()
  (spacemacs/add-flycheck-hook 'erlang-mode))

(defun erlang/post-init-ggtags ()
  (add-hook 'erlang-mode-local-vars-hook #'spacemacs/ggtags-mode-enable))

(defun erlang/post-init-helm-gtags ()
  (spacemacs/helm-gtags-define-keys-for-mode 'erlang-mode))

(setq flycheck-erlang-include-path (list
                                    "inc"
                                    "../inc"
                                    "../../inc"
                                    "../../../inc"
                                    "include"
                                    "../include"
                                    "../../include"
                                    "../../../include"
                                    ))
(setq flycheck-erlang-library-path (list
                                    "../ebin"
                                    "../../ebin"
                                    "../../../ebin"
                                    ))
