
(library

 (processing shapes)

 (export stroke
         fill
         polygon
         triangle
         )

 (import (rnrs)
         (geometry pt)
         (color rgba)
         (gl)
         (glamour misc)
         )

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (define stroke-color (rgba 0.0 0.0 0.0 0.0))

 (define fill-color   (rgba 1.0 1.0 1.0 1.0))

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (define stroke

   (case-lambda

    ((r g b a) (set! stroke-color (rgba r g b a)))
    ((r g b)   (set! stroke-color (rgba r g b 1.0)))
    ((g a)     (set! stroke-color (rgba g g g a)))
    ((g)       (set! stroke-color (rgba g g g 1.0)))))

 (define fill

   (case-lambda

    ((r g b a) (set! fill-color (rgba r g b a)))
    ((r g b)   (set! fill-color (rgba r g b 1.0)))
    ((g a)     (set! fill-color (rgba g g g a)))
    ((g)       (set! fill-color (rgba g g g 1.0)))))

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (define (gl-color-rgba color)
   (glColor4d (rgba-red   color)
              (rgba-green color)
              (rgba-blue  color)
              (rgba-alpha color)))

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (define (gl-pt-vertex p)
   (glVertex2d (pt-x p)
               (pt-y p)))

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (define (polygon . vertices)

   (gl-color-rgba fill-color)

   (gl-begin GL_POLYGON (for-each gl-pt-vertex vertices))

   (gl-color-rgba stroke-color)

   (gl-begin GL_LINE_LOOP (for-each gl-pt-vertex vertices)))

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (define triangle

   (case-lambda

    ( (a b c) (polygon a b c) )

    ( (x0 y0 x1 y1 x2 y2)

      (triangle (pt x0 y0)
                (pt x1 y1)
                (pt x2 y2)) )))

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (define rect

   (case-lambda

    ( (x y width height)

      (polygon (pt x y)
               (pt (+ x (- width 1)) y)
               (pt (+ x (- width 1)) (+ y (- height 1)))
               (pt x (+ y (- height 1)))))

    ( (corner dim)

      (rect (pt-x corner)
            (pt-y corner)
            (pt-x dim)
            (pt-y dim)) )))
 
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 )
