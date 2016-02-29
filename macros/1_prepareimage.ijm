startTime = getTime();


//open("C:\\Users\\Nikita\\Desktop\\sample czi images\\output\\MAX_25x_id8872_p-p_cre-neg_slide-2_slice-4_m2-m1_left.tif");
filepath=File.openDialog("Select a File"); 
run("Bio-Formats", "open=["+filepath+"] autoscale color_mode=Default view=Hyperstack stack_order=XYCZT stitch_tiles");



inputDir = getDirectory("image");
fileName = getTitle;
filePath = inputDir+fileName;
print(inputDir);
print(fileName);
print(filePath);
watershedDir=inputDir+"watershed";
File.makeDirectory(watershedDir);

testRbr(7);
testRbr(10);
testRbr(11);
testRbr(12);
testRbr(13);
testRbr(15);
testRbr(20);


endTime = getTime();

print(endTime-startTime);

function testRbr(rbr) {
	run("Duplicate...", "title="+rbr);
	prepareEWECDW(rbr);
	saveAs("Tiff", filePath+"_"+rbr);
	close(); 
}



function prepareEWECDW(rollingBallRadius) {
	//Prepare the image
	run("Subtract Background...", "rolling="+rollingBallRadius);
	//setTool("zoom");
	setAutoThreshold("Default dark");
	setOption("BlackBackground", false);
	run("Convert to Mask");
	run("Erode");
	run("Watershed");
	run("Erode");
	run("Close-");
	run("Dilate");
	run("Watershed");

}