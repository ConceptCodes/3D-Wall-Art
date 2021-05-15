font = "Sarabun:style=Bold Italic";

string = "text";

// $fn = 100; higher render quality
$fn = 20;
height = 30;
font_size = 50;
spacing = .78;

wall = 10;

// bottom letters are thicker to support
// the top letters

bottom_height = height * 2;

wall_mount_y_top = 120;

difference(){
    letter(string, font, font_size, height, wall);
}


module letter(character, font, font_size, height, wall, support_wall_sub, hollow=true) {
    difference() {
        hollow_letter(character, font, font_size, height, wall, hollow=hollow);
        
        if (hollow){
            translate([0,0,(wall/2)- height/2])
            support(character, font, font_size, height, wall, support_wall_sub);
        }
    }
}

module make_text(character, font, font_size, height){
    linear_extrude(height=height)
    text(text=character,size=font_size,font=font,spacing=spacing);
}

module hollow_letter(character, font, font_size, height, wall, support_wall_sub, hollow =true) {
    difference(){
        minkowski(){
            make_text(character, font, font_size, height);
            cube([wall,wall,wall],center=true);
        }
        
        if (hollow){
            make_text(character, font, font_size, height);
        }
    }
}

module support(character, font, font_size, height, wall, wall_sub) {
    color("pink")
    translate([0,0,height])
    minkowski() {
        make_text(character, font, font_size, height);
        cube(wall - wall_sub, center=true);
    }
}