// Games Programming Assignment 1
// Add game feature:   Ship spawning, fort spawning
// Student Number:     S10122326F
// Student Name:       Jeremy Lim

// Add game feature:   Wind/Currents
// Student Number:     S10131808A
// Student Name:       Elliot Tan

// create black background that fades out in 0.5 seconds
black_bg_init_fade_in(false, ROOM_FADE_TIME);

// sound toggle button
instance_create(room_width - 40, 40, sound_toggle_obj);
instance_deactivate_object(sound_toggle_obj);

// hide mouse cursor
cursor_sprite = -1;

//increase games played counter
global.games_played++;

globalvar ships;                    // stores ships currently in game for accessibility
globalvar player_ships_index;       // curent ship counter for each player
globalvar ships_lost;
globalvar winnerFound;
globalvar winner;

winnerFound = false;

global.player_ships_index[PLAYER_ONE] = 1;
global.player_ships_index[PLAYER_TWO] = 1;

global.ships_lost[PLAYER_ONE] = 0;
global.ships_lost[PLAYER_TWO] = 0;

/*
* Determine which ship to use based on ship type.
* Spawn ships on extreme left and right side of map.
*/

// create player 1's ship
var ship1 = instance_create(50, room_height*0.5, ship1_obj);
with (ship1) {
    ship_create(PLAYER_ONE,
        global.player_ships_selection[PLAYER_ONE, player_ships_index[PLAYER_ONE]++]);
}

// create player 2's ship
var ship2 = instance_create(room_width - 50, room_height*0.5, ship2_obj);
with (ship2) {
    ship_create(PLAYER_TWO,
        global.player_ships_selection[PLAYER_TWO, player_ships_index[PLAYER_TWO]++]);
}
ship2.image_angle = 180;

ship1.other_ship = ship2.id;
ship2.other_ship = ship1.id;

global.ships[PLAYER_ONE] = ship1;
global.ships[PLAYER_TWO] = ship2;

/*
* Spawn forts symmetrically somewhere in the middle of the map.
* Lower bound of random is not 0 to keep it off the side of the map.
* Upper bound is that to just calculate positions for half the map,
* and keep them off the middle line.
*/

var spawnX, spawnY, spawnX2, spawnY2;

spawnX = random_range(room_width / 8, room_width / 8 * 3);
spawnY = random_range(room_height / 8, room_height / 8 * 3);
spawnX2 = random_range(room_width / 8, room_width / 8 * 3);
spawnY2 = random_range(room_height / 8 * 5, room_height / 8 * 7);

var fort11 = instance_create(spawnX, spawnY, fort_obj);
var fort12 = instance_create(spawnX2, spawnY2, fort_obj);
var fort21 = instance_create(room_width - spawnX, room_height - spawnY, fort_obj);
var fort22 = instance_create(room_width - spawnX2, room_height - spawnY2, fort_obj);
fort_set_owner(fort11, PLAYER_ONE);
fort_set_owner(fort12, PLAYER_ONE);
fort_set_owner(fort21, PLAYER_TWO);
fort_set_owner(fort22, PLAYER_TWO);

// create random currents
for (var i = 0; i < random_range(5, 15); i++) {
    // random position
    spawnX = random_range(0, room_width);
    spawnY = random_range(0, room_height);
    var current = instance_create(spawnX, spawnY, current_obj);
    
    // random direction
    current.direction =  random_range(0, 360);
    current.image_angle = current.direction;
    
    // random size
    var rand_scale = random_range(0.3, 0.5);
    current.image_xscale *= rand_scale;
    current.image_yscale *= rand_scale;
}

// background sound
if (audio_is_paused(waves_sound))
    audio_resume_sound(waves_sound);
    
if (!audio_is_playing(background_sound))
     audio_play_sound(background_sound, 90, 1);
audio_sound_gain(background_sound, 0.35,
    audio_sound_get_track_position(background_sound));

create_fog(true);

// display random help text
var rand_help_text = get_random_tip();
if (global.is_new_player) {
    help_text = instance_create(room_width * 0.5, room_height * 0.4, help_text_obj);
    help_text.text = rand_help_text;
    help_text.animate_index = -1;
    help_text.alarm[0] = room_speed * 4;
    help_text.image_xscale = 6.5;
}
