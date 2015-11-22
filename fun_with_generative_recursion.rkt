#lang Racket
(require 2htdp/image)

(define THRESHOLD 1)
(define COLOR "purple")
(define STYLE "outline")

(define (my-triangle n)
  (if (< n THRESHOLD)
      (triangle n STYLE COLOR)
      (local [(define next-triangle (my-triangle (/ n 2)))]
        (above next-triangle
             (beside next-triangle
                     next-triangle)))))

(define (my-square n)
  (if (< n THRESHOLD)
      (square n STYLE COLOR)
      (local [(define next-square (my-square (/ n 3)))]
        (above (beside next-square
                       next-square
                       next-square)
               (beside next-square
                       (rectangle (/ n 3) 0 "solid" "black")
                       next-square)
               (beside next-square
                       next-square
                       next-square)))))

(define (my-circle n)
  (if (< n THRESHOLD)
      (circle n STYLE COLOR)
      (local [(define next-circle (my-circle (/ n 3)))
              (define next-column (above next-circle
                                         (rectangle 0 (/ n 1.5) "solid" "black")
                                         next-circle))]
        (overlay (circle (/ n 3) STYLE COLOR)
                 next-column
                 (rotate 60 next-column)
                 (rotate 120 next-column)
                 (circle n STYLE COLOR)))))

(define (my-tree n)
  (if (< n THRESHOLD)
      (line 0 n COLOR)
      (local [(define next-line (my-tree (/ n 2)))]
        (above (beside (rotate 30 next-line)
                       (rotate -30 next-line))
               (line 0 n COLOR)))))

(define (my-tower n)
  (if (< n THRESHOLD)
      (add-line (add-line (add-line (add-line (line n 0 COLOR)
                                              n 0
                                              n n
                                              COLOR)
                                    n n
                                    (* 2 n) n
                                    COLOR)
                          (* 2 n) n
                          (* 2 n) 0
                          COLOR)
                (* 2 n) 0
                (* 3 n) 0
                COLOR)
      (local [(define next-tower (my-tower (/ n 3)))
              (define v-line (line 0 n COLOR))]
        (overlay/align/offset
         "left" "bottom"
         next-tower
         n 0
         (overlay/align/offset
          "left" "bottom"
          v-line
          0 0
          (overlay/align/offset "left" "bottom"
                                next-tower
                                n n
                                (overlay/align/offset "left" "bottom"
                                                      v-line
                                                      0 0
                                                      next-tower)))))))