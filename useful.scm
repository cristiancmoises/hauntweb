;;; -*- coding: utf-8 -*-
;;; 
;;; This program is free software; you can redistribute it and/or
;;; modify it under the terms of the GNU General Public License as
;;; published by the Free Software Foundation; either version 3 of the
;;; License, or (at your option) any later version.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program.  If not, see
;;; <http://www.gnu.org/licenses/>.

(define-module (useful)
  #:use-module (haunt html)
  #:use-module (haunt reader)
  #:use-module (haunt utils)
  #:use-module (haunt asset)
  #:use-module (haunt builder blog)
  #:use-module (haunt page)
  #:use-module (haunt post)
  #:use-module (haunt site)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-19)
  #:use-module (web uri)
  #:use-module (ice-9 match)
  #:use-module (sxml match)
  #:use-module (sxml transform)
  #:use-module (commonmark)
  #:export (link*
            default-theme
            static-page
            research-posts
            misc-posts
            centered-image
            commonmark-reader*
            date))

;;; HTML utilities ---------------------------------------------------

(define (link* name uri)
  "Create a link with NAME to url URI."
  `("[" (a (@ (href ,uri)) ,name) "]"))

(define (stylesheet name)
  "Use the stylesheet NAME.css saved locally in css/."
  `(link (@ (rel "stylesheet")
            (href ,(string-append "/css/" name ".css")))))

(define (centered-image image)
  "Create a centered image from source IMAGE."
  `((div (@ (style "text-align: center")) (img (@ (src ,image))))))

;;; Post processing utilities ----------------------------------------

(define (date year month day)
  "Create a SRFI-19 date for the given YEAR, MONTH, DAY"
  (let ((tzoffset
          (tm:gmtoff
            (localtime (time-second (current-time))))))
    (make-date 0 0 0 0 day month year tzoffset)))

(define (first-paragraph post)
  "Extract the first paragraph from POST."
  (let loop ((sxml (post-sxml post)) (result '()))
    (match sxml
           (() (reverse result))
           ((or (('p ...) _ ...) (paragraph _ ...))
            (reverse (cons paragraph result)))
           ((head . tail) (loop tail (cons head result))))))

(define (contains? l m)
  "Check if LIST contains MEMBER."
  (if (null? l)
    #f
    (or (equal? (first l) m)
        (contains? (drop l 1) m))))

(define (research? post)
  "Check if POST has a research tag."
  (contains? (post-ref post 'tags) "research"))

(define (misc? post)
  "Check if POST has a misc tag."
  (contains? (post-ref post 'tags) "misc"))

(define (research-posts posts)
  "Returns POSTS that contain research tag in reverse chronological order."
  (posts/reverse-chronological
   (filter research? posts)))

(define (misc-posts posts)
  "Returns POSTS that contain misc tag in reverse chronological order."
  (posts/reverse-chronological
   (filter misc? posts)))

;;; Links ------------------------------------------------------------

(define (github)
  (link* "GitHub" "https://github.com/cristiancmoises"))

(define (linkedin)
  (link* "LinkedIn" "https://www.linkedin.com/in/cristiancezarmoises"))

(define (orcid)
  (link* "ORCID" "https://orcid.org/0000-0001-9533-4916"))

(define (arxiv)
  (link* "ArXiv" "https://arxiv.org/search/?"))

(define (ads)
  (link* "Youtube" "https://youtube.com/@securityops"))

(define (cc-by-sa)
  (link* "CC BY-SA 4.0" "https://creativecommons.org/licenses/by-sa/4.0/"))

;;; Website layout ---------------------------------------------------

(define (header-box)
  `(div (@ (id "block"))
        (p "+>---------------------------<+")
        (p ,(link* "About" "/about.html")--
           ,(link* "Research" "/research.html")--
           ,(link* "Miscellany" "/misc.html"))
        (p "+>---------------------------<+")
        (br)))

(define (footer-box)
  `(div (@ (id "block"))
        (br)
        (p "+>---------------------------<+")
        (div ,(github)--
             ,(linkedin))
        (div ,(orcid)--
             ,(arxiv)--
             ,(ads))
        (p "© 2024 Cristian Cezar Moises")
        (p ,(cc-by-sa))
        (p "Built with "
           ,(link* "Haunt" "http://haunt.dthompson.us")
           " in "
           ,(link* "Scheme" "https://www.gnu.org/software/guile/guile.html"))
        (p "+>---------------------------<+")))

(define default-theme
  (theme #:name
         "default-theme"
         #:layout
         (lambda (site title body)
           `((doctype "html")
             (head (meta (@ (charset "utf-8")))
		   (meta (@ (name "description")
			    (content "C.C.M. personal website")))
                   (meta (@ (name "viewport")
                            (content "width=device-width, initial-scale=1")))
                   (title ,(string-append title " — " (site-title site)))
                   ,(stylesheet "default"))
             (body (header ,(header-box))
                   (div (@ (id "block")) ,body)
                   (footer ,(footer-box)))))
         #:post-template
         (lambda (post)
           `((h1 ,(post-ref post 'title))
             (div ,(date->string (post-date post) "~B ~d, ~Y"))
             (div ,(post-sxml post))))
         #:collection-template
         (lambda (site title posts prefix)
           (define (post-uri post)
             (string-append
	      "/"
	      (or prefix "")
	      (site-post-slug site post)
	      ".html"))
           `((h1 ,title)
             ,(map (lambda (post)
                     (let ((uri (string-append
				 "/"
				 (site-post-slug site post)
				 ".html")))
                       `(div (h2 (a (@ (href ,uri)
                                       (style "text-decoration: none;"))
                                    ,(post-ref post 'title)))
                             (div ,(date->string (post-date post) "~B ~d, ~Y"))
                             (div ,(first-paragraph post))
			     ,(link* "read more..." uri)
			     (br)
			     (p (@ (style "text-align: center;")) "-->--<--"))))
                   posts)))))

(define (static-page title file-name body)
  "Create a static page with TITLE at html file FILENAME using page BODY."
  (lambda (site posts)
    (make-page
     file-name
     (with-layout default-theme site title body)
     sxml->html)))

;;; Custom markdown reader --------------------------------------------------

(define (sxml-identity . args) args)

;; Code block
(define (code-block . tree)
  (sxml-match
   tree
   ((pre (code ,source))
    `(div (@ (id "code"))
	  (pre (@ (style "overflow: auto")) (code ,source))))
   (,other other)))

;; Convert hrefs to custom hoverable link
(define (hover-link . tree)
  (sxml-match
   tree
   ((a (@ (href ,uri) unquote _) unquote name)
    `(,(link* name uri)))))

;; Center all images
(define (center-images . tree)
  (sxml-match
   tree
   ((img (@ (src ,uri) unquote _))
    `(,(centered-image uri)))))

(define %commonmark-rules
  `((pre unquote code-block)
    (a unquote hover-link)
    (img unquote center-images)
    (*text* unquote (lambda (tag str) str))
    (*default* unquote sxml-identity)))

(define (post-process-commonmark sxml)
  (pre-post-order sxml %commonmark-rules))

(define commonmark-reader*
  (make-reader
   (make-file-extension-matcher "md")
   (lambda (file)
     (call-with-input-file
	 file
       (lambda (port)
	 (values
	  (read-metadata-headers port)
	  (post-process-commonmark (commonmark->sxml port))))))))
