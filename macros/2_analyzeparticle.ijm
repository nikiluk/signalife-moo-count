id = getImageID();
setAutoThreshold("Default");

run("ROI Manager...");
roiManager("Open", "C:\\Users\\Nikita\\Desktop\\sample czi images\\25x_id8872_p-p_cre-neg_slide-2_slice-4_m2-m1_left\\RoiSet.zip");
roiManager("Show All");

for (i=0 ; i<roiManager("count"); i++) {
    selectImage(id);
    roiManager("select", i);
    run("Set Measurements...", "area perimeter fit display redirect=None decimal=3");
    run("Analyze Particles...", "size=25-Infinity display exclude clear summarize");

    current = Roi.getName();
	saveAs("Results", "C:\\Users\\Nikita\\Desktop\\sample czi images\\25x_id8872_p-p_cre-neg_slide-2_slice-4_m2-m1_left\\area_" + current + ".xls");
	wait(100);
}
wait(100);
saveAs("Results", "C:\\Users\\Nikita\\Desktop\\sample czi images\\25x_id8872_p-p_cre-neg_slide-2_slice-4_m2-m1_left\\results_all.xls");