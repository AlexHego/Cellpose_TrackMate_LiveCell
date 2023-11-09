# Cellpose and TrackMate for Live cells imaging

  * [Cellpose](#cellpose)
  * [TrackMate](#trackmate)
- [Step-by-step tutorial](#step-by-step-tutorial)
  * [I. export data from incucyte, installation Fiji and Cellpose](#i-export-data-from-incucyte--installation-fiji-and-cellpose)
  * [II. Starting Cellpose GUI on PC](#ii-starting-cellpose-gui-on-pc)
  * [III. Using the Cellpose GUI](#iii-using-the-cellpose-gui)
    * [Main GUI controls](#main-gui-controls)
    * [Segmentation options](#segmentation-options)
  * [IV. Training your own cellpose model](#iv-training-your-own-cellpose-model)
  * [OPTION for big data or small GPU](#option-for-big-data-or-small-gpu)
  * [V. TrackMate](#v-trackmate)
  * [VI. TrackMate Batcher](#vi-trackmate-batcher)
  * [Citation](#citation)
    + [Citation Cellpose](#citation-cellpose)
    + [Citation TrackMate](#citation-trackmate)
    + [Citation BioImaging And Optics Platform BIOP](#citation-bioimaging-and-optics-platform-biop)

Cellpose
------
Cellpose is a generalist, Deep Learning-based segmentation method, which can precisely segment cells from a wide range of image types. Cellpose was trained on a new dataset of highly varied images of cells, containing over 70,000 segmented objects. Cellpose 2.0 a is new package which includes an ensemble of diverse pretrained models as well as a human-in-the-loop pipeline for quickly prototyping new specialist models. Specialist models pretrained on the Cellpose dataset can achieve state-of-the-art segmentation on new image categories with very little user-provided training data.

<img src="https://www.cellpose.org/static/images/cellpose2.gif" width="400" title="cellpose2" alt="cellpose2 vs cellpose1 results" align="center" vspace = "50">

TrackMate
------
TrackMate provides the tools to perform single particle tracking (SPT). SPT is an image analysis challenge where the goal is to segment and follow over time some labelled, spot-like structures. Each spot is segmented in multiple frames and its trajectory is reconstructed by assigning it an identity over these frames, in the shape of a track. These tracks can then be either visualized or yield further analysis results such as velocity, total displacement, diffusion characteristics, division events, etc...

<img src="https://cellmig.files.wordpress.com/2020/09/stardist_trackmate.gif"  width="250" height="250" />

For details, please see [http://fiji.sc/TrackMate](http://fiji.sc/TrackMate)

# Step-by-step tutorial

I. export data from incucyte, installation Fiji and Cellpose
------
1. Connect to your incucyte session and export the data with the following prefix :
    - `Phase` for Phase contrast data
    - `Green` for green fluorescence
    - `Red` for red fluorescence
2. Download the script [Cellpose_Prediction_fuse_fluo.ijm](https://github.com/AlexHego/Cellpose_TrackMate_LiveCell/blob/main/Cellpose_Prediction_fuse_fluo.ijm) 
3. Download [imageJ/Fiji](https://imagej.net/software/fiji/downloads)
4. Update ImageJ/Fiji > `Help` > `Update...` > `Manage Update Sites` > 
    - Add `PTBIOP` Only if you have big data bigger than 1/4 of your VRAM 
    - Add `TrackMate-Helper`
6. Close Fiji
7. Installation Cellpose in [English](https://github.com/MouseLand/cellpose) or  in [French](https://forgemia.inra.fr/gt-maiia/kit-du-debutant/-/wikis/Installation-Cellpose-sur-Windows10#installation-cellpose-via-anaconda3-alex-nicolas)

II. Starting Cellpose GUI on PC
------
1. double click on Cellpose_2 shortcut on the desktop
2. (optional) Starting Cellpose GUI by with conda : Activate miniconda3 > `conda activate cellpose` > `python -m cellpose`

III. Using the Cellpose GUI
------
The GUI serves : Running the segmentation algorithm, manually labelling data, fine-tuning a pretrained cellpose model on your own data.
</br>

<img src="https://www.cellpose.org/static/images/cellpose_gui.png" width="480" title="cellpose2 gui screenshot" alt="cellpose2 gui screenshot" align="right" vspace = "50">

Main GUI controls
------
- `Pan` = left-click + drag

- `Zoom` = scroll wheel (or +/= and - buttons)
  
- `Full view` = double left-click
  
- `Select mask` = left-click on mask
  
- `Delete mask` = Ctrl (or Command on Mac) + left-click
  
- `Merge masks` = Alt + left-click (will merge last two)
  
- `Start draw mask` = right-click
  
- `End draw mask` = right-click, or return to circle at beginning
</br>
**Note: ** Overlaps in masks are NOT allowed. If you draw a mask on top of another mask, it is cropped so that it doesn’t overlap with the old mask. Masks in 2D should be single strokes (if single_stroke is checked).
  
Segmentation options
------
- `SIZE`: you can manually enter the approximate diameter for your cells, or press “calibrate” to let the model estimate it. The size is represented by a disk at the bottom of the view window (can turn this disk off by unchecking “scale disk on”).
- `GPU`: activate it to save time
- `MODEL`: there is a cytoplasm model and a nuclei model, choose what you want to segment
- `CHAN TO SEG`: this is the channel in which the cytoplasm or nuclei exist
- `CHAN2` (OPT): if cytoplasm model is chosen, then choose the nuclear channel for this option

IV. Training your own cellpose model
------
1. Drag and drop your images .tif, .png, .jpg, .gif) into the GUI
2. Run Try one cellpose models in the GUI. Make sure that if you have a nuclear channel you have selected it for CHAN2.
3. Fix the region of interrest (ROIs) by deleting incorrect (CTRL + left click) and drawing new ones (right click and close the shape)
4. Save the modification with CTRL + S
5. Go to the “Models” menu in the File bar at the top and click “Train new model…” or use shortcut CTRL+T.
6. Choose the pretrained model to start the training from (the model you used in #2), and type in the model name that you want to use. The other parameters should work well in general for most data types. Then click OK.
7. The model will train (much faster if you have a GPU) and then auto-run on the next image in the folder. 
8. Next you can repeat #3-#6 as many times as is necessary.
9. The trained model is available to use in the future in the GUI in the “custom model” section and is saved in your image folder.
  
OPTION for big data or small GPU 
------
Predict Cellpose with BIOP per time point and then fuse the timelapse data per well
1. Open FIJI
2. Drag and drop the script [Cellpose_Prediction_fuse_fluo.ijm](https://github.com/AlexHego/Cellpose_TrackMate_LiveCell/blob/main/Cellpose_Prediction_fuse_fluo.ijm)
3. Correct the variables in the script if needed, like size of the cells, location of your model etc...
4. Click Run and follow the instructions

V. TrackMate
------
1. Open FIJI
2. Open a timelapse data
3. Start TrackMate
4. Select a detector > `Label image detector`
5. Segment in channel 2
6. Filter the spot if needed like size, position etc...
7. Select LAP Tracker and set the `Linking max distance`, `Gap-closing max distance`, `Gap-closing max frame gap`
8. Save the .xml file for batch analysis

VI. TrackMate Batcher
------
<img src="https://global.discourse-cdn.com/business4/uploads/imagej/optimized/3X/f/9/f9933e441404488234805dc40182cdbec1108725_2_651x750.png" width="300" align="right" />

1.  Top-left specify the paths to the input images. You can drag and drop folder and files on this quadrant, they will be added automatically
</br>

2.    The top-right specify the tracking parameters you want to use. Here you need to browse (drag and drop also works) to a TrackMate XML file where the settings are saved.
 </br>
 
3.  The bottom-left specify the outputs of the batch process. You can export CSV tables, an Excel table, and AVI movies as well as the TrackMate file for each of the input images.
 </br>
 
4.  The bottom-right quadrant logs the process. </br>

Citation
------

### Citation Cellpose
Cellpose is based on a publication, If you use it successfully for your research please be so kind to cite these papers : for the new human-in-the-loop training or the new models, please cite the Cellpose 2.0 [paper](https://www.biorxiv.org/content/10.1101/2022.04.01.486764v1). </br> If you use the original built-in models (`cyto` or `nuclei`), please cite the Cellpose 1.0 [paper](https://t.co/kBMXmPp3Yn?amp=1).

For details, please see [https://github.com/MouseLand/cellpose](https://github.com/MouseLand/cellpose)

### Citation TrackMate

Please note that TrackMate is available through Fiji, and is based on a publication. If you use it successfully for your research please be so kind to cite these papers:

Ershov, D., Phan, M.-S., Pylvänäinen, J. W., Rigaud, S. U., Le Blanc, L., Charles-Orszag, A., … Tinevez, J.-Y. (2022). TrackMate 7: integrating state-of-the-art segmentation algorithms into tracking pipelines. Nature Methods, 19(7), 829–832.  https://doi.org/10.1038/s41592-022-01507-1 (https://www.nature.com/articles/s41592-022-01507-1)
</br> and / or </br>
Jean-Yves Tinevez, Nick Perry, Johannes Schindelin, Genevieve M. Hoopes, Gregory D. Reynolds, Emmanuel Laplantine, Sebastian Y. Bednarek, Spencer L. Shorte, Kevin W. Eliceiri, __TrackMate: An open and extensible platform for single-particle tracking__, Methods, Available online 3 October 2016, ISSN 1046-2023, http://dx.doi.org/10.1016/j.ymeth.2016.09.016 (http://www.sciencedirect.com/science/article/pii/S1046202316303346)

### Citation BioImaging And Optics Platform BIOP 
Please note that Cellpose wrapper for Fiji was created by BioImaging And Optics Platform (BIOP). If you use it successfully for your research please be so kind to cite this repository:

[BIOP wrappers :](https://github.com/BIOP/ijl-utilities-wrappers/blob/master/README.md) 
