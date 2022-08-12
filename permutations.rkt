;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Permutations) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define lon '(0 1 2 3 4 5))

(define (insert-at-index num lst ind)
  (cond
    [(or (empty? lst)(= ind 0)) (cons num lst)]
    [else (cons (first lst) (insert-at-index num (rest lst) (- ind 1)))]))

(check-expect (insert-at-index 0 '() 0) '(0))
(check-expect (insert-at-index 1 lon 0) '(1 0 1 2 3 4 5))
(check-expect (insert-at-index 1 lon 3) '(0 1 2 1 3 4 5))
(check-expect (insert-at-index 10 lon 10) '(0 1 2 3 4 5 10))


; Exercise 2
; permute : [List-of X] -> [List-of [List-of X]]
; creates a list with all the possible permutations of the given list of elements

;(define (superior-permute arr)
;  (cond
;    [(empty? arr) '(())]
;    [(= 1 (length arr)) (list arr)]
;    [else (dup-and-insert (first arr) (permute (rest arr)))]))
;
;(define (dup-list item i lst)
;  (cond
;    [(= i (+ 1 (length lst))) '()]
;    [else (cons (insert-at-index item lst i) (dup-list item (+ i 1) lst))]))
;
;(define (duplicate item lst)
;  (append (dup-list item 0 lst)))
;
;(define (dup-and-insert item lol)
;  (apply append (map (lambda (lst) (duplicate item lst)) lol))) 
;
;(dup-and-insert 0 '((1 2) (3 4)))

;(permute '(1 2 3))

;(define (inferior-permute arr)
;  (cond
;    [(empty? arr) '()]
;    [else (repeat-insert-at-index (first arr) 0 (rest arr))]))
;
;(define (repeat-insert-at-index arr)
;  (repeat-insert-at-index-base num 0 arr))
;
;(define (repeat-insert-at-index-base num index arr)
;  (cond
;    [(= index (+ (length arr) 1)) '()]
;    [else (cons (insert-at-index num arr index) (repeat-insert-at-index-base num (+ index 1) arr))]))
;
;(define (call-on-every-num arr)
;  (call-on-every-num-base 0 arr))
;
;(define (call-on-every-num-base index arr)
;  (cond
;    [(= index (length arr)) '()]
;    [else (cons (repeat-insert-at-index (list-ref arr index) (rest arr)) (call-on-every-num-base (+ index 1) arr))]))

;(define (make-new-list index arr)

;(repeat-insert-at-index 1 '(2 3 4))

;(call-on-every-num '(1 2 3 4))

(define (permute arr)
  (cond
    [(empty? arr) '(())]
    [(= 1 (length arr)) (list arr)]
    [else (insert-to-lists (first arr) (permute (rest arr)))]
    )
  )

(check-expect (permute '()) '(()))
(check-expect (permute '(a)) '((a)))
(check-expect (permute '(a b)) '((a b) (b a)))
(check-expect (permute '(a b c)) '((a b c) (b a c) (b c a) (a c b) (c a b) (c b a)))
(check-expect (permute '(1 2 3)) '((1 2 3) (2 1 3) (2 3 1) (1 3 2) (3 1 2) (3 2 1)))
(check-expect (permute '(a b c d)) '((a b c d) (b a c d) (b c a d) (b c d a) (a c b d) (c a b d)
                                               (c b a d) (c b d a) (a c d b) (c a d b) (c d a b)
                                               (c d b a) (a b d c) (b a d c) (b d a c) (b d c a)
                                               (a d b c) (d a b c) (d b a c) (d b c a) (a d c b)
                                               (d a c b) (d c a b) (d c b a)))

; insert-to-lists : X [List-of [List-of X]] -> [List-of [List-of X]]
; for every list in the given list of lists inserts a given element in all the possible ways
(define (insert-to-lists element lol)
  (local
    {
     (define (build-int-list n) (build-list n (λ (x) x)))
     (define (list-size lst) (+ 1 (length lst)))
     }
      (cond
    [(empty? lol) '()]
    [else (append
           (ways-to-insert element (first lol) (build-int-list (list-size (first lol))))
           (insert-to-lists element (rest lol)))]
    )
  )
)

(check-expect (insert-to-lists 'a '(())) '((a)))
(check-expect (insert-to-lists 'b '((c))) '((b c) (c b)))
(check-expect (insert-to-lists 'a '((b c) (c b))) '((a b c) (b a c) (b c a) (a c b) (c a b) (c b a)))

; ways-to-insert : X [List-of X] [List-of Natural]-> [List-of [List-of X]]
; retuns the list of ways to insert an element into a list
(define (ways-to-insert element l indicies)
  (cond
    [(empty? indicies) '()]
    [else (cons (insert-at-index element l (first indicies)) (ways-to-insert element l (rest indicies)))]
  )
)

(check-expect (ways-to-insert 'a '() '(0)) '((a)))
(check-expect (ways-to-insert 'a '(b) '(0 1)) '((a b) (b a)))
(check-expect (ways-to-insert 'a '(b c) '(0 1 2)) '((a b c) (b a c) (b c a)))