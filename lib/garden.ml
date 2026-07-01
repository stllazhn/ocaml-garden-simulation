module type GardenType = sig
  type garden 

  val empty : unit -> garden

  val create_garden : int -> int -> garden

  val garden_size : garden -> int*int

  val print_garden : garden -> unit

  val update_plants : garden -> int -> int -> unit
end


module CreateGarden : GardenType = struct
  open Plant.CreatePlant

  type garden = plant array array

  let empty () : garden = [||]

  let create_garden (rows : int) (columns : int) =
    if (rows = 0 || columns = 0) then empty () else
      let garden = Array.make_matrix rows columns (initial_plant ()) in
      for i = 0 to rows - 1 do
        for j = 0 to columns - 1 do
          garden.(i).(j) <- initial_plant ()
        done
      done; 
    garden
  
  let garden_size (garden: garden) =
    let rows = Array.length garden in
    let columns = if rows<>0 then Array.length garden.(0) else 0 in
    (rows, columns)

  let print_garden (garden : garden) =
    let number_rows = Array.length garden in
    let number_columns =
      if number_rows > 0 then Array.length garden.(0)
      else 0
    in
    for _ = 0 to (2 * number_columns + 1) do print_string "-" done; 
    print_newline ();
    if number_columns = 0 then print_endline "||";
    for i = 0 to (number_rows - 1) do
      print_string "|";
      for j = 0 to (number_columns - 1) do 
        print_string (plant_logo garden.(i).(j)) done;
      print_string "|";
      print_newline ();
    done;
    for _ = 0 to (2 * number_columns + 1) do print_string "-" done;
    print_newline ()
  
  let update_plants (garden : garden) number_rows number_columns = 
    for i = 0 to (number_rows - 1) do
      for j = 0 to (number_columns - 1) do 
        change_plant garden.(i).(j) 
      done;
    done;
end




