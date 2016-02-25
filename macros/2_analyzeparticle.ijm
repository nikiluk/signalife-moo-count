run("ROI Manager...");
roiManager("Open", "C:\\Users\\Nikita\\Desktop\\sample czi images\\RoiSet.zip");
roiManager("Show All");


id = getImageID();
setAutoThreshold("Default");
for (i=0 ; i<roiManager("count"); i++) {
    selectImage(id);
    roiManager("select", i);
    run("Set Measurements...", "area perimeter fit display redirect=None decimal=3");
    run("Analyze Particles...", "size=25-Infinity display exclude clear summarize");

    current = Roi.getName();
	saveAs("Results", "C:\\Users\\Nikita\\Desktop\\sample czi images\\output\\area_" + current + ".xls");
	wait(100);
}
wait(100);
saveAs("Results", "C:\\Users\\Nikita\\Desktop\\sample czi images\\output\\results_all.xls");