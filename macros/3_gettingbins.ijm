setTool("multipoint");
run("Point Tool...", "type=Hybrid color=Yellow size=Small label counter=0");

getSelectionCoordinates(xCoordinates, yCoordinates);
for(i=1; i<=(lengthOf(xCoordinates)); i++) {
    //print(i + " ("+ xCoordinates[i-1] + "; " + yCoordinates[i-1]+")"+" ("+ xCoordinates[i] + "; " + yCoordinates[i]+")");
    
    defineLine(xCoordinates[i-1], yCoordinates[i-1] ,xCoordinates[i], yCoordinates[i], 400, 2500);
	i=i+1;
    wait(2000);
}

function defineLine(x1, y1 ,x2, y2, binW, binL) {
	beforePia = 100;
	
	linePts = newArray(0,0,0,0); 
	basis = newArray(1,1); 

	basis[0] = x2-x1;
	basis[1] = y2-y1;
	print(basis[0]);
	print(basis[1]);
	basismodule = sqrt(basis[0]*basis[0]+basis[1]*basis[1]);
	print(basismodule);

	
	basis[0] = basis[0]/basismodule;
	basis[1] = basis[1]/basismodule;
	print("updated shit");
	print(basis[0]);
	print(basis[1]);
	
	linePts[0]=x1-basis[0]*beforePia;
	linePts[1]=y1-basis[1]*beforePia;
	linePts[2]=linePts[0]+basis[0]*binL;
	linePts[3]=linePts[1]+basis[1]*binL;
	
	run("Line Width...", "line="+binW+"");
	makeLine(linePts[0],linePts[1],linePts[2],linePts[3]);
	
	Array.print(linePts);
	return linePts;

}

