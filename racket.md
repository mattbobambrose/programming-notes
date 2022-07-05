# Racket Notes

```racket
(define (every-nth-recursive mod items)
(if (empty? items)
'()
(every-nth-recursive-base mod 0 items)))

(define (every-nth-recursive-base mod pos items)
(cond
[(empty? items) '()]
[(= 0 (modulo pos mod)) (list* (first items) (every-nth-recursive-base mod (+ 1 pos) (rest items)))]
[else (every-nth-recursive-base mod (+ 1 pos) (rest items))]))

(every-nth-recursive 3 '(10 20 30 40 50))
(check-expect (every-nth-recursive 3 '(10 20 30 40 50)) '(10 40))
```