(** Module type to represent a garden. *)
module type GardenType = sig
    (** Represents a garden. *)
    type garden 

    (** [empty ()] creates an empty garden of 0 rows and columns. *)
    val empty : unit -> garden

    (** [create_garden rows columns] creates a new garden with the specified 
        numeric number of [rows] and [columns]. 
        Requires: [rows] and [columns] are nonnegative integers. *)
    val create_garden : int -> int -> garden

    (** [garden_size garden] returns the number of rows and columns of [garden]*)
     val garden_size : garden -> int*int

    (** [print_garden garden] prints the given [garden] to the console. *)
    val print_garden : garden -> unit

    (** [update_plants garden] updates the species, age, and condition of 
      every plant in the [garden]. *)
    val update_plants : garden -> int -> int -> unit
end

module CreateGarden : GardenType

