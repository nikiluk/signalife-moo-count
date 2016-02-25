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
	outputPath = inputPath+"\\output\\";
	File.makeDirectory(outputPath); 
	
	list = getFileList(input);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + list[i]))
			processFolder("" + input + list[i]);
		if(endsWith(list[i], suffix))
			processFile(input, outputPath, list[i]);
	}
}

function processFile(input, output, file) {
	// do the processing here by replacing
	// the following two lines by your own code
	run("Bio-Formats", "open=["+input+file+"] autoscale color_mode=Default view=Hyperstack stack_order=XYCZT stitch_tiles");
	saveAs("Tiff", output+file);
	run("Z Project...", "projection=[Max Intensity]");
	run("Scale Bar...", "width=1000 height=50 font=180 color=White background=None location=[Upper Right] bold hide overlay");
	saveAs("Tiff", output+"MAX_"+file);
	saveAs("Jpeg", output+"MAX_"+file);
	print("Processing MIP: " + input + file);
	print("Saving MIP to: " + output);
	run("Close");
}
