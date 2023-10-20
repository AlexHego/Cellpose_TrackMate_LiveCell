# Cellpose and TrackMate for Live cells imaging
## Cellpose
A generalist algorithm for cell and nucleus segmentation. 

<img src="https://www.cellpose.org/static/images/cellpose2.gif" width="500" title="cellpose2" alt="cellpose2 vs cellpose1 results" align="center" vspace = "50">

Cellpose was written by Carsen Stringer and Marius Pachitariu. To learn about Cellpose 2.0 (human-in-the-loop), read the [paper](https://www.biorxiv.org/content/10.1101/2022.04.01.486764v1) or watch the [talk](https://www.youtube.com/watch?v=3ydtAhfq6H0). To learn about Cellpose 1.0, read the [paper](https://t.co/kBMXmPp3Yn?amp=1) or watch the [talk](https://t.co/JChCsTD0SK?amp=1). For support, please open an [issue](https://github.com/MouseLand/cellpose/issues).  Please find the detailed documentation at <span style="font-size:larger;">[cellpose.readthedocs.io]

### Step-by-step tutorial
#### I. export data from incucyte, download Fiji and update it
1. Connect to your incucyte session and export the data with the following prefix :
    - `Phase_` for Phase contrast data
    - `Green_` for green fluorescence
    - `Red_` for red fluorescence
2. Download the script [Cellpose_Prediction_fuse_fluo.ijm](https://github.com/AlexHego/Cellpose_TrackMate_LiveCell/blob/main/Cellpose_Prediction_fuse_fluo.ijm) 
3. Download [imageJ/Fiji](https://imagej.net/software/fiji/downloads)
4. Update ImageJ/Fiji > `Help` > `Update...`
5. Restart ImageJ

#### II. Starting Cellpose GUI on PC
1. double click on Cellpose_2 shortcut on the desktop

#### (optional) Starting Cellpose GUI by with conda
Activate miniconda3 > `conda activate cellpose` > `python -m cellpose`


#### III. Using the Cellpose GUI
The GUI serves 
1. Running the segmentation algorithm.
2. Manually labelling data.
3. (NEW) Fine-tuning a pretrained cellpose model on your own data.

    <img src="https://www.cellpose.org/static/images/cellpose_gui.png" width="500" title="cellpose2 gui screenshot" alt="cellpose2 gui screenshot" align="right" vspace = "50">
#### Main GUI controls
  
- `Pan` = left-click + drag
  
- `Zoom` = scroll wheel (or +/= and - buttons)
  
- `Full view` = double left-click
  
- `Select mask` = left-click on mask
  
- `Delete mask` = Ctrl (or Command on Mac) + left-click
  
- `Merge masks` = Alt + left-click (will merge last two)
  
- `Start draw mask` = right-click
  
- `End draw mask` = right-click, or return to circle at beginning

- Overlaps in masks are NOT allowed. If you draw a mask on top of another mask, it is cropped so that it doesn’t overlap with the old mask. Masks in 2D should be single strokes (if single_stroke is checked).
  
#### Segmentation options
- `SIZE`: you can manually enter the approximate diameter for your cells, or press “calibrate” to let the model estimate it. The size is represented by a disk at the bottom of the view window (can turn this disk off by unchecking “scale disk on”).
- `GPU`: activate it to save time
- `MODEL`: there is a cytoplasm model and a nuclei model, choose what you want to segment
- `CHAN TO SEG`: this is the channel in which the cytoplasm or nuclei exist
- `CHAN2` (OPT): if cytoplasm model is chosen, then choose the nuclear channel for this option

#### IV. Training your own cellpose model
1. Drag and drop your images .tif, .png, .jpg, .gif) into the GUI
2. Run Try one cellpose models in the GUI. Make sure that if you have a nuclear channel you have selected it for CHAN2.
3. Fix the region of interrest (ROIs) by deleting incorrect (CTRL + left click) and drawing new ones (right click and close the shape)
4. Save the modification with CTRL + S
5. Go to the “Models” menu in the File bar at the top and click “Train new model…” or use shortcut CTRL+T.
6. Choose the pretrained model to start the training from (the model you used in #2), and type in the model name that you want to use. The other parameters should work well in general for most data types. Then click OK.
7. The model will train (much faster if you have a GPU) and then auto-run on the next image in the folder. 
8. Next you can repeat #3-#6 as many times as is necessary.
9. The trained model is available to use in the future in the GUI in the “custom model” section and is saved in your image folder.
  
#### V. Predict Cellpose and fuse the timelapse data per well with [BIOP wrappers :](https://github.com/BIOP/ijl-utilities-wrappers/blob/master/README.md) 
1. Open FIJI
2. Drag and drop the script [Cellpose_Prediction_fuse_fluo.ijm](https://github.com/AlexHego/Cellpose_TrackMate_LiveCell/blob/main/Cellpose_Prediction_fuse_fluo.ijm)
3. Correct the variables in the script if needed, like size of the cells, location of your model etc...
4. Click Run and follow the istructions

#### V. Predict Cellpose with [BIOP wrappers :](https://github.com/BIOP/ijl-utilities-wrappers/blob/master/README.md)
1. Open FIJI


**CITATION**: If you use the new human-in-the-loop training or the new models, please cite the Cellpose 2.0 [paper](https://www.biorxiv.org/content/10.1101/2022.04.01.486764v1). </br> If you use the original built-in models (`cyto` or `nuclei`), please cite the Cellpose 1.0 [paper](https://t.co/kBMXmPp3Yn?amp=1).
