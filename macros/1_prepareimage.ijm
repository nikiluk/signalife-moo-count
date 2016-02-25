open("C:\\Users\\Nikita\\Desktop\\sample czi images\\output\\MAX_25x_id8872_p-p_cre-neg_slide-2_slice-4_m2-m1_left.tif");
//Prepare the image
run("Subtract Background...", "rolling=20");
//setTool("zoom");
setAutoThreshold("Default dark");
setOption("BlackBackground", false);
run("Convert to Mask");
run("Watershed");
run("Erode");
run("Dilate");