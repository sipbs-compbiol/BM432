# README.md `figure_critical_analysis` workshop

This directory contains the `R` project, R markdown document, figures, and supporting assets required to generate slides for the BM432 Data Presentation/Visualisation workshop on critical analysis of figures.

## Workshop format

- Students are given access to a PowerPoint file containing ten figures, about a week before the workshop takes place
- Each student is assigned three figures to review and assess
- Students are directed to a Google Form with questions about their comprehension, understanding, and appreciation of the figure
- Shortly before the workshop, the `slides.Rmd` document is run (`knit`ted) to generate the HTML slide output (`slides.html`); these slides form the basis for discussion in the workshop

## How to generate slides

- Replace the URL in l.38 of `slides.Rmd` (`dfm = read_sheet()`) with the link to this year's Google Sheets backend to the form
- Open the `R` project in `RStudio`
- Open the `slides.Rmd` file in the editor
- Click on the `Knit` icon/button

The `slides.html` file can then be used as needed (e.g. opened in the browser during the workshop, added to MyPlace, etc.)

## How it works

- The Google Form is used to collect student responses in a Google Sheets spreadsheet (**this must be viewable by anyone with the link**)
- The R markdown document uses the `googlesheets4` package to obtain the spreadsheet data as a `data.frame`, which is cleaned by:
  - renaming columns
  - filtering out old data (prior to a specified date)
  - converting some columns from character arrays to integer or factor types
  - enforcing a sensible order of factor levels in some cases
- The downloaded data is then used to construct `ggplot2` figures, word clouds, and tables

- Figures should be clearly labelled with the appropriate number in the `images` subdirectory, e.g. `figure_1.jpg`.

- CSS styling for the slides is contained in `includes/custom.css`

## Adding `slides.html` to MyPlace

- Create a new `File` object in the workshop section
  - Give it a sensible subject line, and description
  - Select the appropriate `Appearance`, e.g. "New Window" or "Embed," as desired
- Upload the `slides.html` file
- Click `Save and Return to Class`

## Creating a new Google Form

The Python script `create_form.py` will, when run, create a new Google Form, based on the template in `bm432_google_form.json`.

Running the script for the first time should ask you to authenticate with Google using OAuth (this is safe - we keep no information and make no changes other than to create the form). Once authenticated, run the script _again_ to create the form. The script will report on progress and provide URLs for access to the new form, e.g.

```bash
% ./create_form.py
Adding item Please indicate which figure you are using to answer the following questions. (You may analyse more than one figure, but please fill in a separate form for each figure.)
Adding item On a scale of 1-5, please rate how effective you found the data visualization in this figure.
Adding item On a scale of 1-5, please rate how easy you found it to understand this figure.
Adding item On a scale of 1-5, please rate how aesthetically appealing you found this figure.
[...]
Adding item Please add any comments or feedback that you would like to make about this data visualisation exercise. We particularly welcome suggestions for improvements.

The form has ID: 1zc5MhGiAWrkRKObyViNDrCrDoLJOLkKToJfrdCMELBA
View at: https://docs.google.com/forms/d/e/1FAIpQLSeezUDLwObaDUDZcCz7dmygfDcAsUNb21Ma4lEi-LvgPFwOBw/viewform
Edit via: https://docs.google.com/forms/d/1zc5MhGiAWrkRKObyViNDrCrDoLJOLkKToJfrdCMELBA/edit
```


