item_on_screen(evergreen, 103816).
quantity(103816, 1).
workable(evergreen).
choppable(evergreen).
item_on_screen(flower, 100672).
quantity(100672, 1).
pickable(flower).
item_on_screen(evergreen, 106346).
quantity(106346, 1).
item_on_screen(grass, 101072).
diggable(grass).
workable(grass).
quantity(101072, 1).
item_on_screen(sapling, 102489).
diggable(sapling).
workable(sapling).
quantity(102489, 1).
pickable(sapling).
item_on_screen(sapling, 102487).
quantity(102487, 1).
item_on_screen(rabbit, 102020).
quantity(102020, 1).
cookable(rabbit).
item_on_screen(flower, 100673).
quantity(100673, 1).
item_on_screen(butterfly, 108067).
quantity(108067, 1).
workable(butterfly).
item_on_screen(rabbithole, 107336).
quantity(107336, 1).
diggable(rabbithole).
workable(rabbithole).
item_on_screen(rabbit, 102139).
quantity(102139, 1).
item_on_screen(rabbithole, 107335).
quantity(107335, 1).
item_on_screen(wormhole, 101810).
quantity(101810, 1).
item_on_screen(grass, 101412).
quantity(101412, 1).
pickable(grass).
item_on_screen(grass, 101396).
quantity(101396, 1).
item_on_screen(sapling, 102491).
quantity(102491, 1).
item_on_screen(evergreen, 104590).
quantity(104590, 1).
slot_in_inventory(log, 100025).
fuel(log).
collectable(log).
slot_in_inventory(carrot, 100026).
edible(carrot).
collectable(carrot).
cookable(carrot).
slot_in_inventory(carrot_cooked, 100027).
edible(carrot_cooked).
collectable(carrot_cooked).
slot_in_inventory(pinecone, 100028).
fuel(pinecone).
collectable(pinecone).
slot_in_inventory(flint, 100029).
collectable(flint).
slot_in_inventory(meat, 100030).
edible(meat).
collectable(meat).
cookable(meat).
slot_in_inventory(monstermeat, 100031).
edible(monstermeat).
collectable(monstermeat).
cookable(monstermeat).
slot_in_inventory(cookedmeat, 100032).
edible(cookedmeat).
collectable(cookedmeat).
slot_in_inventory(cutgrass, 100033).
fuel(cutgrass).
collectable(cutgrass).
item_in_inventory(log, 13).
item_in_inventory(carrot, 5).
item_in_inventory(carrot_cooked, 7).
item_in_inventory(pinecone, 11).
item_in_inventory(flint, 4).
item_in_inventory(meat, 4).
item_in_inventory(monstermeat, 2).
item_in_inventory(cookedmeat, 15).
item_in_inventory(cutgrass, 1).
equipment(axe).
equipment_guid(axe, 100034).
quantity(100034, 1).
equippable(axe).
collectable(axe).
sanity(high).
hunger(high).
health(high).
time(day, end).

good_pick(planted_carrot).
good_pick(carrot).
good_pick(axe).
good_pick(twigs).
good_pick(flint).
good_pick(log).
good_pick(cutgrass).
good_pick(berrybush).
good_pick(berries).
good_pick(sapling).


torch_ingredients(A):- item_in_inventory(cutgrass, X), item_in_inventory(twigs, X), X.>=.2.

axe_ingredients(A):- item_in_inventory(flint, X), item_in_inventory(twigs, X), X.>=.1.

campfire_ingredients(A):- item_in_inventory(log, X), X.>=.2, item_in_inventory(cutgrass, Y), Y.>=.3.

garland_ingredients(A):- item_in_inventory(petals, X), X.>=.12.

% action(short_description, functionToUseInLua, FunctionArguments)
action(equip_torch_night_hostile, equip, GUID) :- time(night, T), not equipment(torch), item_in_inventory(torch, X), hostile(E), slot_in_inventory(torch, GUID).
action(run_away_from_enemy, run_away, GUID) :- hostile(GUID).
action(eat_food_low, eat_food, GUID) :- hunger(low), item_in_inventory(X, N), edible(X), slot_in_inventory(X, GUID).
action(pick_flower, pick_entity, GUID) :- -time(night, T), sanity(low), item_on_screen(flower, GUID).
action(wander_flower, wander, nil) :- -time(night, T), sanity(low).
action(walk_to_fueled_campfire, walk_to_entity, GUID) :- time(night, T), item_on_screen(X, GUID), fueled(GUID), isinlight(plr), X=campfire, X=firepit.
action(build_campfire, build, campfire) :- time(dusk, end), campfire_ingredients(X), -item_on_screen(campfire, X).
action(equip_torch_night_no_campfire, equip, GUID) :- time(night, T), item_in_inventory(torch, X), not equipment(torch), slot_in_inventory(torch, GUID).
action(build_torch_night, build, torch) :- time(night), torch_ingredients(X), not item_in_inventory(torch, X).
action(cook_food, cook, GUID) :- cookable(GUID), slot_in_inventory(X, GUID), time(night).
action(build_axe, build, axe) :- axe_ingredients(X), not equipment(axe), not item_in_inventory(axe, N).
action(build_torch, build, torch) :- torch_ingredients(X), not equipment(torch), not item_in_inventory(torch, N).
action(equip_axe, equip, axe) :- not equipment(axe), item_in_inventory(axe, N), -time(night, T).
action(pick_log, pick_entity, GUID) :- item_on_screen(log, GUID).
action(chop_tree, chop_tree, GUID) :- item_on_screen(X, GUID), choppable(X), equipment(axe).
action(pick_anything, pick_entity, GUID) :- item_on_screen(X, GUID), good_pick(X).
action(wander, wander, nil) :- -time(night, T).

% ?- action(DESC, FUNC, ARGS).
?- action(DESC, FUNC, ARGS).