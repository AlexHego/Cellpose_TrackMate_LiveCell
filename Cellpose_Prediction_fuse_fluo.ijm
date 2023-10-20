////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Cellpose_Prediction_fuse_fluo2.ijm
// Author: Alexandre Hego, alexandre.hego@uliege.be
// October 2023
// Licence: BSD-3
//
// Preprocessing : Please export the data from the incucyte with the following prefix:
// for Phase contrast data : Phase_
// for Green contrast data : Green_
// for Red contrast data : Red_
//
// This script use the BIOP wrappers for fiji, an imageJ2 command that enables using a working Cellpose virtual environment(either conda, or venv) from Fiji.
// The code and the instracutions are available at https://github.com/BIOP/ijl-utilities-wrappers 
// This script will generate Cellpose mask and then fuse the mask and the green fluorescence as an hyperstack. If you need to fuse Red data please change the variable Green_ by Red_ in line 97
// Note: Please remove the space in the folder name and file name
// Note 2:  Please change the directory of your own model in line 56
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Fresh Fiji startup
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

//ask for the input and creation of output directories
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
#@ File (label = "Phase images directory", style = "directory") input
#@ File (label = "Fluorescence images directory", style = "directory") input2
#@ File (label = "Output directory for Cellpose prediction label", style = "directory") output
#@ File (label = "Output directory for final images label + fluo", style = "directory") output2
#@ Integer (label = "replicate per well", value = "1") number
/////////////////////////////////////////////////////////////////////////////////////////////////////////////



// Generation of the cellpose mask
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
list = getFileList(input);
list = Array.sort(list);
for (i = 0; i < list.length; i++) {
	j = i+1;
	if (endsWith(list[i],".png")){
		inputPath = input + File.separator + list[i];
		run("Bio-Formats Importer", "open=inputPath color_mode=Composite rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
		imagesName= getTitle();
		run("Grays");
		print("Cellpose prediction on image : " + j + "/" + list.length + "  " + imagesName + "  Please wait");
		run("Cellpose Advanced (custom model)", "diameter=20 cellproba_threshold=0.0 flow_threshold=0.4 anisotropy=1.0 diam_threshold=38.5 model_path=[D:\\zeiss\\Desktop\\MIFOBIO_2023_Cellpose_TrackMate\\model_incucyte] model=[D:\\zeiss\\Desktop\\MIFOBIO_2023_Cellpose_TrackMate\\model_incucyte] nuclei_channel=0 cyto_channel=1 dimensionmode=2D stitch_threshold=0.0 omni=false cluster=false additional_flags=");
		rename("1");
		selectImage(imagesName);
		close();
		saveAs("TIFF", output + File.separator + imagesName);
		close("*");
	}
}
print("Cellpose predictions are done, fusion start. Please wait");
///////////////////////////////////////////////////////////////////////////////////////////////////////////


// Fuse data based on the name of the well and the replicate
///////////////////////////////////////////////////////////////////////////////////////////////////////////
list = getFileList(output);
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
				File.openSequence(output, " filter=(Phase_"+name+") sort");
				run("16-bit");
				rename("Mask");
				File.openSequence(input2, " filter=(Green_"+name+") sort");
				rename("Green");
				run("Merge Channels...", "c2=Green c4=Mask create");
				run("Re-order Hyperstack ...", "channels=[Channels (c)] slices=[Frames (t)] frames=[Slices (z)]");
				saveAs("TIF", output2 + File.separator + name);
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

print("The analysis is done in folder : " + output2);
///////////////////////////////////////////////////////////////////////////////////////////////////////////
