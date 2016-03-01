startTime = getTime();





// "right" or "left"
hemisphere = "right";





filePath=File.openDialog("Select a File"); 
run("Bio-Formats", "open=["+filePath+"] autoscale color_mode=Default view=Hyperstack stack_order=XYCZT stitch_tiles");

inputDir = getDirectory("image");
fileName = getTitle;
filePath = inputDir+fileName;

id = getImageID();
//setAutoThreshold("Default");

run("ROI Manager...");
roiManager("Open", inputDir+"RoiSet-"+ hemisphere +".zip");
roiManager("Show All");

for (i=0 ; i<roiManager("count"); i++) {
    selectImage(id);
    roiManager("select", i);
    current = Roi.getName();
    areaFilePath = inputDir + hemisphere + "_area-" + current + ".xls";
    

    run("Set Measurements...", "area centroid center perimeter bounding fit shape feret's area_fraction display redirect=None decimal=3");
    run("Analyze Particles...", "size=50-300 display exclude clear summarize");
    wait(1000);
    selectWindow("Results"); 
	saveAs("Results", areaFilePath);
	wait(1000);
	run("Close");
}

wait(2000);
selectWindow("Summary"); 
saveAs("Results", inputDir+hemisphere+"_summary_"+fileName+".xls");
run("Close");

if (isOpen("ROI Manager")) {
	selectWindow("ROI Manager");
    run("Close");
}

selectWindow(fileName); 
run("Select None");

endTime = getTime();
print(endTime-startTime);
