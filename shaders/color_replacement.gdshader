shader_type canvas_item;

uniform vec3 cape_color:source_color;
uniform vec3 feather_color:source_color;

void fragment() {
	// Filter out each customizable color channel from the picture,
	// so we can determine which areas have other colors to preserve
	vec3 color_without_green = COLOR.rgb * vec3(1, 0, 1);
	vec3 color_without_red = COLOR.rgb * vec3(0, 1, 1);
	// Make a number indicating the amount of the other colors to preserve
	// in the fragment by calling the length function
	float redbblue_amount = length(color_without_green);
	float greenbblue_amount = length(color_without_red);
	// Use the step function to create a mask with some tolerance for
	// the parts that are containing the other colors to preserve
	float redbblue_mask = step(0.2, redbblue_amount);
	float greenbblue_mask = step(0.3, greenbblue_amount);
	// 1.- Store all the colors to preserve combining the masks of each customizable color
	vec3 retained_color = COLOR.rgb * redbblue_mask * greenbblue_mask;
	
	// The masks are inverted, so invert them multiplying it
	// with the customizable color channel of the image so we get a
	// nice blending mask for the replacement color
	float green_mask = (1.0 - redbblue_mask) * COLOR.g;
	float red_mask = (1.0 - greenbblue_mask) * COLOR.r;
	// 2.- Calculate the replacement color in the correct
	// intensity to blend with the rest of the image.
	vec3 masked_cape_color = cape_color * green_mask;
	vec3 masked_feather_color = feather_color * red_mask;
	
	// 3.- Finally composite the original image and the
	// replacement color on top of each other
	COLOR.rgb = retained_color + masked_cape_color + masked_feather_color;
}
