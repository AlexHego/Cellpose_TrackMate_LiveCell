////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////// This macro was written in august 2022 by Alexandre Hego 
////// This macro will analyse .tif files from incucyte, will run sequuence on the well , merge the phase green and red
////// This macro need imagej 1.52 or an updated version of FIJI
////// If you need more informations please contact alexandre.hego@uliege.be
////// Please remove the space in the folder name and file name
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// version
// version 2 : This macro will not run if the Phase doesn't exist
//version 3: This macro run alphabet from A to H

#@ File (label = "RAW data", style = "directory") input
#@ File (label = "output with merge files", style = "directory") output
#@ String (label = "File suffix", value = ".tif") suffix
#@ Integer (label = "replicate per well", value = "1") number


// Fresh startup
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
print("\\Clear");
// close all images
close("*");
// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
// configure that binary image are black in background, objects are white
setOption("BlackBackground", true);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

list = getFileList(input);
list = Array.sort(list);

i = 1;
// run alphabet
for (row=65; row<73; row++) {
	rowlet = fromCharCode(row);
	i = 1;
	while (i <= 12){
		j=1;
		count = 0;
		// name of the well
		name = rowlet +i+"_"+j;
		// regular expression to find more than 0 file with the name Phase_ + name of the well
		RegExp = ".*Phase_" + name + ".*";
		for (k = 1; k < list.length; k++) {
			if (matches(list[k], RegExp) > 0) {
				count ++;
			}
		}
		if (count > 0) {
			for (j = 1; j < number +1; j++) {
				name = rowlet +i+"_"+j;
				RegExp = ".*" + name + ".*";
				File.openSequence(input, " filter=(Phase_"+name+") sort");
				run("16-bit");
				rename("Phase");
				File.openSequence(input, " filter=(Green_"+name+") sort");
				rename("Green");
				File.openSequence(input, " filter=(Red_"+name+") sort");
				rename("Red");
				run("Merge Channels...", "c1=Red c2=Green c4=Phase create");
				run("Re-order Hyperstack ...", "channels=[Channels (c)] slices=[Frames (t)] frames=[Slices (z)]");
				saveAs("TIF", output + File.separator + name);
				close("*");
				print(name + " done");
			}
			i++;
		}
		else {
		i++;
		continue;
		}
	}
}

print(" the macro ends!!");