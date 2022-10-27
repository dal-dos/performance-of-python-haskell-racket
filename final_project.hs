--from lectures
removeDups :: Eq a => [a] -> [a]
removeDups lst = foldr (\x acc -> if elem x acc 
                                  then acc
                                  else x : acc
                        ) [] lst

insert :: Ord a => a -> [a] -> [a]
insert a [] = [a]
insert a (x:xs) | a <= x    = a:x:xs
               | otherwise = x : (insert a xs)

--from lectures
sort :: Ord a => [a] -> [a]
sort []     = []
sort (x:xs) = insert x (sort xs)

txtFile = ""
fileName = "example1000000.txt"
listOfVotes = []
listOfBallots = []
fullCount = 0
noneCount = 0

countBallots lst1 lst2 lst3 = (length (filter (\x-> (elem lst2 x)) lst1))

printData lst = ((++) ((++) (snd lst) ": ") (show (fst lst)))

parseData lst s = if ((length (tail lst)) == 0)
                  then ((++) s ((++) (head lst) "\n"))
                  else ((++) ((++) s ((++) (head lst) "\n")) (parseData (tail lst) s))

main = do 
    putStrLn "What is the name of the ballot file?"
    fileName <- getLine
    rawFile <- readFile fileName
    let txtFile = (map sort(map removeDups (map words (lines rawFile))))
    let listOfVotes = (sort (removeDups (filter (\x -> ((x /= "none")))  (words rawFile))))
    let listOfBallots = (map (\x -> (countBallots txtFile x []))listOfVotes)
    let noneCount = (length (filter (\x-> (elem "none" x)) txtFile))
    let fullCount = (length (filter (\x -> ((length listOfVotes) == (length x))) txtFile))
    putStrLn ""
    putStr "Total # of ballots: "
    print (length txtFile)
    putStrLn ""
    putStr (parseData (map printData (reverse (sort (zip listOfBallots listOfVotes)))) "")
    putStrLn ""
    putStr "full: "
    print fullCount
    putStr "none: "
    return noneCount
