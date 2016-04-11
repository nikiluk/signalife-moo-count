run("Point Tool...", "type=Hybrid color=Red size=Small label counter=0");
setTool("multipoint");
run("Point Tool...", "type=Hybrid color=Green size=Small label counter=0");
getVoxelSize(voxelWidth, voxelHeight, voxelDepth, voxelUnit);
run("ROI Manager...");
getSelectionCoordinates(xCoordinates, yCoordinates);

binWidth = 400; //um
binLength = 1500; //um
delay = 1000;

workingDir = getDirectory("image");
	 
outputPath=workingDir+timeStampo()+"_output\\";
File.makeDirectory(outputPath);

binLegendFile = File.open(outputPath+"binLegend.csv");

for(i=1; i<=(lengthOf(xCoordinates)); i++) {
    //define the line by the initial points

    
    defineLine(xCoordinates[i-1], yCoordinates[i-1] ,xCoordinates[i], yCoordinates[i], binWidth/voxelWidth, binLength/voxelWidth);

	binNumber = (i-1)/2+1; //starts from 1
    exportProfile(outputPath, "Profile_pixels_"+binNumber+".csv");


	//run("Plot Profile");
	
    // add line in the roiManager for the history
    
    roiManager("Add");
    roiManager("Show All with labels");
    roiManager("Select", binNumber-1); //starts from 0, not 1
    roiManager("Rename", binNumber);

	//print binLegend.csv
    print(binLegendFile, binNumber);
    //print the log
	//print("Starting Point:"+i);
    
	i=i+1;
    wait(delay);
}
File.close(binLegendFile)

roiManager("Show All");

run("Point Tool...", "type=Hybrid color=Red size=Small label counter=0");
makeSelection("point", xCoordinates, yCoordinates); 

roiManager("Save", outputPath+"RoiSet-bins-right.zip");
close("Results");

//run("Close");
//run("ROI Manager...");
//roiManager("Open", "C:\\Users\\Nikita\\Desktop\\RoiSet-bins-right.zip");
//roiManager("Show All");

function timeStampo() { 
	timeSta = " ";
	getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);

	if (dayOfMonth<10) {dayOfMonth = "0"+dayOfMonth;}
	if (hour<10) {hour = "0"+hour;}
	if (minute<10) {minute = "0"+minute;}
	if (month<10) {month = "0"+(month+1);}
	
timeSta = ""+year+"-"+month+"-"+dayOfMonth+" "+hour+"h"+minute;
print(timeSta);
return timeSta;
}

function exportProfile(outputPath, fileName) {
	run("Clear Results");
	profile = getProfile();
	
	for (j=0; j<profile.length; j++) //profile.lengths in um
		setResult("Value "+binNumber, j, profile[j]);
	updateResults();
	
	saveAs("Measurements", outputPath+fileName);
	close("Results");
}

function defineLine(x1, y1 ,x2, y2, binW, binL) {
	beforePia = 200;
	
	linePts = newArray(0,0,0,0); 
	basis = newArray(1,1); 

	basis[0] = x2-x1;
	basis[1] = y2-y1;
	//print(basis[0]);
	//print(basis[1]);
	basismodule = sqrt(basis[0]*basis[0]+basis[1]*basis[1]);
	//print(basismodule);

	
	basis[0] = basis[0]/basismodule;
	basis[1] = basis[1]/basismodule;
	//print("updated shit");
	//print(basis[0]);
	//print(basis[1]);

	linePts[0]=x1-basis[0]*beforePia;
	linePts[1]=y1-basis[1]*beforePia;
	linePts[2]=linePts[0]+basis[0]*binL;
	linePts[3]=linePts[1]+basis[1]*binL;
	
	run("Line Width...", "line="+binW+"");
	makeLine(linePts[0],linePts[1],linePts[2],linePts[3]);
	
	//Array.print(linePts);
	return linePts;

}