// Games Programming Assignment 1
// Add game feature:   Ship active abilities
// Student Number:     S10122326F, S10131808A
// Student Name:       Jeremy Lim, Elliot Tan

// disallow usage of abilty if ship is dead
// (but object is not yet destroyed: still animating)
if (self.hp <= 0) exit;

// if ulti is not on cooldown
if (ulti_countdown <= 0) { 
    // Xebec's ulti activation
    if (ship_type == SHIP_XEBEC) {
        ulti_timer = room_speed * 3;
        xebec_ulti_activate();
    }
    // Galleass's ulti activation
    else if (ship_type == SHIP_GALLEASS) {
        // ulti_timer = room_speed * 3;
        galleass_ulti_activate();
    }
    // Corvette's ulti activation
    else if (ship_type == SHIP_CORVETTE) {
        corvette_ulti_activate();
    }
    // Carrack's ulti activation
    else if (ship_type == SHIP_CARRACK) {
        carrack_ulti_activate();
    }

    // set ulti on cooldown
    ulti_countdown = ship_ulti_cooldown[ship_type] * room_speed;
}