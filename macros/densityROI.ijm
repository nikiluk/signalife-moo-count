id = getImageID();
for (i=0 ; i<roiManager("count"); i++) {
    selectImage(id);
    roiManager("select", i);
    current = Roi.getName();
	run("Measure");
	run("Set Measurements...", "area mean area_fraction limit display redirect=None decimal=3");

}