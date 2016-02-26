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