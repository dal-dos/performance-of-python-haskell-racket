#lang racket
(define (contains x lst)
  (cond [(empty? lst) #f]
        [(equal? x (first lst)) #t]
        [else (contains x (rest lst))]
  )
)
(define (pairs lst1 lst2)
  (cond
    [(or (not (list? lst1)) (not (list? lst2))) '()]
    [(or (empty? lst1) (empty? lst2)) '()]
    [(cons (list (first lst1) (first lst2)) (pairs (rest lst1) (rest lst2)))]
  )
)
(define (my-remove-duplicates lst)
  (cond
    [(empty? lst) '()]
    [(contains (first lst) (rest lst)) (my-remove-duplicates(rest lst))]
    [else (cons (first lst) (my-remove-duplicates(rest lst)))]
  )
)
(define (remove-lst-dups lst)
  (cond [(empty? (rest lst)) (cons (my-remove-duplicates (first lst)) (rest lst))]
        [else (cons (my-remove-duplicates (first lst)) (remove-lst-dups (rest lst))) ]            
  )
  )

(define (main)
  (define fileName "example1000000.txt")
  (define txtFile '())
  (define time 0)
  (define listOfVotes '())
  (define listOfBallots '())
  (define ballotCount 0)
  (define totalBallots 0)
  (define firstT 0)
  (define noneCount 0)
  (define fullCount 0)
  (displayln "What is the name of the ballot file?")
  (set! fileName (read-line))
  (set! txtFile (map my-remove-duplicates (map string-split (file->lines fileName))))
  (set! totalBallots (length txtFile))
  (for [(i txtFile)]
    (for [(j (remove "none" i))]
      (cond  [(empty? listOfVotes) (set! listOfVotes (append listOfVotes (list j)))]
             [(not (contains j listOfVotes)) (set! listOfVotes (append listOfVotes (list j)))])
      )
    )
(for ([i listOfVotes])
  (set! ballotCount 0)
  (for ([j txtFile])
    (cond [(contains i j) (set! ballotCount (+ ballotCount 1))])
    (cond [(= firstT 0) (cond [(contains "none" j) (set! noneCount (+ noneCount 1))])])
    )
  (set! firstT 1)
  (cond [(empty? listOfBallots) (set! listOfBallots (list ballotCount))]
        [else (set! listOfBallots (append listOfBallots (list ballotCount)))]
)
)
  (sort (pairs listOfVotes listOfBallots) (lambda (x y) (> (first (rest x)) (first (rest y)))))
  (for ([k txtFile])
    (cond [(= (length listOfVotes) (length k)) (set! fullCount (+ fullCount 1))])
   )
  (display "Total # of ballots: ")
  (displayln totalBallots)
  (displayln "")
  (for ([l (sort (pairs listOfVotes listOfBallots) (lambda (x y) (> (first (rest x)) (first (rest y)))))])
    (display (first l))
    (display ": ")
    (displayln (first (rest l)))
    )
  (display "empty: ")
  (displayln noneCount)
  (display "full: ")
  (displayln fullCount)
   )