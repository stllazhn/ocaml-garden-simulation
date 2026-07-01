
module type PlantType = sig
  
  type plant_species 

  type plant_condition 

  type plant 

  val initial_plant : unit -> plant

  val make_plant : string -> string -> int -> plant

  val get_species : plant -> string

  val get_condition : plant -> string

  val get_age : plant -> int

  val plant_logo : plant -> string

  val age_up : plant -> unit

  val illness_strikes : plant -> unit

  val kill_plant : plant -> unit

  val heal_illness : plant -> unit

  val new_plant : plant -> unit

  val flower_bloom : plant -> unit

  val flower_close : plant -> unit

  val change_plant : plant -> unit   
end

module CreatePlant : PlantType = struct
  type plant_species = Flower | Tree

  type plant_condition = Seed | Small | Adult | Dead | Illness | FFlower 
  | SFlower

  type plant = {mutable species : plant_species; 
  mutable condition : plant_condition; mutable age : int}

  let () = Random.self_init () 

  let initial_plant () = 
    let random_species =
      match Random.int 2 with
      | 0 -> Flower
      | _ -> Tree
    in
    { species = random_species; condition = Dead; age = 0 }
  
  let make_plant species condition (age : int) =
    let species_type =
      match species with
      |"Flower" -> Flower
      |_-> Tree
    in 
    let condition_type =
      match condition with
      |"Small"->Small
      |"Seed"->Seed
      |"Adult"->Adult
      |"Illness"->Illness
      |"FFlower"->FFlower
      |"SFlower"->SFlower
      |_->Dead
    in
    {species = species_type; condition = condition_type; age = age}

  let get_species plant = 
    match plant.species with
      |Flower -> "Flower"
      |_-> "Tree"
  
  let get_condition plant = 
    match plant.condition with
      |Small->"Small"
      |Seed->"Seed"
      |Adult->"Adult"
      |Illness->"Illness"
      |FFlower->"FFlower"
      |SFlower->"SFlower"
      |_->"Dead"
  
  let get_age plant = plant.age


  let plant_logo (plant : plant) =
    match plant.condition with 
    | Seed -> "🥔"
    | Small -> 
      (match plant.species with
      | Flower -> "🌱"
      | Tree -> "🌿")
    | Adult -> 
      (match plant.species with
      | Flower -> "🍀"
      | Tree -> "🌳")
    | Illness -> 
      (match plant.species with
      | Flower -> "🥀"
      | Tree -> "🌾")
    | FFlower -> "🌼"
    | SFlower -> "🌸"
    | Dead -> "🟫"

  let age_up (plant : plant) =
    if plant.age > 9 && plant.age < 15 then plant.condition <- Small
    else if plant.age >= 15 then plant.condition <- Adult

  let illness_strikes (plant : plant) =
    match plant.condition with
    |Seed |Small |Dead -> ()
    |_ ->
      let random_number = Random.int 10 in
      if random_number = 7 then plant.condition <- Illness
    
  let kill_plant (plant : plant) =
    let random_number = Random.int 20 in
    if random_number = 10 then (plant.condition <- Dead; plant.age <- 0)

  let heal_illness (plant : plant) =
    if plant.condition = Illness then
    let number_limit =
      if plant.age < 20 then 15
      else if (plant.age < 35) then 20
      else 25 in 
    let random_number = Random.int number_limit in
    if random_number < 8 then plant.condition <- Adult 
    else if random_number > 13 then (plant.condition <- Dead; plant.age <- 0)

  let new_plant (plant : plant) =
    let random_number = Random.int 8 in
    if random_number = 5 then 
      (plant.species <- Flower; plant.condition <- Seed; plant.age <- 0)
    else if random_number = 3 then
      (plant.species <- Tree; plant.condition <- Seed; plant.age <- 0)

  let flower_bloom (plant : plant) =
    if plant.condition = Adult && plant.species = Flower then
      let random_number = Random.int 8 in
      if random_number = 6 then plant.condition <-FFlower 
      else if random_number = 3 then plant.condition <- SFlower 

  let flower_close (plant : plant) =
    if plant.condition = FFlower || plant.condition = SFlower then
    let random_number = Random.int 4 in
    if random_number = 1 then plant.condition <- Adult
    
  let change_plant (plant : plant) =
    kill_plant plant;
    if plant.condition = Dead then (plant.age <- 0; new_plant plant)
    else if (plant.condition = Seed || plant.condition = Small) then 
      (age_up plant; 
      if plant.condition <> Dead then plant.age <- plant.age + 1;)
    else if plant.age >= 50 then (plant.condition <- Dead; plant.age <- 0;)
    else
      (flower_bloom plant;
      flower_close plant;
      heal_illness plant;
      illness_strikes plant;
      if plant.condition <> Dead then plant.age <- plant.age + 1;);
end

    
  
