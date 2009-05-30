
;; Based on the original at:
;; 
;;     http://www.contextfreeart.org/gallery/view.php?id=1182
;;
;; Ported to Scheme by Ed Cavazos

(import (rnrs) (cfdg) (cfdg-rule))

(rule line
      (1 (a1)
         (a1 (r 120))
         (a1 (r 240))))

(rule a1
      (1 (a1 (s 0.95) (x 2.0) (r 12) (b 0.5) (hue 10.0) (sat 1.5))
         (chunk)))

(rule chunk
      (1 (circle)
         (line (a -0.3) (s 0.3) (flip 60.0))))

(rule start
      (1 (line (a -0.3))))

(background (lambda () (b -1)))

(viewport '(-20 40 -20 40))

(start-shape start)

(threshold 0.05)

(run-model)
