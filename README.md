
# Defective Product Inspection System Using MATLAB Image Processing

## Description

This project presents a MATLAB-based image processing system for detecting defective products from digital images.

The system processes product images using grayscale conversion, noise filtering, edge detection, feature extraction, and threshold-based classification to determine whether a product is GOOD or BAD.

## Objectives

- Capture and process product images.
- Remove image noise using median filtering.
- Detect product edges using Canny edge detection.
- Identify possible defective regions.
- Classify products as GOOD or BAD.
- Provide a simple graphical user interface (GUI).

## Technologies Used

- MATLAB
- MATLAB Image Processing Toolbox
- MATLAB App Designer / Programmatic GUI
- Digital Image Processing

## System Workflow

```text
Input Image
     ↓
Grayscale Conversion
     ↓
Noise Filtering
     ↓
Edge Detection
     ↓
Feature Extraction
     ↓
Threshold Classification
     ↓
GOOD / BAD PRODUCT
````

## Project Structure

```text
Defective-Product-Inspection/
│
├── good_images/
├── defective_images/
├── results/
├── src/
│   ├── main.m
│   └── GUI.m
│
├── screenshots/
└── README.md
```

## How to Run

1. Open MATLAB or MATLAB Online.
2. Upload the project files.
3. Open the main MATLAB file.
4. Run the program.
5. Upload a product image.
6. Click **Inspect Product**.
7. The system displays the inspection result.

## Classification

The system uses the number of detected edge pixels as a simple feature.

Images with edge counts above the experimentally selected threshold are classified as defective, while images below the threshold are classified as good.

Note: The threshold used in this project is specific to the experimental dataset and may need adjustment for other images or products.

## Results

The system was tested using both good and defective product images.

| Product           | Edge Pixels | Classification |
| ----------------- | ----------: | -------------- |
| Good Product      |       7,897 | GOOD           |
| Defective Product |      49,913 | BAD            |

## Limitations

* The system depends on image quality and lighting.
* The classification threshold is dataset-dependent.
* The current method is designed for academic demonstration rather than industrial production.
* Different product types may require different thresholds.

## Future Improvements

Future versions could include:

* Machine learning classification.
* More advanced defect segmentation.
* Automatic threshold selection.
* Support for multiple product types.
* Improved accuracy under different lighting conditions.

## Author

**Goodness Ngozi**
Department of Cybersecurity

## Academic Project

This project was developed as part of the requirements for **CYB 302**.
