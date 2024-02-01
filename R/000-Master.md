---
title: "SAGES - Predicting GCP slope"
author: "Doug Tommet"
date: '2024-01-31'
format:
  html:
    toc: true
    self-contained: true
    theme: journal
figures:
  fig-cap-location: top 
execute:
  echo: false
  warning: false
  message: false
keep-md: true
---


::: {.cell}

:::

::: {.cell}

:::

---
editor: 
  markdown: 
    wrap: 72
---


# The data

The data comes from the patient interview, the medcial record review, including lab values and peri-operative data.




::: {.cell}

:::

# Summary of lab values

## Missing values

These are the lab values that were dropped for having more than 50% missing values:

::: {.cell}
::: {.cell-output-display}

```{=html}
<div id="csehbcvrpp" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#csehbcvrpp table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#csehbcvrpp thead, #csehbcvrpp tbody, #csehbcvrpp tfoot, #csehbcvrpp tr, #csehbcvrpp td, #csehbcvrpp th {
  border-style: none;
}

#csehbcvrpp p {
  margin: 0;
  padding: 0;
}

#csehbcvrpp .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#csehbcvrpp .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#csehbcvrpp .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#csehbcvrpp .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#csehbcvrpp .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#csehbcvrpp .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#csehbcvrpp .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#csehbcvrpp .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#csehbcvrpp .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#csehbcvrpp .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#csehbcvrpp .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#csehbcvrpp .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#csehbcvrpp .gt_spanner_row {
  border-bottom-style: hidden;
}

#csehbcvrpp .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#csehbcvrpp .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#csehbcvrpp .gt_from_md > :first-child {
  margin-top: 0;
}

#csehbcvrpp .gt_from_md > :last-child {
  margin-bottom: 0;
}

#csehbcvrpp .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#csehbcvrpp .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#csehbcvrpp .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#csehbcvrpp .gt_row_group_first td {
  border-top-width: 2px;
}

#csehbcvrpp .gt_row_group_first th {
  border-top-width: 2px;
}

#csehbcvrpp .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#csehbcvrpp .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#csehbcvrpp .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#csehbcvrpp .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#csehbcvrpp .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#csehbcvrpp .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#csehbcvrpp .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#csehbcvrpp .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#csehbcvrpp .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#csehbcvrpp .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#csehbcvrpp .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#csehbcvrpp .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#csehbcvrpp .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#csehbcvrpp .gt_left {
  text-align: left;
}

#csehbcvrpp .gt_center {
  text-align: center;
}

#csehbcvrpp .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#csehbcvrpp .gt_font_normal {
  font-weight: normal;
}

#csehbcvrpp .gt_font_bold {
  font-weight: bold;
}

#csehbcvrpp .gt_font_italic {
  font-style: italic;
}

#csehbcvrpp .gt_super {
  font-size: 65%;
}

#csehbcvrpp .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#csehbcvrpp .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#csehbcvrpp .gt_indent_1 {
  text-indent: 5px;
}

#csehbcvrpp .gt_indent_2 {
  text-indent: 10px;
}

#csehbcvrpp .gt_indent_3 {
  text-indent: 15px;
}

#csehbcvrpp .gt_indent_4 {
  text-indent: 20px;
}

#csehbcvrpp .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;Characteristic&lt;/strong&gt;"><strong>Characteristic</strong></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;N = 566&lt;/strong&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>N = 566</strong><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">ALT (IU/L) (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center">19 (15, 23)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">380</td></tr>
    <tr><td headers="label" class="gt_row gt_left">AST (IU/L) (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center">21.0 (18.0, 25.0)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">382</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Bilirubin (mg/dL) (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center">0.40 (0.30, 0.50)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">408</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Albumin (g/dL) (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center">4.20 (4.07, 4.40)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">410</td></tr>
    <tr><td headers="label" class="gt_row gt_left">ABG: pH (POD1)</td>
<td headers="stat_0" class="gt_row gt_center">7.38 (7.34, 7.43)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">540</td></tr>
    <tr><td headers="label" class="gt_row gt_left">p02 (mmHg) (POD1)</td>
<td headers="stat_0" class="gt_row gt_center">148 (104, 203)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">539</td></tr>
    <tr><td headers="label" class="gt_row gt_left">pCO2 (mmHg) (POD1)</td>
<td headers="stat_0" class="gt_row gt_center">42 (37, 43)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">540</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="2"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span> Median (IQR)</td>
    </tr>
  </tfoot>
</table>
</div>
```

:::
:::

Imputation was done on the remaining lab values using predictive mean matching.

## Indicator variables

Indicator variables for low and high values were created for the lab values. 

This section provides summary statistics of whether the lab values met a clinically relevant cutoff.

## Pre-op labs

### Pre-op labs - any abnormality

Note: BUN/CRE ratio and Anion Gap thresholds were not updated and used values from previous work.

::: {.cell}
::: {.cell-output-display}

```{=html}
<div id="onsuwvuxnj" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#onsuwvuxnj table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#onsuwvuxnj thead, #onsuwvuxnj tbody, #onsuwvuxnj tfoot, #onsuwvuxnj tr, #onsuwvuxnj td, #onsuwvuxnj th {
  border-style: none;
}

#onsuwvuxnj p {
  margin: 0;
  padding: 0;
}

#onsuwvuxnj .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#onsuwvuxnj .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#onsuwvuxnj .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#onsuwvuxnj .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#onsuwvuxnj .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#onsuwvuxnj .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#onsuwvuxnj .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#onsuwvuxnj .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#onsuwvuxnj .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#onsuwvuxnj .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#onsuwvuxnj .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#onsuwvuxnj .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#onsuwvuxnj .gt_spanner_row {
  border-bottom-style: hidden;
}

#onsuwvuxnj .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#onsuwvuxnj .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#onsuwvuxnj .gt_from_md > :first-child {
  margin-top: 0;
}

#onsuwvuxnj .gt_from_md > :last-child {
  margin-bottom: 0;
}

#onsuwvuxnj .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#onsuwvuxnj .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#onsuwvuxnj .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#onsuwvuxnj .gt_row_group_first td {
  border-top-width: 2px;
}

#onsuwvuxnj .gt_row_group_first th {
  border-top-width: 2px;
}

#onsuwvuxnj .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#onsuwvuxnj .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#onsuwvuxnj .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#onsuwvuxnj .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#onsuwvuxnj .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#onsuwvuxnj .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#onsuwvuxnj .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#onsuwvuxnj .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#onsuwvuxnj .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#onsuwvuxnj .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#onsuwvuxnj .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#onsuwvuxnj .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#onsuwvuxnj .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#onsuwvuxnj .gt_left {
  text-align: left;
}

#onsuwvuxnj .gt_center {
  text-align: center;
}

#onsuwvuxnj .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#onsuwvuxnj .gt_font_normal {
  font-weight: normal;
}

#onsuwvuxnj .gt_font_bold {
  font-weight: bold;
}

#onsuwvuxnj .gt_font_italic {
  font-style: italic;
}

#onsuwvuxnj .gt_super {
  font-size: 65%;
}

#onsuwvuxnj .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#onsuwvuxnj .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#onsuwvuxnj .gt_indent_1 {
  text-indent: 5px;
}

#onsuwvuxnj .gt_indent_2 {
  text-indent: 10px;
}

#onsuwvuxnj .gt_indent_3 {
  text-indent: 15px;
}

#onsuwvuxnj .gt_indent_4 {
  text-indent: 20px;
}

#onsuwvuxnj .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;Characteristic&lt;/strong&gt;"><strong>Characteristic</strong></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;N = 566&lt;/strong&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>N = 566</strong><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: WBC &lt;= 2 or WBC &gt;= 15 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    WBC normal</td>
<td headers="stat_0" class="gt_row gt_center">561 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    WBC abnormal</td>
<td headers="stat_0" class="gt_row gt_center">5 (0.9%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: HCT &lt;= 21 or HCT &gt;= 62 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    HCT normal</td>
<td headers="stat_0" class="gt_row gt_center">566 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    HCT abnormal</td>
<td headers="stat_0" class="gt_row gt_center">0 (0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: BUN &gt;= 50 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BUN normal</td>
<td headers="stat_0" class="gt_row gt_center">559 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BUN abnormal</td>
<td headers="stat_0" class="gt_row gt_center">7 (1.2%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: CRE &gt;= 5 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    CRE normal</td>
<td headers="stat_0" class="gt_row gt_center">566 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    CRE abnormal</td>
<td headers="stat_0" class="gt_row gt_center">0 (0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: SOD &lt;= 120 or SOD &gt;= 160 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    SOD normal</td>
<td headers="stat_0" class="gt_row gt_center">566 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    SOD abnormal</td>
<td headers="stat_0" class="gt_row gt_center">0 (0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: POT &lt;= 2.9 or POT &gt;= 6.0 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    POT normal</td>
<td headers="stat_0" class="gt_row gt_center">563 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    POT abnormal</td>
<td headers="stat_0" class="gt_row gt_center">3 (0.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: CHL &lt;= 85 or CHL &gt;= 115 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    CHL normal</td>
<td headers="stat_0" class="gt_row gt_center">566 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    CHL abnormal</td>
<td headers="stat_0" class="gt_row gt_center">0 (0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: BIC &lt;= 10 or BIC &gt;= 40 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BIC normal</td>
<td headers="stat_0" class="gt_row gt_center">566 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BIC abnormal</td>
<td headers="stat_0" class="gt_row gt_center">0 (0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: GLU &lt;= 40 or GLU &gt;= 400 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    GLU normal</td>
<td headers="stat_0" class="gt_row gt_center">564 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    GLU abnormal</td>
<td headers="stat_0" class="gt_row gt_center">2 (0.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: O2 &lt;= 87 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    O2 normal</td>
<td headers="stat_0" class="gt_row gt_center">566 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    O2 abnormal</td>
<td headers="stat_0" class="gt_row gt_center">0 (0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: BUN/CRE &gt;= 18 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BUN/CRE normal</td>
<td headers="stat_0" class="gt_row gt_center">135 (24%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BUN/CRE abnormal</td>
<td headers="stat_0" class="gt_row gt_center">431 (76%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: Anion Gap &gt;= 16 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Anion Gap normal</td>
<td headers="stat_0" class="gt_row gt_center">459 (81%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Anion Gap abnormal</td>
<td headers="stat_0" class="gt_row gt_center">107 (19%)</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="2"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span> n (%)</td>
    </tr>
  </tfoot>
</table>
</div>
```

:::
:::


### POD1 labs

::: {.cell}
::: {.cell-output-display}

```{=html}
<div id="fhyqoaaxak" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#fhyqoaaxak table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#fhyqoaaxak thead, #fhyqoaaxak tbody, #fhyqoaaxak tfoot, #fhyqoaaxak tr, #fhyqoaaxak td, #fhyqoaaxak th {
  border-style: none;
}

#fhyqoaaxak p {
  margin: 0;
  padding: 0;
}

#fhyqoaaxak .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#fhyqoaaxak .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#fhyqoaaxak .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#fhyqoaaxak .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#fhyqoaaxak .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#fhyqoaaxak .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fhyqoaaxak .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#fhyqoaaxak .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#fhyqoaaxak .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#fhyqoaaxak .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#fhyqoaaxak .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#fhyqoaaxak .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#fhyqoaaxak .gt_spanner_row {
  border-bottom-style: hidden;
}

#fhyqoaaxak .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#fhyqoaaxak .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#fhyqoaaxak .gt_from_md > :first-child {
  margin-top: 0;
}

#fhyqoaaxak .gt_from_md > :last-child {
  margin-bottom: 0;
}

#fhyqoaaxak .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#fhyqoaaxak .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#fhyqoaaxak .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#fhyqoaaxak .gt_row_group_first td {
  border-top-width: 2px;
}

#fhyqoaaxak .gt_row_group_first th {
  border-top-width: 2px;
}

#fhyqoaaxak .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#fhyqoaaxak .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#fhyqoaaxak .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#fhyqoaaxak .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fhyqoaaxak .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#fhyqoaaxak .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#fhyqoaaxak .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#fhyqoaaxak .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#fhyqoaaxak .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fhyqoaaxak .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#fhyqoaaxak .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#fhyqoaaxak .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#fhyqoaaxak .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#fhyqoaaxak .gt_left {
  text-align: left;
}

#fhyqoaaxak .gt_center {
  text-align: center;
}

#fhyqoaaxak .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#fhyqoaaxak .gt_font_normal {
  font-weight: normal;
}

#fhyqoaaxak .gt_font_bold {
  font-weight: bold;
}

#fhyqoaaxak .gt_font_italic {
  font-style: italic;
}

#fhyqoaaxak .gt_super {
  font-size: 65%;
}

#fhyqoaaxak .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#fhyqoaaxak .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#fhyqoaaxak .gt_indent_1 {
  text-indent: 5px;
}

#fhyqoaaxak .gt_indent_2 {
  text-indent: 10px;
}

#fhyqoaaxak .gt_indent_3 {
  text-indent: 15px;
}

#fhyqoaaxak .gt_indent_4 {
  text-indent: 20px;
}

#fhyqoaaxak .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;Characteristic&lt;/strong&gt;"><strong>Characteristic</strong></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;N = 566&lt;/strong&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>N = 566</strong><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: WBC &lt;= 2 or WBC &gt;= 15 (POD1)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    WBC normal</td>
<td headers="stat_0" class="gt_row gt_center">521 (92%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    WBC abnormal</td>
<td headers="stat_0" class="gt_row gt_center">45 (8.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: HCT &lt;= 21 or HCT &gt;= 62 (POD1)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    HCT normal</td>
<td headers="stat_0" class="gt_row gt_center">562 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    HCT abnormal</td>
<td headers="stat_0" class="gt_row gt_center">4 (0.7%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: BUN &gt;= 50 (POD1)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BUN normal</td>
<td headers="stat_0" class="gt_row gt_center">562 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BUN abnormal</td>
<td headers="stat_0" class="gt_row gt_center">4 (0.7%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: CRE &gt;= 5 (POD1)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    CRE normal</td>
<td headers="stat_0" class="gt_row gt_center">566 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    CRE abnormal</td>
<td headers="stat_0" class="gt_row gt_center">0 (0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: SOD &lt;= 120 or SOD &gt;= 160 (POD1)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    SOD normal</td>
<td headers="stat_0" class="gt_row gt_center">566 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    SOD abnormal</td>
<td headers="stat_0" class="gt_row gt_center">0 (0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: POT &lt;= 2.9 or POT &gt;= 6.0 (POD1)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    POT normal</td>
<td headers="stat_0" class="gt_row gt_center">558 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    POT abnormal</td>
<td headers="stat_0" class="gt_row gt_center">8 (1.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: BIC &lt;= 10 or BIC &gt;= 40 (POD1)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BIC normal</td>
<td headers="stat_0" class="gt_row gt_center">566 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BIC abnormal</td>
<td headers="stat_0" class="gt_row gt_center">0 (0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: O2 &lt;= 87 (POD1)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    O2 normal</td>
<td headers="stat_0" class="gt_row gt_center">554 (98%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    O2 abnormal</td>
<td headers="stat_0" class="gt_row gt_center">12 (2.1%)</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="2"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span> n (%)</td>
    </tr>
  </tfoot>
</table>
</div>
```

:::
:::

### POD2 labs

::: {.cell}
::: {.cell-output-display}

```{=html}
<div id="jjuczihtuj" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#jjuczihtuj table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#jjuczihtuj thead, #jjuczihtuj tbody, #jjuczihtuj tfoot, #jjuczihtuj tr, #jjuczihtuj td, #jjuczihtuj th {
  border-style: none;
}

#jjuczihtuj p {
  margin: 0;
  padding: 0;
}

#jjuczihtuj .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#jjuczihtuj .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#jjuczihtuj .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#jjuczihtuj .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#jjuczihtuj .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#jjuczihtuj .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jjuczihtuj .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#jjuczihtuj .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#jjuczihtuj .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#jjuczihtuj .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#jjuczihtuj .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#jjuczihtuj .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#jjuczihtuj .gt_spanner_row {
  border-bottom-style: hidden;
}

#jjuczihtuj .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#jjuczihtuj .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#jjuczihtuj .gt_from_md > :first-child {
  margin-top: 0;
}

#jjuczihtuj .gt_from_md > :last-child {
  margin-bottom: 0;
}

#jjuczihtuj .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#jjuczihtuj .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#jjuczihtuj .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#jjuczihtuj .gt_row_group_first td {
  border-top-width: 2px;
}

#jjuczihtuj .gt_row_group_first th {
  border-top-width: 2px;
}

#jjuczihtuj .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jjuczihtuj .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#jjuczihtuj .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#jjuczihtuj .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jjuczihtuj .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jjuczihtuj .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#jjuczihtuj .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#jjuczihtuj .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#jjuczihtuj .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jjuczihtuj .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#jjuczihtuj .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#jjuczihtuj .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#jjuczihtuj .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#jjuczihtuj .gt_left {
  text-align: left;
}

#jjuczihtuj .gt_center {
  text-align: center;
}

#jjuczihtuj .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#jjuczihtuj .gt_font_normal {
  font-weight: normal;
}

#jjuczihtuj .gt_font_bold {
  font-weight: bold;
}

#jjuczihtuj .gt_font_italic {
  font-style: italic;
}

#jjuczihtuj .gt_super {
  font-size: 65%;
}

#jjuczihtuj .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#jjuczihtuj .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#jjuczihtuj .gt_indent_1 {
  text-indent: 5px;
}

#jjuczihtuj .gt_indent_2 {
  text-indent: 10px;
}

#jjuczihtuj .gt_indent_3 {
  text-indent: 15px;
}

#jjuczihtuj .gt_indent_4 {
  text-indent: 20px;
}

#jjuczihtuj .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;Characteristic&lt;/strong&gt;"><strong>Characteristic</strong></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;N = 566&lt;/strong&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>N = 566</strong><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: HCT &lt;= 21 or HCT &gt;= 62 (POD2)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    HCT normal</td>
<td headers="stat_0" class="gt_row gt_center">555 (98%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    HCT abnormal</td>
<td headers="stat_0" class="gt_row gt_center">11 (1.9%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: BUN &gt;= 50 (POD2)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BUN normal</td>
<td headers="stat_0" class="gt_row gt_center">553 (98%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BUN abnormal</td>
<td headers="stat_0" class="gt_row gt_center">13 (2.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: CRE &gt;= 5 (POD2)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    CRE normal</td>
<td headers="stat_0" class="gt_row gt_center">565 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    CRE abnormal</td>
<td headers="stat_0" class="gt_row gt_center">1 (0.2%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: SOD &lt;= 120 or SOD &gt;= 160 (POD2)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    SOD normal</td>
<td headers="stat_0" class="gt_row gt_center">564 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    SOD abnormal</td>
<td headers="stat_0" class="gt_row gt_center">2 (0.4%)</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="2"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span> n (%)</td>
    </tr>
  </tfoot>
</table>
</div>
```

:::
:::




::: {.cell}

:::

# Non-lab data

## Missingness

These were the variables that were dropped for having more than 50% missingness: none.

Imputation was done on the remaining lab values using predictive mean matching.






::: {.cell}

:::

# The variables

::: {.cell}

:::

There are 151 variables being considered for this analysis.

::: {.cell}
::: {.cell-output-display}

```{=html}
<div id="xntogdvwtt" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#xntogdvwtt table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#xntogdvwtt thead, #xntogdvwtt tbody, #xntogdvwtt tfoot, #xntogdvwtt tr, #xntogdvwtt td, #xntogdvwtt th {
  border-style: none;
}

#xntogdvwtt p {
  margin: 0;
  padding: 0;
}

#xntogdvwtt .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#xntogdvwtt .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#xntogdvwtt .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#xntogdvwtt .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#xntogdvwtt .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#xntogdvwtt .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xntogdvwtt .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#xntogdvwtt .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#xntogdvwtt .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#xntogdvwtt .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#xntogdvwtt .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#xntogdvwtt .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#xntogdvwtt .gt_spanner_row {
  border-bottom-style: hidden;
}

#xntogdvwtt .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#xntogdvwtt .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#xntogdvwtt .gt_from_md > :first-child {
  margin-top: 0;
}

#xntogdvwtt .gt_from_md > :last-child {
  margin-bottom: 0;
}

#xntogdvwtt .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#xntogdvwtt .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#xntogdvwtt .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#xntogdvwtt .gt_row_group_first td {
  border-top-width: 2px;
}

#xntogdvwtt .gt_row_group_first th {
  border-top-width: 2px;
}

#xntogdvwtt .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#xntogdvwtt .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#xntogdvwtt .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#xntogdvwtt .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xntogdvwtt .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#xntogdvwtt .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#xntogdvwtt .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#xntogdvwtt .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#xntogdvwtt .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xntogdvwtt .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#xntogdvwtt .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#xntogdvwtt .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#xntogdvwtt .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#xntogdvwtt .gt_left {
  text-align: left;
}

#xntogdvwtt .gt_center {
  text-align: center;
}

#xntogdvwtt .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#xntogdvwtt .gt_font_normal {
  font-weight: normal;
}

#xntogdvwtt .gt_font_bold {
  font-weight: bold;
}

#xntogdvwtt .gt_font_italic {
  font-style: italic;
}

#xntogdvwtt .gt_super {
  font-size: 65%;
}

#xntogdvwtt .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#xntogdvwtt .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#xntogdvwtt .gt_indent_1 {
  text-indent: 5px;
}

#xntogdvwtt .gt_indent_2 {
  text-indent: 10px;
}

#xntogdvwtt .gt_indent_3 {
  text-indent: 15px;
}

#xntogdvwtt .gt_indent_4 {
  text-indent: 20px;
}

#xntogdvwtt .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="variable">variable</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label">label</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="variable" class="gt_row gt_left">vdage</td>
<td headers="label" class="gt_row gt_left">Age at This Visit</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdfemale</td>
<td headers="label" class="gt_row gt_left">Female</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdnonwhite</td>
<td headers="label" class="gt_row gt_left">Nonwhite</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdeduc_r</td>
<td headers="label" class="gt_row gt_left">Respondent's Education, Years</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdlivesalone</td>
<td headers="label" class="gt_row gt_left">Lives alone</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdsmokingstatus</td>
<td headers="label" class="gt_row gt_left">Smoking status</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdalcohol</td>
<td headers="label" class="gt_row gt_left">Alcohol</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdmlta_metmins</td>
<td headers="label" class="gt_row gt_left">MLTA</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdgcp_rta</td>
<td headers="label" class="gt_row gt_left">Baseline GCP</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">wtar01</td>
<td headers="label" class="gt_row gt_left">WTAR</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdadlany</td>
<td headers="label" class="gt_row gt_left">ADL (any)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdiadlany</td>
<td headers="label" class="gt_row gt_left">IADL (any)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdiadlanyc</td>
<td headers="label" class="gt_row gt_left">IADL cognitive (any)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdgds15</td>
<td headers="label" class="gt_row gt_left">Geriatric Depression Scale Score  (/15 Points)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdsf12pcs</td>
<td headers="label" class="gt_row gt_left">SF12 physical composite T-score</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdsf12mcs</td>
<td headers="label" class="gt_row gt_left">SF12 mental composite T-score</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdsf12pf</td>
<td headers="label" class="gt_row gt_left">vdsf12pf</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdsf12rp</td>
<td headers="label" class="gt_row gt_left">vdsf12rp</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdsf12bp</td>
<td headers="label" class="gt_row gt_left">vdsf12bp</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdsf12gh</td>
<td headers="label" class="gt_row gt_left">vdsf12gh</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdsf12vt</td>
<td headers="label" class="gt_row gt_left">vdsf12vt</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdsf12sf</td>
<td headers="label" class="gt_row gt_left">vdsf12sf</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdsf12re</td>
<td headers="label" class="gt_row gt_left">vdsf12re</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdsf12mh</td>
<td headers="label" class="gt_row gt_left">vdsf12mh</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdhearingimp</td>
<td headers="label" class="gt_row gt_left">Hearing impairment</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vddrisk93_1</td>
<td headers="label" class="gt_row gt_left">vdrisk93_1</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdfriedfrail1</td>
<td headers="label" class="gt_row gt_left">Fraility - Weight Loss</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdfriedfrail2</td>
<td headers="label" class="gt_row gt_left">Fraility - 2</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdfriedfrail3</td>
<td headers="label" class="gt_row gt_left">Fraility - 3</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdfriedfrail4</td>
<td headers="label" class="gt_row gt_left">Fraility - Low Grip Strength</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdfriedfrail5</td>
<td headers="label" class="gt_row gt_left">Fraility - Low Timed Walk</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdsurg</td>
<td headers="label" class="gt_row gt_left">Surgery</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdcrp_preop</td>
<td headers="label" class="gt_row gt_left">CRP - preop</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdcrp_pod2</td>
<td headers="label" class="gt_row gt_left">CRP - POD2</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vd3ms</td>
<td headers="label" class="gt_row gt_left">3MS Score</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdbmi3</td>
<td headers="label" class="gt_row gt_left">BMI</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdesl</td>
<td headers="label" class="gt_row gt_left">English is second language</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">apoe4</td>
<td headers="label" class="gt_row gt_left">APOE 4</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdiqc_proxy</td>
<td headers="label" class="gt_row gt_left">IQCODE, Proxy Report</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdvascom</td>
<td headers="label" class="gt_row gt_left">Vascular Comorbidity</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">ins01</td>
<td headers="label" class="gt_row gt_left">No Insurance</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">ins02</td>
<td headers="label" class="gt_row gt_left">Has Medicare</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">ins03</td>
<td headers="label" class="gt_row gt_left">Has Private Insurance</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">ins04</td>
<td headers="label" class="gt_row gt_left">Has Medicaid</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">ins05</td>
<td headers="label" class="gt_row gt_left">Has Other Insurance</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">ci01</td>
<td headers="label" class="gt_row gt_left">Evidence of Cognitive Impairment</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">dep01</td>
<td headers="label" class="gt_row gt_left">Evidence of Depression</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.wbc.1.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: WBC &lt;= 2 or WBC &gt;= 15 (Pre-op)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.hct.1.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: HCT &lt;= 21 or HCT &gt;= 62 (Pre-op)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.bun.1.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: BUN &gt;= 50 (Pre-op)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.cre.1.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: CRE &gt;= 5 (Pre-op)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.sod.1.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: SOD &lt;= 120 or SOD &gt;= 160 (Pre-op)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.pot.1.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: POT &lt;= 2.9 or POT &gt;= 6.0 (Pre-op)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.chl.1.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: CHL &lt;= 85 or CHL &gt;= 115 (Pre-op)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.bic.1.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: BIC &lt;= 10 or BIC &gt;= 40 (Pre-op)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.glu.1.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: GLU &lt;= 40 or GLU &gt;= 400 (Pre-op)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.o2.1.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: O2 &lt;= 87 (Pre-op)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.bun.cre.1.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: BUN/CRE &gt;= 18 (Pre-op)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.anion.1.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: Anion Gap &gt;= 16 (Pre-op)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.wbc.2.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: WBC &lt;= 2 or WBC &gt;= 15 (POD1)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.hct.2.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: HCT &lt;= 21 or HCT &gt;= 62 (POD1)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.bun.2.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: BUN &gt;= 50 (POD1)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.cre.2.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: CRE &gt;= 5 (POD1)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.sod.2.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: SOD &lt;= 120 or SOD &gt;= 160 (POD1)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.pot.2.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: POT &lt;= 2.9 or POT &gt;= 6.0 (POD1)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.bic.2.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: BIC &lt;= 10 or BIC &gt;= 40 (POD1)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.o2.2.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: O2 &lt;= 87 (POD1)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.hct.3.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: HCT &lt;= 21 or HCT &gt;= 62 (POD2)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.bun.3.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: BUN &gt;= 50 (POD2)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.cre.3.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: CRE &gt;= 5 (POD2)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">lab.sod.3.abnormal</td>
<td headers="label" class="gt_row gt_left">Abnormal labs: SOD &lt;= 120 or SOD &gt;= 160 (POD2)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">comorbid.diab_mod</td>
<td headers="label" class="gt_row gt_left">Diabetes - mild to moderate</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">comorbid.tumor</td>
<td headers="label" class="gt_row gt_left">Tumor</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">comorbid.pvd</td>
<td headers="label" class="gt_row gt_left">Peripheral vascular disease</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">comorbid.mi</td>
<td headers="label" class="gt_row gt_left">Myocardial infarction</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">comorbid.ctd</td>
<td headers="label" class="gt_row gt_left">Connective tissue disease</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">comorbid.crd</td>
<td headers="label" class="gt_row gt_left">Chronic respiratory disease</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">comorbid.cs</td>
<td headers="label" class="gt_row gt_left">Carotid stenosis</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">comorbid.diab_sev</td>
<td headers="label" class="gt_row gt_left">Diabetes - severe with end organ damage</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">comorbid.chf</td>
<td headers="label" class="gt_row gt_left">Congestive heart failure</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">comorbid.stroke</td>
<td headers="label" class="gt_row gt_left">Stroke</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdcci3</td>
<td headers="label" class="gt_row gt_left">Charlson Comorbidity Index</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">op01_3</td>
<td headers="label" class="gt_row gt_left">ASA class</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdanesth_spi</td>
<td headers="label" class="gt_row gt_left">Anesthesia Type</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41101</td>
<td headers="label" class="gt_row gt_left">(op10) Estimated Blood Loss (EBL) (cc)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41301</td>
<td headers="label" class="gt_row gt_left">Anesthesia-general</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41302</td>
<td headers="label" class="gt_row gt_left">Anesthesia-spinal</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41303</td>
<td headers="label" class="gt_row gt_left">Anesthesia-regional</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41304</td>
<td headers="label" class="gt_row gt_left">Anesthesia-local</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41305</td>
<td headers="label" class="gt_row gt_left">Anesthesia time (ln(hours))</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41311</td>
<td headers="label" class="gt_row gt_left">Anesthesia propofol</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41312</td>
<td headers="label" class="gt_row gt_left">Anesthesia midazolam</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41313</td>
<td headers="label" class="gt_row gt_left">Anesthesia fentanyl</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41314</td>
<td headers="label" class="gt_row gt_left">Anesthesia remifentanil</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41315</td>
<td headers="label" class="gt_row gt_left">Anesthesia hydromorphone</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41316</td>
<td headers="label" class="gt_row gt_left">Anesthesia morphine</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41317</td>
<td headers="label" class="gt_row gt_left">Anesthesia nitrous</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41318</td>
<td headers="label" class="gt_row gt_left">Anesthesia desflurane</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41319</td>
<td headers="label" class="gt_row gt_left">Anesthesia succinycholine</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41320</td>
<td headers="label" class="gt_row gt_left">Anesthesia vecuronium</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41321</td>
<td headers="label" class="gt_row gt_left">Anesthesia bupivacaine</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41322</td>
<td headers="label" class="gt_row gt_left">Anesthesia cefazolin</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41323</td>
<td headers="label" class="gt_row gt_left">Anesthesia ephedrine</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41324</td>
<td headers="label" class="gt_row gt_left">Anesthesia glycopyrrolate</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41325</td>
<td headers="label" class="gt_row gt_left">Anesthesia lidocaine</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41326</td>
<td headers="label" class="gt_row gt_left">Anesthesia mepivacaine</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41327</td>
<td headers="label" class="gt_row gt_left">Anesthesia neostigmine</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41328</td>
<td headers="label" class="gt_row gt_left">Anesthesia ondansetron</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41329</td>
<td headers="label" class="gt_row gt_left">Anesthesia phenylephrine</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41330</td>
<td headers="label" class="gt_row gt_left">Anesthesia rocuronium</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41331</td>
<td headers="label" class="gt_row gt_left">Anesthesia vancomycin</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41501</td>
<td headers="label" class="gt_row gt_left">Presence of beta blocker in pre-hospital medication list</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41502</td>
<td headers="label" class="gt_row gt_left">Presence of NSAID in pre-hospital medication list</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41503</td>
<td headers="label" class="gt_row gt_left">Presence of statin in pre-hospital medication list</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41504</td>
<td headers="label" class="gt_row gt_left">Presence of benzodiazepine in pre-hospital medication list</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41505</td>
<td headers="label" class="gt_row gt_left">Presence of opioid in pre-hospital medication list</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41506</td>
<td headers="label" class="gt_row gt_left">total Anticholinergic Drug Scale (ADS) score</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41507</td>
<td headers="label" class="gt_row gt_left">number of medications contributing points to ADS score</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41508</td>
<td headers="label" class="gt_row gt_left">total number of pre-hospital medications in patient's record</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41509</td>
<td headers="label" class="gt_row gt_left">average ADS score per medication (computed as score/Med_num)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41510</td>
<td headers="label" class="gt_row gt_left">number of medications with ADS activity &gt;1</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41511</td>
<td headers="label" class="gt_row gt_left">ADS score if excluding medications scoring 1 on the ADS activity scale</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41512</td>
<td headers="label" class="gt_row gt_left">total Anticholinergic Cognitive Burden (ACB) scale score</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41513</td>
<td headers="label" class="gt_row gt_left">total number of medications contributing to ACB score</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41514</td>
<td headers="label" class="gt_row gt_left">average ADS score per medication (computed as ACB/Num_med)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41515</td>
<td headers="label" class="gt_row gt_left">number of medications with ACB activity &gt;1</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41516</td>
<td headers="label" class="gt_row gt_left">ADS score if excluding medications scoring 1 on the ACB scale</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41721</td>
<td headers="label" class="gt_row gt_left">antipsychotics use in days 1-7</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41722</td>
<td headers="label" class="gt_row gt_left">benzodiazepines use in days 1-7</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41723</td>
<td headers="label" class="gt_row gt_left">hydromorphone use in days 1-7</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41724</td>
<td headers="label" class="gt_row gt_left">morphine use in days 1-7</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41725</td>
<td headers="label" class="gt_row gt_left">oxycodone use in days 1-7</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41726</td>
<td headers="label" class="gt_row gt_left">tramadol use in days 1-7</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41727</td>
<td headers="label" class="gt_row gt_left">other opioid use in days 1-7</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp41901</td>
<td headers="label" class="gt_row gt_left">ASA Class &gt;=3 (vs &lt;=2)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp42101</td>
<td headers="label" class="gt_row gt_left">Surgery time (hours)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp42303</td>
<td headers="label" class="gt_row gt_left">Intraop complication - bradycardia requiring new permanent pacemaker</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp42304</td>
<td headers="label" class="gt_row gt_left">Intraop complication - uncontrolled bleeding</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp42305</td>
<td headers="label" class="gt_row gt_left">Intraop complication - prolonged severe hypotension</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp42309</td>
<td headers="label" class="gt_row gt_left">Intraop complication - other</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp42701</td>
<td headers="label" class="gt_row gt_left">Post-operative hypotension (SBP&lt;90 or DBP&lt;60)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp42702</td>
<td headers="label" class="gt_row gt_left">Post-operative hypertension (SBP&gt;140 or DBP&gt;90)</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp42901</td>
<td headers="label" class="gt_row gt_left">(ptvi01) Post op vital signs temperature (°F) - highest</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp42902</td>
<td headers="label" class="gt_row gt_left">(ptvi02) Post op vital signs temperature (°F) - lowest</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp42903</td>
<td headers="label" class="gt_row gt_left">(ptvi03) Post op vital signs pulse (per min) - highest</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp42904</td>
<td headers="label" class="gt_row gt_left">(ptvi04) Post op vital signs pulse (per min) - lowest</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp42905</td>
<td headers="label" class="gt_row gt_left">(ptvi09) Post op vital signs Respirations (per min) - highest</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp42906</td>
<td headers="label" class="gt_row gt_left">(ptvi10) Post op vital signs Respirations (per min) - lowest</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp43101</td>
<td headers="label" class="gt_row gt_left">Days from surgery to first ambulation</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp43301</td>
<td headers="label" class="gt_row gt_left">(icu01 recode) Was the patient ever in the ICU or CCU?</td></tr>
    <tr><td headers="variable" class="gt_row gt_left">vdp44701</td>
<td headers="label" class="gt_row gt_left">Adjudicated risk rating (maximum) from clinical neuroimaging</td></tr>
  </tbody>
  
  
</table>
</div>
```

:::
:::



# Variable reduction

This section details the variable reduction technique from Harrell's Regression Modeling Strategies that we used to reduce the number of variables used in the analysis.


The data was split into training (80%) and testing (20%) sets.

::: {.cell}

:::


::: {.cell}

:::

Of the 151 variables we start with, we dropped 54 of them for not having a lot of variability.

These are the variables that were dropped:
::: {.cell}
::: {.cell-output-display}

```{=html}
<div id="rseacnealp" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#rseacnealp table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#rseacnealp thead, #rseacnealp tbody, #rseacnealp tfoot, #rseacnealp tr, #rseacnealp td, #rseacnealp th {
  border-style: none;
}

#rseacnealp p {
  margin: 0;
  padding: 0;
}

#rseacnealp .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#rseacnealp .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#rseacnealp .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#rseacnealp .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#rseacnealp .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#rseacnealp .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rseacnealp .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#rseacnealp .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#rseacnealp .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#rseacnealp .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#rseacnealp .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#rseacnealp .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#rseacnealp .gt_spanner_row {
  border-bottom-style: hidden;
}

#rseacnealp .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#rseacnealp .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#rseacnealp .gt_from_md > :first-child {
  margin-top: 0;
}

#rseacnealp .gt_from_md > :last-child {
  margin-bottom: 0;
}

#rseacnealp .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#rseacnealp .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#rseacnealp .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#rseacnealp .gt_row_group_first td {
  border-top-width: 2px;
}

#rseacnealp .gt_row_group_first th {
  border-top-width: 2px;
}

#rseacnealp .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rseacnealp .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#rseacnealp .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#rseacnealp .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rseacnealp .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rseacnealp .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#rseacnealp .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#rseacnealp .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#rseacnealp .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rseacnealp .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#rseacnealp .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#rseacnealp .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#rseacnealp .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#rseacnealp .gt_left {
  text-align: left;
}

#rseacnealp .gt_center {
  text-align: center;
}

#rseacnealp .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#rseacnealp .gt_font_normal {
  font-weight: normal;
}

#rseacnealp .gt_font_bold {
  font-weight: bold;
}

#rseacnealp .gt_font_italic {
  font-style: italic;
}

#rseacnealp .gt_super {
  font-size: 65%;
}

#rseacnealp .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#rseacnealp .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#rseacnealp .gt_indent_1 {
  text-indent: 5px;
}

#rseacnealp .gt_indent_2 {
  text-indent: 10px;
}

#rseacnealp .gt_indent_3 {
  text-indent: 15px;
}

#rseacnealp .gt_indent_4 {
  text-indent: 20px;
}

#rseacnealp .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;Characteristic&lt;/strong&gt;"><strong>Characteristic</strong></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;N = 560&lt;/strong&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>N = 560</strong><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">IADL cognitive (any)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    No_impairment</td>
<td headers="stat_0" class="gt_row gt_center">533 (95%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Impairment</td>
<td headers="stat_0" class="gt_row gt_center">27 (4.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">vdrisk93_1</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    No_impairment</td>
<td headers="stat_0" class="gt_row gt_center">557 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Impairment</td>
<td headers="stat_0" class="gt_row gt_center">3 (0.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">No Insurance</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Insurance</td>
<td headers="stat_0" class="gt_row gt_center">560 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    No Insurance</td>
<td headers="stat_0" class="gt_row gt_center">0 (0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Has Medicaid</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    No Medicaid</td>
<td headers="stat_0" class="gt_row gt_center">552 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Medicaid</td>
<td headers="stat_0" class="gt_row gt_center">8 (1.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Evidence of Cognitive Impairment</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    No Cognitive Impairment</td>
<td headers="stat_0" class="gt_row gt_center">558 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Cognitive Impairment (Chart)</td>
<td headers="stat_0" class="gt_row gt_center">2 (0.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: WBC &lt;= 2 or WBC &gt;= 15 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    WBC normal</td>
<td headers="stat_0" class="gt_row gt_center">555 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    WBC abnormal</td>
<td headers="stat_0" class="gt_row gt_center">5 (0.9%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: HCT &lt;= 21 or HCT &gt;= 62 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    HCT normal</td>
<td headers="stat_0" class="gt_row gt_center">560 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    HCT abnormal</td>
<td headers="stat_0" class="gt_row gt_center">0 (0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: BUN &gt;= 50 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BUN normal</td>
<td headers="stat_0" class="gt_row gt_center">553 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BUN abnormal</td>
<td headers="stat_0" class="gt_row gt_center">7 (1.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: CRE &gt;= 5 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    CRE normal</td>
<td headers="stat_0" class="gt_row gt_center">560 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    CRE abnormal</td>
<td headers="stat_0" class="gt_row gt_center">0 (0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: SOD &lt;= 120 or SOD &gt;= 160 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    SOD normal</td>
<td headers="stat_0" class="gt_row gt_center">560 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    SOD abnormal</td>
<td headers="stat_0" class="gt_row gt_center">0 (0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: POT &lt;= 2.9 or POT &gt;= 6.0 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    POT normal</td>
<td headers="stat_0" class="gt_row gt_center">557 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    POT abnormal</td>
<td headers="stat_0" class="gt_row gt_center">3 (0.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: CHL &lt;= 85 or CHL &gt;= 115 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    CHL normal</td>
<td headers="stat_0" class="gt_row gt_center">560 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    CHL abnormal</td>
<td headers="stat_0" class="gt_row gt_center">0 (0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: BIC &lt;= 10 or BIC &gt;= 40 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BIC normal</td>
<td headers="stat_0" class="gt_row gt_center">560 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BIC abnormal</td>
<td headers="stat_0" class="gt_row gt_center">0 (0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: GLU &lt;= 40 or GLU &gt;= 400 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    GLU normal</td>
<td headers="stat_0" class="gt_row gt_center">558 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    GLU abnormal</td>
<td headers="stat_0" class="gt_row gt_center">2 (0.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: O2 &lt;= 87 (Pre-op)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    O2 normal</td>
<td headers="stat_0" class="gt_row gt_center">560 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    O2 abnormal</td>
<td headers="stat_0" class="gt_row gt_center">0 (0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: HCT &lt;= 21 or HCT &gt;= 62 (POD1)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    HCT normal</td>
<td headers="stat_0" class="gt_row gt_center">556 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    HCT abnormal</td>
<td headers="stat_0" class="gt_row gt_center">4 (0.7%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: BUN &gt;= 50 (POD1)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BUN normal</td>
<td headers="stat_0" class="gt_row gt_center">556 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BUN abnormal</td>
<td headers="stat_0" class="gt_row gt_center">4 (0.7%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: CRE &gt;= 5 (POD1)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    CRE normal</td>
<td headers="stat_0" class="gt_row gt_center">560 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    CRE abnormal</td>
<td headers="stat_0" class="gt_row gt_center">0 (0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: SOD &lt;= 120 or SOD &gt;= 160 (POD1)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    SOD normal</td>
<td headers="stat_0" class="gt_row gt_center">560 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    SOD abnormal</td>
<td headers="stat_0" class="gt_row gt_center">0 (0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: POT &lt;= 2.9 or POT &gt;= 6.0 (POD1)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    POT normal</td>
<td headers="stat_0" class="gt_row gt_center">552 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    POT abnormal</td>
<td headers="stat_0" class="gt_row gt_center">8 (1.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: BIC &lt;= 10 or BIC &gt;= 40 (POD1)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BIC normal</td>
<td headers="stat_0" class="gt_row gt_center">560 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BIC abnormal</td>
<td headers="stat_0" class="gt_row gt_center">0 (0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: O2 &lt;= 87 (POD1)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    O2 normal</td>
<td headers="stat_0" class="gt_row gt_center">548 (98%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    O2 abnormal</td>
<td headers="stat_0" class="gt_row gt_center">12 (2.1%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: HCT &lt;= 21 or HCT &gt;= 62 (POD2)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    HCT normal</td>
<td headers="stat_0" class="gt_row gt_center">549 (98%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    HCT abnormal</td>
<td headers="stat_0" class="gt_row gt_center">11 (2.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: BUN &gt;= 50 (POD2)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BUN normal</td>
<td headers="stat_0" class="gt_row gt_center">547 (98%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BUN abnormal</td>
<td headers="stat_0" class="gt_row gt_center">13 (2.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: CRE &gt;= 5 (POD2)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    CRE normal</td>
<td headers="stat_0" class="gt_row gt_center">559 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    CRE abnormal</td>
<td headers="stat_0" class="gt_row gt_center">1 (0.2%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Abnormal labs: SOD &lt;= 120 or SOD &gt;= 160 (POD2)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    SOD normal</td>
<td headers="stat_0" class="gt_row gt_center">558 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    SOD abnormal</td>
<td headers="stat_0" class="gt_row gt_center">2 (0.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Congestive heart failure</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    No CHF</td>
<td headers="stat_0" class="gt_row gt_center">540 (96%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Congestive heart failure</td>
<td headers="stat_0" class="gt_row gt_center">20 (3.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Stroke</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    No stroke</td>
<td headers="stat_0" class="gt_row gt_center">546 (98%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Stroke</td>
<td headers="stat_0" class="gt_row gt_center">14 (2.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia-local</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">543 (97%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">17 (3.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia propofol</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">535 (96%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">25 (4.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia midazolam</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">539 (96%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">21 (3.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia remifentanil</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">557 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">3 (0.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia hydromorphone</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">539 (96%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">21 (3.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia nitrous</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">558 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">2 (0.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia desflurane</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">553 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">7 (1.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia succinycholine</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">554 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">6 (1.1%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia vecuronium</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">556 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">4 (0.7%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia bupivacaine</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">545 (97%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">15 (2.7%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia cefazolin</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">542 (97%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">18 (3.2%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia ephedrine</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">541 (97%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">19 (3.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia glycopyrrolate</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">537 (96%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">23 (4.1%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia lidocaine</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">551 (98%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">9 (1.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia mepivacaine</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">559 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">1 (0.2%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia neostigmine</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">539 (96%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">21 (3.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia ondansetron</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">534 (95%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">26 (4.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia phenylephrine</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">536 (96%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">24 (4.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia rocuronium</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">545 (97%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">15 (2.7%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia vancomycin</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">555 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">5 (0.9%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">tramadol use in days 1-7</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">527 (94%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">33 (5.9%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Intraop complication - bradycardia requiring new permanent pacemaker</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">559 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">1 (0.2%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Intraop complication - uncontrolled bleeding</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">558 (100%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">2 (0.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Intraop complication - prolonged severe hypotension</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">555 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">5 (0.9%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Intraop complication - other</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">548 (98%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">12 (2.1%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Post-operative hypertension (SBP&gt;140 or DBP&gt;90)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">554 (99%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">6 (1.1%)</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="2"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span> n (%)</td>
    </tr>
  </tfoot>
</table>
</div>
```

:::
:::

::: {.cell}

:::

Of the 97 variables retained, 15 were dropped due to redundancy.

These are the variables that were dropped:

::: {.cell}
::: {.cell-output-display}

```{=html}
<div id="cqkbmoddhg" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#cqkbmoddhg table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#cqkbmoddhg thead, #cqkbmoddhg tbody, #cqkbmoddhg tfoot, #cqkbmoddhg tr, #cqkbmoddhg td, #cqkbmoddhg th {
  border-style: none;
}

#cqkbmoddhg p {
  margin: 0;
  padding: 0;
}

#cqkbmoddhg .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#cqkbmoddhg .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#cqkbmoddhg .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#cqkbmoddhg .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#cqkbmoddhg .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#cqkbmoddhg .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cqkbmoddhg .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#cqkbmoddhg .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#cqkbmoddhg .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#cqkbmoddhg .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#cqkbmoddhg .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#cqkbmoddhg .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#cqkbmoddhg .gt_spanner_row {
  border-bottom-style: hidden;
}

#cqkbmoddhg .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#cqkbmoddhg .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#cqkbmoddhg .gt_from_md > :first-child {
  margin-top: 0;
}

#cqkbmoddhg .gt_from_md > :last-child {
  margin-bottom: 0;
}

#cqkbmoddhg .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#cqkbmoddhg .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#cqkbmoddhg .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#cqkbmoddhg .gt_row_group_first td {
  border-top-width: 2px;
}

#cqkbmoddhg .gt_row_group_first th {
  border-top-width: 2px;
}

#cqkbmoddhg .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cqkbmoddhg .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#cqkbmoddhg .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#cqkbmoddhg .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cqkbmoddhg .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cqkbmoddhg .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#cqkbmoddhg .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#cqkbmoddhg .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#cqkbmoddhg .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cqkbmoddhg .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#cqkbmoddhg .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#cqkbmoddhg .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#cqkbmoddhg .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#cqkbmoddhg .gt_left {
  text-align: left;
}

#cqkbmoddhg .gt_center {
  text-align: center;
}

#cqkbmoddhg .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#cqkbmoddhg .gt_font_normal {
  font-weight: normal;
}

#cqkbmoddhg .gt_font_bold {
  font-weight: bold;
}

#cqkbmoddhg .gt_font_italic {
  font-style: italic;
}

#cqkbmoddhg .gt_super {
  font-size: 65%;
}

#cqkbmoddhg .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#cqkbmoddhg .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#cqkbmoddhg .gt_indent_1 {
  text-indent: 5px;
}

#cqkbmoddhg .gt_indent_2 {
  text-indent: 10px;
}

#cqkbmoddhg .gt_indent_3 {
  text-indent: 15px;
}

#cqkbmoddhg .gt_indent_4 {
  text-indent: 20px;
}

#cqkbmoddhg .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;Characteristic&lt;/strong&gt;"><strong>Characteristic</strong></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;N = 560&lt;/strong&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>N = 560</strong><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">SF12 physical composite T-score</td>
<td headers="stat_0" class="gt_row gt_center">36 (28, 44)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">SF12 mental composite T-score</td>
<td headers="stat_0" class="gt_row gt_center">51 (45, 56)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Fraility - 2</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">441 (79%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">119 (21%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Charlson Comorbidity Index</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    cci_0</td>
<td headers="stat_0" class="gt_row gt_center">257 (46%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    cci_1</td>
<td headers="stat_0" class="gt_row gt_center">139 (25%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    cci_2_7</td>
<td headers="stat_0" class="gt_row gt_center">164 (29%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia Type</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    General Anesthesia only</td>
<td headers="stat_0" class="gt_row gt_center">479 (86%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Any Spinal Anesthesia</td>
<td headers="stat_0" class="gt_row gt_center">81 (14%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Anesthesia-general</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">80 (14%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">480 (86%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">total Anticholinergic Drug Scale (ADS) score</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">167 (30%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">165 (29%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_0" class="gt_row gt_center">107 (19%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_0" class="gt_row gt_center">55 (9.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4</td>
<td headers="stat_0" class="gt_row gt_center">41 (7.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    5</td>
<td headers="stat_0" class="gt_row gt_center">13 (2.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    6</td>
<td headers="stat_0" class="gt_row gt_center">5 (0.9%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    7</td>
<td headers="stat_0" class="gt_row gt_center">2 (0.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    8</td>
<td headers="stat_0" class="gt_row gt_center">5 (0.9%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">average ADS score per medication (computed as score/Med_num)</td>
<td headers="stat_0" class="gt_row gt_center">0.17 (0.00, 0.29)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">number of medications with ADS activity &gt;1</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">467 (83%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">82 (15%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_0" class="gt_row gt_center">11 (2.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">total Anticholinergic Cognitive Burden (ACB) scale score</td>
<td headers="stat_0" class="gt_row gt_center">1.00 (0.00, 2.00)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">total number of medications contributing to ACB score</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">145 (26%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">203 (36%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_0" class="gt_row gt_center">123 (22%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_0" class="gt_row gt_center">57 (10%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4</td>
<td headers="stat_0" class="gt_row gt_center">23 (4.1%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    5</td>
<td headers="stat_0" class="gt_row gt_center">7 (1.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    6</td>
<td headers="stat_0" class="gt_row gt_center">2 (0.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">number of medications with ACB activity &gt;1</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">479 (86%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">68 (12%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_0" class="gt_row gt_center">12 (2.1%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_0" class="gt_row gt_center">1 (0.2%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">ADS score if excluding medications scoring 1 on the ACB scale</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">479 (86%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_0" class="gt_row gt_center">12 (2.1%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_0" class="gt_row gt_center">56 (10%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    5</td>
<td headers="stat_0" class="gt_row gt_center">5 (0.9%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    6</td>
<td headers="stat_0" class="gt_row gt_center">7 (1.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    9</td>
<td headers="stat_0" class="gt_row gt_center">1 (0.2%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">ASA Class &gt;=3 (vs &lt;=2)</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">207 (37%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">353 (63%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Surgery time (hours)</td>
<td headers="stat_0" class="gt_row gt_center">2.05 (1.65, 2.90)</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="2"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span> Median (IQR); n (%)</td>
    </tr>
  </tfoot>
</table>
</div>
```

:::
:::

There are 83 variables retained after the redundancy analysis.





<!-- {{< include _065-specify_models.qmd >}} -->

<!-- {{< include _070-fit_models.qmd >}} -->



