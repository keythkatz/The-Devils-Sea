// Games Programming Assignment 1
// Add game feature:   HUD
// Student Number:     S10122326F
// Student Name:       Jeremy Lim

/*
* Draw players' HUD
*/
if(object_index == ship1_obj){
    draw_set_color(c_blue);
}else{
    draw_set_color(c_red);
}
draw_set_halign(fa_middle);
draw_set_valign(fa_middle);
draw_set_font(ship_font2);

var yoffset = 44;
if(y > room_height - 100) yoffset = -60;
//draw_text(x, y + offset, string(hp) + " HP | " + string(traps) + " Traps#Ulti " + ulti_display);

//move hp bar
hp_greybar.x = x - 40;
hp_greybar.y = y + yoffset + 0;
hp_redbar.x = x - 40;
hp_redbar.y = y + yoffset + 0;
hp_redbar.image_xscale = (hp / (ship_hp[ship_type] * HP_MULTIPLIER)) * 1.4;
hp_heart.x = x - 47;
hp_heart.y = y + yoffset + 0;
//draw_text(x, y + yoffset + 0, "HP");

//move ulti bar
ulti_greybar.x = x - 40;
ulti_greybar.y = y + yoffset + 10;
ulti_yellowbar.x = x - 40;
ulti_yellowbar.y = y + yoffset + 10;
ulti_yellowbar.image_xscale = (1 - ulti_countdown / (ship_ulti_cooldown[ship_type] * room_speed)) * 1.4;
if(ulti_countdown == 0) ulti_yellowbar.sprite_index = green_bar_sprite;
else ulti_yellowbar.sprite_index = yellow_bar_sprite;
ulti_icon.x = x - 47;
ulti_icon.y = y + yoffset + 10;
//draw_text(x, y + yoffset + 40, "Ability");

//move trap counter
for(var i = 0; i < 5; ++i){
    var xoffset = -36 + i * (45 * 2 / 5);
    hud_traps[i].x = x + xoffset;
    hud_traps[i].y = y + yoffset + 25;
    if(i < traps) hud_traps[i].visible = true;
    else hud_traps[i].visible = false;
}
