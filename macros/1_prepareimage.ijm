//open("C:\\Users\\Nikita\\Desktop\\sample czi images\\output\\MAX_25x_id8872_p-p_cre-neg_slide-2_slice-4_m2-m1_left.tif");
filepath=File.openDialog("Select a File"); 
run("Bio-Formats", "open=["+filepath+"] autoscale color_mode=Default view=Hyperstack stack_order=XYCZT stitch_tiles");

//testRbr(20);
//testRbr(30);
//testRbr(40);

inputDir = getDirectory("image");
fileName = getTitle;
filePath = inputDir+fileName;
print(inputDir);
print(fileName);
print(filePath);
watershedDir=inputDir+"watershed";
File.makeDirectory(watershedDir);


prepareImageForCounting(30);


run("Duplicate...", "title=_start");
saveAs("Tiff", watershedDir+"\\_start");

//start of experiments
run("Duplicate...", "title=w-e-d");
run("Watershed");
run("Erode");
run("Dilate");
saveAs("Tiff", watershedDir+"\\w-e-d");
close();

run("Duplicate...", "title=e-d-w");
run("Erode");
run("Dilate");
run("Watershed");
saveAs("Tiff", watershedDir+"\\e-d-w");
close();

run("Duplicate...", "title=e-w-e-d");
run("Erode");
run("Watershed");
run("Erode");
run("Dilate");
saveAs("Tiff", watershedDir+"\\e-w-e-d");
close();

run("Duplicate...", "title=e-w-e-c-d");
run("Erode");
run("Watershed");
run("Erode");
run("Close-");
run("Dilate");
saveAs("Tiff", watershedDir+"\\e-w-e-c-d");
close();

//goooood ewecdw
run("Duplicate...", "title=e-w-e-c-d-w");
run("Erode");
run("Watershed");
run("Erode");
run("Close-");
run("Dilate");
run("Watershed");
saveAs("Tiff", watershedDir+"\\e-w-e-c-d-w");
close();

run("Duplicate...", "title=e-d-w-e-c-d-w");
run("Erode");
run("Dilate");
run("Watershed");
run("Erode");
run("Close-");
run("Dilate");
run("Watershed");
saveAs("Tiff", watershedDir+"\\e-d-w-e-c-d-w");
close();

function testRbr(rbr) {
	run("Duplicate...", "title="+rbr);
	prepareImageForCounting(rbr);
	saveAs("Tiff", filePath+"_"+rbr);
	close(); 
}



function prepareImageForCounting(rollingBallRadius) {
	//Prepare the image
	run("Subtract Background...", "rolling="+rollingBallRadius);
	//setTool("zoom");
	setAutoThreshold("Default dark");
	setOption("BlackBackground", false);
	run("Convert to Mask");
	//run("Watershed");
	//run("Erode");
	//run("Dilate");
    //run("Erode");
	//run("Dilate");

	
	
}