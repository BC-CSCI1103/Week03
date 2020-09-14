type coin = Heads | Tails

(* toggle : coin -> coin *)
let toggle coin =
  match coin with
  | Heads -> Tails
  | Tails -> Heads

(* flip : unit -> coin
*)
let flip () =
  match Random.int 2 = 0 with     (* A random integer in the range 0..1 *)
  | true  -> Heads
  | false -> Tails


(* isEven : int -> bool *)
let isEven n = (n mod 2) = 0

type fruit = Durian | Lemon | Mangosteen | Orange | Lychee

(* isCitrus : fruit -> bool
 *)
let isCitrus fruit =
  match fruit with
  | Durian -> false
  | Lemon -> true
  | Mangosteen -> false
  | Orange -> true
  | Lychee -> false

(* isCitrus : fruit -> bool           forgetting to handle Lychee ...
 *)
let isCitrus fruit =
  match fruit with
  | Durian -> false
  | Lemon -> true
  | Mangosteen -> false
  | Orange -> true

(* isCitrus : fruit -> bool
 *)
let isCitrus fruit =
  match fruit with
  | Lemon | Orange -> true     (* NB: Two variants with the same outcome.   *)
  | _ -> false                 (* NB: _ is a wildcard, it matches anything. *)


(* Either/Or types with parameters ******************************)

type shape = Circle of float
           | Rectangle of float * float

(* area : shape -> float *)
let area shape =
  match shape with
  | Circle radius -> Lib.pi *. radius ** 2.0
  | Rectangle (width, height) -> width *. height


(* JS-style numbers *******************************************)

type number = Int of int | Flt of float

(* double : number -> number *)
let double number =
  match number with
  | Int n -> Int (n * 2)
  | Flt n -> Flt (n *. 2.0)

(* Working with Lists *****************************************)

let fruits = [Lemon; Durian; Lychee; Lemon]

(* length 'a list -> int *)
let rec length xs =
  match xs with
  | [] -> 0
  | y :: ys -> 1 + length ys


(* length 'a list -> int *)
let rec length xs =
  match xs with
  | [] -> 0
  | _ :: ys -> 1 + length ys

(* mem : 'a -> 'a list -> bool *)
let rec mem x xs =
  match xs with
  | [] -> false
  | y :: ys -> (match x = y with
                | true  -> true
                | false -> mem x ys)

(* mem : 'a -> 'a list -> bool *)
let rec mem x xs =
  match xs with
  | [] -> false
  | y :: ys -> (x = y) || (mem x ys)

(* mem : 'a -> 'a list -> bool *)
let rec mem x xs =
  (xs != []) && ((x = List.hd xs) || (mem x (List.tl xs)))

(* addList : int list -> int *)
let rec addList ns =
  match ns with
  | [] -> 0
  | m :: ms -> m + addList ms

(* addList : int list -> int -> int *)
let rec addList ns answer =
  match ns with
  | [] -> answer
  | m :: ms -> addList ms (m + answer)

(* append : 'a list -> 'a list -> 'a list *)
let rec append xs ys =
  match xs with
  | [] -> ys
  | z :: zs -> z :: append zs ys

(* rev : 'a list -> 'a list *)
let rec rev xs =
  match xs with
  | [] -> []
  | z :: zs -> append (rev zs) [z]

(* addNumbers : number list -> float
 *)
let rec addNumbers ns =
  match ns with
  | [] -> 0.0
  | (Int m) :: ms -> (float m) +. addNumbers ms
  | (Flt m) :: ms ->        m  +. addNumbers ms

(****************    The game of craps.    ********************)

(* roll : unit -> int *)
let roll () = (Random.int 6) + 1

(* sevenOrEleven : int -> bool *)
let sevenOrEleven n = (n = 7) || (n = 11)

(* hit : int -> bool *)
let rec hit mark =
  let reRoll = roll() + roll() in
  let _ = Lib.pfmt "reRoll is %d\n" reRoll
  in
  match reRoll = mark with
  | true  -> true
  | false -> not (sevenOrEleven reRoll) && (hit mark)

(* craps : unit -> string *)
let craps () =
  let mark = roll() + roll() in
  let _ = Lib.pfmt "Welcome!\nThe mark is %d.\n" mark
  in
  match (sevenOrEleven mark) || (hit mark) with
  | true  -> "You win!"
  | false -> "You lose!"
