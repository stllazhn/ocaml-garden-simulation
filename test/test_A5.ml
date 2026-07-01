open OUnit2
open A5.Plant
open QCheck
open Gen
open CreatePlant
open A5.Garden
open CreateGarden

let gen_species = Gen.oneof [Gen.return "Flower"; Gen.return "Tree"]

let gen_condition = Gen.oneof
    [ Gen.return "Seed"; Gen.return "Small"; Gen.return "Adult"; 
    Gen.return "Dead"; Gen.return "Illness"; Gen.return "FFlower"; 
    Gen.return "SFlower"]

let gen_plant = (Gen.map3 (fun species condition age -> 
  CreatePlant.make_plant species condition age ) 
  gen_species gen_condition small_nat) |> QCheck.make

let correct_age = Test.make 
  ~name: "Correct age behavior"
  ~count: 1000
  (gen_plant)
  (fun plant ->
  let initial_condition = get_condition plant in age_up plant;
  if get_age plant > 9 && get_age plant < 15 then get_condition plant = "Small"
  else if get_age plant >= 15 then get_condition plant = "Adult"
  else get_condition plant = initial_condition)

let correct_illness = Test.make 
  ~count: 1000
  ~name: "Correct illness behavior"
    (gen_plant)
    (fun plant ->
      let initial_condition = get_condition plant in
      CreatePlant.illness_strikes plant;
      match initial_condition with
      |"Seed" |"Small" |"Dead" -> get_condition plant <> "Illness"
      | _ -> true)

let correct_heal = Test.make 
  ~count: 1000
  ~name: "Correct heal behavior"
  (gen_plant)
  (fun plant ->
    let initial_condition = get_condition plant in
    heal_illness plant;
    match initial_condition with
    |"Illness" ->
    get_condition plant = "Adult" || get_condition plant = "Dead" ||
    get_condition plant = "Illness"
    |_ -> true
    )

let correct_close = Test.make 
  ~count: 1000
  ~name: "Correct close behavior"
  (gen_plant)
  (fun plant ->
    let initial_condition = get_condition plant in
    CreatePlant.flower_close plant;
    match initial_condition with
    |"FFlower" |"SFlower" ->
      get_condition plant = "Adult" || get_condition plant = "FFlower" || 
      get_condition plant = "SFlower"
    |_ -> true
    )

let correct_bloom = Test.make 
  ~count: 1000
  ~name: "Correct heal behavior"
  (gen_plant)
  (fun plant ->
    let initial_condition = get_condition plant in
    flower_bloom plant;
    match initial_condition, get_species plant with
    |"Adult","Flower" -> true
    |_ -> get_condition plant <> "FFlower" || get_condition plant <> "SFlower"
    ) 

  let correct_increase = Test.make
  ~count: 1000
  ~name: "Correct age increase behavior"
  (gen_plant)
  (fun plant ->
    let initial_age = get_age plant in
    change_plant plant;
    match get_condition plant with
    |"Dead" -> get_age plant = 0
    |"Seed" -> get_age plant = 0 || get_age plant = initial_age + 1
    |_-> get_age plant = initial_age +1)


let old_plant = make_plant "Flower" "Adult" 150

let seed_plant = make_plant "Flower" "Seed" 10

let small_plant = make_plant "Tree" "Small" 15

let random_one = make_plant "Tree" "Small" 13

let test_change = [
  "Die of old age" >:: (fun _ -> change_plant old_plant; 
  assert_equal "Dead" (get_condition old_plant));
  "Seed to Small" >:: (fun _ -> change_plant seed_plant; 
  if get_condition seed_plant <> "Dead" then assert_equal "Small" 
    (get_condition seed_plant));
  "Small to Adult" >:: (fun _ -> change_plant small_plant; if 
  get_condition small_plant <> "Dead" then assert_equal "Adult" 
  (get_condition small_plant));
  "No age up" >:: (fun _ -> change_plant random_one; 
  if get_condition random_one <> 
    "Dead" then assert_equal "Small" (get_condition random_one));
  "Dead age to zero" >:: (fun _ -> change_plant old_plant; 
  assert_equal 0 (get_age old_plant));
  "0 row and column garden" >:: (fun _ -> assert_equal (0,0) 
  (garden_size (create_garden 0 0)));
  "Non 0 row and column garden" >:: (fun _ -> assert_equal (8,10) 
  (garden_size (create_garden 8 10)))
]
 
let ounit_test =
  List.map QCheck_runner.to_ounit2_test [correct_age; correct_bloom; 
  correct_close; correct_heal; correct_increase; correct_illness]

let suite_one =
  "Individual property tests" >::: ounit_test 

let suite_two =
  "Change tests" >::: test_change

let _ = run_test_tt_main ("All tests" >:::[suite_one; suite_two])
  

