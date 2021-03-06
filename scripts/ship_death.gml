// Games Programming Assignment 1
// Add game feature:   Ship Death
// Student Number:     S10122326F
// Student Name:       Jeremy Lim

// Add game feature:   Ship re-spawning
// Student Number:     S10131808A
// Student Name:       Elliot Tan

var ship_owner = owner;

// destroy children
with(hp_greybar){
    instance_destroy();
}
with(hp_redbar){
    instance_destroy();
}
with(hp_heart){
    instance_destroy();
}
with(ulti_yellowbar){
    instance_destroy();
}
with(ulti_greybar){
    instance_destroy();
}
with(ulti_icon){
    instance_destroy();
}
for(var i = 0; i < 5; ++i){
    with(hud_traps[i]){
        instance_destroy();
    }
}

// deactivate ultis
// end ulti timer
if (ulti_timer >= 0) {
    ulti_timer = -1;
    if(ship_type == SHIP_XEBEC)
        xebec_ulti_deactivate();
    /*
    if(ship_type == SHIP_GALLEASS)
        galleass_ulti_deactivate();
    */
}

stop_shield_sound();

// destroy ship
instance_destroy();
global.ships_lost[ship_owner]++;

// recreate next ship
if (global.player_ships_index[ship_owner] <= MAX_SHIPS) {
    var ship, player_no;
    
    // spawn ship in appropriate location
    if (ship_owner == PLAYER_ONE) {
        ship = instance_create(50, room_height*0.5, ship1_obj);
        player_no = PLAYER_ONE;
    }
    else if (ship_owner == PLAYER_TWO) {
        ship = instance_create(room_width - 50, room_height*0.5, ship2_obj);
        player_no = PLAYER_TWO;
    }
    
    // run ship creation code
    with (ship) {
        ship_create(player_no, global.player_ships_selection[ship_owner,
            player_ships_index[ship_owner]++]);
    }
    
    // update global array
    global.ships[ship_owner] = ship;
    
    // update "other_ship" variables
    if (ship_owner == PLAYER_TWO) {
        // rotate player 2's ship correctly
        ship.image_angle = 180;
        if (instance_exists(global.ships[PLAYER_ONE])) {
            ship.other_ship = global.ships[PLAYER_ONE].id;
            ship.other_ship.other_ship = global.ships[PLAYER_TWO].id;
        }
    }
    else {
        if (instance_exists(global.ships[PLAYER_TWO])) {
            ship.other_ship = global.ships[PLAYER_TWO].id;
            ship.other_ship.other_ship = global.ships[PLAYER_ONE].id;
        }
    }
    
    // display random help text
    var rand_help_text = get_random_tip();
    if (global.is_new_player) {
        help_text = instance_create(room_width * 0.5, room_height * 0.4, help_text_obj);
        help_text.text = rand_help_text;
        help_text.animate_index = -1;
        help_text.alarm[0] = room_speed * 4;
        help_text.image_xscale = 6.5;
    }
}

// player has run out of ships
else {
    // delay before checking for winner
    with(alarmer_obj){
        //set alarm to check if a player won or draw
        alarm[1] = 1 * room_speed;
    }
}
