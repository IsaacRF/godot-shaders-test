shader_type canvas_item;

uniform vec3 replacement_color:source_color;

void fragment() {	
	// Filter out the green channel from the picture,
	// so we can determine which areas
	// have red and blue components in them
	vec3 color_without_green = COLOR.rgb * vec3(1, 0, 1);
	// Make a number indicating the amount of
	// red and blue in the fragment by calling
	// the length function
	float redbblue_amount = length(color_without_green);
	// Use the step function to create a mask for
	// the parts that are containing red and blue
	float redbblue_mask = step(0.2, redbblue_amount);
	// 1.- Store the color that we don't want to change (rest of the sprite)
	vec3 retained_color = COLOR.rgb * redbblue_mask;
	
	// Invert the red and blue mask and multiply it
	// with the green channel of the image so we get a
	// nice blending mask for the replacement color
	float green_mask = (1.0 - redbblue_mask) * COLOR.g;
	// 2.- Calculate the replacement color in the correct
	// intensity to blend with the rest of the image.
	vec3 masked_replacement_color = replacement_color * green_mask;
	
	// 3.- Finally composite the original image and the
	// replacement color on top of each other
	COLOR.rgb = retained_color + masked_replacement_color;
}
