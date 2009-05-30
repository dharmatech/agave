
;; Based on the original at:
;; 
;;     http://www.contextfreeart.org/gallery/view.php?id=1182
;;
;; by 'alex103'
;;
;; Ported to Scheme by Ed Cavazos

(import (rnrs) (cfdg) (cfdg-rule))

(rule line
      (1 (a1)
         (a1 (rotate 120))
         (a1 (rotate 240))))

(rule a1
      (1 (a1 (size 0.95)
             (x 2.0)
             (rotate 12)
             (brightness 0.5)
             (hue 10.0)
             (saturation 1.5))
         (chunk)))

(rule chunk
      (1 (circle)
         (line (alpha -0.3) (size 0.3) (flip 60.0))))

(rule start
      (1 (line (alpha -0.3))))

(background (lambda () (brightness -1)))

(viewport '(-20 40 -20 40))

(start-shape start)

(threshold 0.05)

(run-model)

        