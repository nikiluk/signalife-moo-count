/*
 * Macro template to process multiple images in a folder
 */

inputPath = getDirectory("Input directory");
Dialog.create("File type");
Dialog.addString("File suffix: ", ".czi", 5);
Dialog.show();
suffix = Dialog.getString();

processFolder(inputPath);

function processFolder(input) {
	//outputPath = inputPath+"\\output\\";
	outputPath = inputPath;
	//File.makeDirectory(outputPath); 
	
	list = getFileList(input);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + list[i]))
			processFolder("" + input + list[i]);
		if(endsWith(list[i], suffix))
			processFile(input, outputPath, list[i]);
	}
}

function processFile(input, output, fileExt) {
	//single output file folder for each file

    dotIndex = indexOf(fileExt, "."); 
    fileNoExt = substring(fileExt, 0, dotIndex);
	outputFileFolder = output+fileNoExt+"\\";
	File.makeDirectory(outputFileFolder);
	
	run("Bio-Formats", "open=["+input+fileExt+"] autoscale color_mode=Default view=Hyperstack stack_order=XYCZT stitch_tiles");
	
	//getDimensions(width, height, channels, slices, frames);
	
	saveAs("Tiff", outputFileFolder+fileExt);
	run("Z Project...", "projection=[Max Intensity]");
	run("Scale Bar...", "width=1000 height=50 font=180 color=White background=None location=[Upper Right] bold hide overlay");
	saveAs("Tiff", outputFileFolder+"MAX_"+fileExt);
	saveAs("Jpeg", outputFileFolder+"MAX_"+fileExt);
	prepareEWECDW(30);
	saveAs("Tiff", outputFileFolder+"EWECDW_"+fileExt);
	print("Processing MIP: " + input + fileExt);
	print("Saving MIP to: " + outputFileFolder);
	run("Close");
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