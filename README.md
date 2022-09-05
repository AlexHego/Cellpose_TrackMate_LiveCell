# Cellpose_GIGA
A generalist algorithm for cell and nucleus segmentation. 
<img src="https://raw.githubusercontent.com/kevinjohncutler/cellpose/master/cellpose/logo/logo.png?raw=True" width="250" title="cellpose" alt="cellpose" align="right" vspace = "50">
<img src="https://www.cellpose.org/static/images/cellpose2.gif" width="500" title="cellpose2" alt="cellpose2 vs cellpose1 results" align="center" vspace = "50">

**CITATION**: If you use the new human-in-the-loop training or the new models, please cite the Cellpose 2.0 [paper](https://www.biorxiv.org/content/10.1101/2022.04.01.486764v1). If you use the original built-in models (`cyto` or `nuclei`), please cite the Cellpose 1.0 [paper](https://t.co/kBMXmPp3Yn?amp=1).

Cellpose was written by Carsen Stringer and Marius Pachitariu. To learn about Cellpose 2.0 (human-in-the-loop), read the [paper](https://www.biorxiv.org/content/10.1101/2022.04.01.486764v1) or watch the [talk](https://www.youtube.com/watch?v=3ydtAhfq6H0). To learn about Cellpose 1.0, read the [paper](https://t.co/kBMXmPp3Yn?amp=1) or watch the [talk](https://t.co/JChCsTD0SK?amp=1). For support, please open an [issue](https://github.com/MouseLand/cellpose/issues).  Please find the detailed documentation at <span style="font-size:larger;">[cellpose.readthedocs.io]

## Step-by-step tutorial
#### 1. Starting Cellpose GUI
1. double click on Cellpose_2 shortcut on the desktop

#### (optional) Starting Cellpose GUI by with conda
1. Activate miniconda3
2. conda activate cellpose
3. python -m cellpose

####  2. load your images
1. Drag and drop your images .tif, .png, .jpg, .gif) into the GUI

#### 3. Using the Cellpose GUI

The GUI serves two main functions:
1. Running the segmentation algorithm.
2. Manually labelling data.
3. (NEW) Fine-tuning a pretrained cellpose model on your own data.

#### Main GUI controls
- Pan = left-click + drag
- Zoom = scroll wheel (or +/= and - buttons)
- Full view = double left-click
- Select mask = left-click on mask
- Delete mask = Ctrl (or Command on Mac) + left-click
- Merge masks = Alt + left-click (will merge last two)
- Start draw mask = right-click
- End draw mask = right-click, or return to circle at beginning
<img src="https://www.cellpose.org/static/images/cellpose_gui.png" width="500" title="cellpose2 gui screenshot" alt="cellpose2 gui screenshot" align="right" vspace = "50">

