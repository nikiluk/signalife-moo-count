filePath=File.openDialog("Select a File"); 
run("Bio-Formats", "open=["+filePath+"] autoscale color_mode=Default view=Hyperstack stack_order=XYCZT stitch_tiles");

inputDir = getDirectory("image");
fileName = getTitle;
filePath = inputDir+fileName;

id = getImageID();
//setAutoThreshold("Default");

run("ROI Manager...");
roiManager("Open", inputDir+"RoiSet.zip");
roiManager("Show All");

for (i=0 ; i<roiManager("count"); i++) {
    selectImage(id);
    roiManager("select", i);
    current = Roi.getName();
    areaFilePath = inputDir+"area_" + current + ".xls";
    

    run("Set Measurements...", "area centroid center perimeter bounding fit shape feret's skewness kurtosis area_fraction display redirect=None decimal=3");
    run("Analyze Particles...", "size=25-Infinity display exclude clear summarize");
    wait(100);
    selectWindow("Results"); 
	saveAs("Results", areaFilePath);
	wait(100);
	run("Close");
}

wait(100);
selectWindow("Summary"); 
saveAs("Results", inputDir+fileName+"_summary.xls");
run("Close");

if (isOpen("ROI Manager")) {
	selectWindow("ROI Manager");
    run("Close");
}

selectWindow(fileName); 
run("Select None");
