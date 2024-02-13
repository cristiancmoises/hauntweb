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

(use-modules (haunt builder blog)
             (haunt builder assets)
             (haunt post)
             (haunt site)
             (haunt config)
             (useful))

;; Static "Home"
(define home-page
  (static-page
   "Home"
   "index.html"
   `(,(centered-image "images/mainframe_256x256.gif"))))

;; Static "About" page
(define about-page
  (static-page
   "About"
   "about.html"
   `((h1 "About")
     (p "This is the personal website of Cristian Cezar Moisés."
	" I am a student. (Pronouns: "
	(i "he, him, his")
	").")
     ,(centered-image "images/profile.png")
     (p "Learning about cybersec,infosec and hacking."
	"Information Security Graduate"
	,(link* "Ftec"
		"https://www.ftec.com.br/")
	". My research focused on the "
	"Linux Servers Security."
	"I'm a free software enthusiast.")
     (br)
     (p " I like code and i like to mix many projects like threejs + react "
	"Check my awesome interactive portfolio "
	,(link* "here"
		"https://live-one.vercel.app")
	". Outside of work, I'm a computerphile — "
	"I enjoy learning about and using programming languages "
	".This "
	"site was written in the LISP dialect Scheme (GNU Guile, version "
	,(version)
	") and built with the Haunt library (version "
	,%haunt-version
	") on "
	,(strftime "%c" (localtime (current-time)))
	". The source code can be found on "
	,(link* "GitHub"
		"https://github.com/cristiancmoises/hauntweb")
	". Check my YouTube channel "
	,(link* "SecurityOps" "https://youtube.com/@securityops")
	"."))))

(define not-found 
  (static-page
   "404"
   "404.html"
   `((h1 "404 Page Not Found")
     (p "Unfortunately the page you've tried to access doesn't exist!")
     (br)
     (h2 "Return "
	 ,(link* "Home"
		 "https://cristiancmoises.github.io")
	 "?"))))

;; Collection of miscellaneous posts
(define %misc
  `(("Recent Posts" "misc.html" ,misc-posts)))

;; Collection of research-related posts
(define %research
  `(("Published Work" "research.html" ,research-posts)))

;; Build site
(site #:title
      "C.C.M. Homepage"
      #:domain
      "cristiancmoises.github.io"
      #:default-metadata
      '((author . "Cristian Cezar Moisés"))
      #:readers
      (list commonmark-reader*)
      #:builders
      (list (blog #:theme default-theme #:collections %misc)
            (blog #:theme default-theme #:collections %research)
            home-page
            about-page
	    not-found
	    (static-directory "css")
            (static-directory "images")))
