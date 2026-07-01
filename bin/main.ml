(** @author Juanru(Stella) Zhang (jz766) *)

open A5.Garden

let help_message = 
  "
  Reminder: Your computer must be able to support 
  unicode characters, especially emojis, for this program. 
  
  Ages 0-9: Plant is a Seed
  
  Ages 10-14: Plant is Small
  
  Ages 15 and beyond: Plant reaches adulthood. At this stage, the plant can stay
  as a normal Adult, or it can catch an Illness, and an Adult Flower can 
  randomly bloom in two different ways: FFlower and SFlower. 
  
  The plant dies at age 50. 
  
  Here's a diagram of all the plants and their representations: 
  
  | Condition  | Flower     | Tree      |
  ----------------------------------------
  | Dead       | 🟫         | 🟫         |
  | Seed       | 🥔         | 🥔         |
  | Small      | 🌱         | 🌿         |
  | Adult      | 🍀         | 🌳         |
  | Illness    | 🥀         | 🌾         |
  | FFlower    | 🌼         | None       |
  | SFlower    | 🌸         | None       |
  ----------------------------------------
  
  If you need more details, you can check the design document.
  "

let () = 
  let argv : string list = Array.to_list Sys.argv in
  if List.length argv = 4 then 
    try 
      let number_rows = int_of_string (List.nth argv 1) in
      let number_columns = int_of_string (List.nth argv 2) in
      let fps = int_of_string (List.nth argv 3) in
      let garden = CreateGarden.create_garden number_rows number_columns in
      let rec loop rate = CreateGarden.print_garden garden;
        if number_rows != 0 && number_columns!= 0 then (
          CreateGarden.update_plants garden number_rows number_columns );
        Unix.sleepf rate;
        loop (1. /. float_of_int fps)
      in loop (1. /. (float_of_int fps))
    with
      |_ -> print_endline "Please ensure you entered valid inputs."
  else if List.length argv = 2 && List.nth argv 1 = "-h" then 
    print_endline help_message
  else print_endline "Please enter valid arguments."
