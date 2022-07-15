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

```racket
(+ 4 5)
(apply + (list 4 5))
(call-with-values (λ () (values 4 5)) +)
```

Let vs define differences:

Let allows local definitions and execution without call. 
If it has a proc-id (procedure id), it can only be called
recursively and not outside of definitions

How to override operators:
```racket
(let ([+ (lambda (x y)
             (if (string? x)
                 (string-append x y)
                 (+ x y)))])
    (list (+ 1 2)
          (+ "see" "saw")))
```

Three ways of calling function: 
* Normal: 

```racket 
(+ 4 5)
```
* Calling with values: takes a lambda and applies the values to a procedure

```racket
(call-with-values (lambda () (values 4 5)) +)
```
* Apply: Applies a procedure to a list or to a series of values
```racket 
(apply + '(4 5))
(apply + 4 '(5))
(apply sort (list (list "Hello" "everyone") <) #:key (lambda (str) (string-length str)))
```
[Gist](https://gist.github.com/mattbobambrose/c6f68e080cc06bd27e0e079b714e9aa3)

Curry vs curryr
* Curry evaluates functions left to right and curryr evaluates functions right to left. 
* It does not change the ordering of the arguments unless they are at different levels of evaluation.