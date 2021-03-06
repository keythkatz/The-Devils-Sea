// Games Programming Assignment 1
// Add game feature:   Cannons (destroy cannonball,
//                     cause damage, only on unfriendly ships)
// Student Number:     S10131808A
// Student Name:       Elliot Tan

if (other.hp <= 0) exit;

// get size of cannonball (0 - small, 1 - medium)
var size = argument0;

// friendly cannonballs don't hit friendly ships
if (self.owner != other.owner) {    
    // damage ship
    with (other) {
        if (size == 0)
            ship_damage(30, 50);
        else
            ship_damage(40, 70);
    }
}
