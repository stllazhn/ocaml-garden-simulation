(** Module type to represent a plant. *)
module type PlantType = sig
    (** Represents different species of plants. The species can be a Flower or a 
    Tree. *)
    type plant_species 

    (** Represents different conditions of plants. The condition can be Seed, 
        Small, Adult, Dead, Mutate, FFlower, or SFlower*)
    type plant_condition 

    (** Represents a plant, including its species, age, and current condition. 
        *)
    type plant 

    (** [initial_plant ()] creates a new plant. *)
    val initial_plant : unit -> plant

    (**[make_plant species condition age] creates a new plant based on the 
    given string [species], string [condition], and int [age]*)
    val make_plant : string -> string -> int -> plant

    (** [get_species plant] gets the species of [plant] *)
    val get_species : plant -> string

    (** [get_condition plant] gets the condition of [plant] *)
    val get_condition : plant -> string

    (** [get_age plant] gets the age of [plant] *)
    val get_age : plant -> int

    (** [plant_logo plant ] is the emoji representation of a plant. *)
    val plant_logo : plant -> string

    (** [age_up plant] changes the condition of [plant] according to its age. *)
    val age_up : plant -> unit

    (** [illness_strikes plant] has a random chance to change the condition of 
        [plant] to Mutate. *)
    val illness_strikes : plant -> unit

    (** [kill_plant plant] has a random chance to change the condition of 
        [plant] to Dead. *)
    val kill_plant : plant -> unit

    (** [heal_illness plant] has a random chance to change the condition of a 
        [plant] in Mutate condition back to a normal condition such as Seed, 
        Small, or Adult, or change it condition to Dead, 
        or let its condition remain as Mutate. *)
    val heal_illness : plant -> unit

    (** [new_plant plant] has a random chance to change the [plant] into 
        new plant, with a randomized species, the condition as Seed, and the 
        age as 0. *)
    val new_plant : plant -> unit

    (** [flower_bloom plant] has a random chance to change the condition of a
        Flower species, Adult condition [plant] into FFlower or SFlower. *)
    val flower_bloom : plant -> unit

    (** [flower_close plant] has a random chance to change the condition of a
        FFlower or SFlower condition [plant] into Adult. *)
    val flower_close : plant -> unit

    (** [change_plant plant] changes the age, species, and condition of [plant] 
        based on its age, species, and condition. *)
    val change_plant : plant -> unit   
end

module CreatePlant : PlantType