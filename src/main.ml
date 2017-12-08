let input = "1122";;

let firstchar = 1122;;

(* how do I parse characters out of a string? *)

let int = int_of_string input;;

(* Okay, I have an int representing the first char. how do I loop? *)

let day1 = (
    Printf.printf "%d\n" int;
);;

let () = (
    (* Example Comment *)
    Printf.printf "%s\n" "Hello, World!";
    day1
);;