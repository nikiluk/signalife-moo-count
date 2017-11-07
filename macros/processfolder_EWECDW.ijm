/*
 * Macro template to process multiple images in a folder
 */

startTime = getTime();

inputPath = getDirectory("Input directory");
Dialog.create("File type");
Dialog.addString("File suffix: ", ".czi", 5);
Dialog.show();
suffix = Dialog.getString();

processFolder(inputPath);


endTime = getTime();

print(endTime-startTime);



// FUNCTIONS GO BELOW

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
	
	
	run("Bio-Formats", "open=["+input+fileExt+"] autoscale color_mode=Default view=Hyperstack stack_order=XYCZT stitch_tiles");
	originalFileName = getTitle;
	getDimensions(width, height, channels, slices, frames);
	getVoxelSize(voxelWidth, voxelHeight, voxelDepth, voxelUnit); 

	//create directory
	outputProcessedFolder = output+"PROCESSED\\";
	File.makeDirectory(outputProcessedFolder);
	outputFileFolder = outputProcessedFolder+fileNoExt+"_slices-"+slices+"\\";
	File.makeDirectory(outputFileFolder);

	
	//save TIF stack - don't really need this
	
	//this worked for files smaller than 4GB
	//saveAs("Tiff", outputFileFolder+fileExt+"_slices-"+slices);

	//this to try...
	//run("Bio-Formats Exporter", "save=["+outputFileFolder+fileExt+"_slices-"+slices+".ome.tif] export compression=Uncompressed");
	
	//create and save MIP
	run("Z Project...", "projection=[Max Intensity]");
	saveAs("Tiff", outputFileFolder+"MIP_"+fileExt+"_slices-"+slices);
	
	//close the TIF stack
	selectWindow(originalFileName);
	wait(1000);
	run("Close");
	
	//save JMIP
	run("Duplicate...", "title=JMIP");
	run("Scale Bar...", "width=1000 height=50 font=180 color=White background=None location=[Upper Right] bold hide overlay");
	selectWindow("JMIP"); 
	
	fontSize=height*0.02;
	setFont("Arial", fontSize, "antialiased");
	makeText("z-stack: "+slices+" slices\n"+voxelWidth+"*"+voxelHeight+"*"+voxelDepth+" "+voxelUnit, 2*fontSize, 2*fontSize);
	
	run("Add Selection...", "stroke=white");
	run("Flatten");
	saveAs("Jpeg", outputFileFolder+"JMIP_"+fileExt+"_slices-"+slices);
	
	//close the flat image
	run("Close");
	
	
	//close the JMIP
	selectWindow("JMIP"); 
	wait(1000);
	run("Close");

	//prepare and close the EWEDCW
	selectWindow("MIP_"+fileExt+"_slices-"+slices+".tif");
	getPixelSize(unit, pixelWidth, pixelHeight);
	//rolling ball radius in um = 20
	rbr=floor(20/pixelWidth);
	prepareEWECDW(rbr);
	saveAs("Tiff", outputFileFolder+"EWECDW_"+fileExt+"_rbr-"+rbr+"_slices-"+slices);
	wait(1000);

	//close MIP
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