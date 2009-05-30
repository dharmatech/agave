
;; Based on the original at:
;; 
;;     http://www.contextfreeart.org/gallery/view.php?id=541
;;
;; Ported to Scheme by Ed Cavazos

(import (rnrs) (cfdg) (cfdg-rule) (cfdg-abbreviations))

(rule black
      
      (60 (circle (s 0.6))
          (black (x 0.1) (r 5) (s 0.99) (b -0.01) (a -0.01)))
      
      (1  (white)
          (black)))

(rule white

      (60 (circle (s 0.6))
          (white (x 0.1) (r -5) (s 0.99) (b 0.01) (a -0.01)))

      (1  (black)
          (white)))

(rule chiaroscuro
      (1 (black (b 0.5))))

(background (lambda () (b -0.5)))

(viewport '(-3 6 -2 6))

(threshold 0.03)

(start-shape chiaroscuro)

(run-model)