* ================================
* Project : Learning Data Management Using Stata (Michael N. Mitchell)
* Chapter 2 : Reading and Importing data files
* File : Chapter_2_Reading-and-Importing-data-files.do
* Author : Xiaoshu Wang
* Date : 2026-01-20
* ================================

clear all

set more off

* 2.1 Introduction

cd "D:/StataProjects/Data Management Using Stata"   // the forward slash (/) is preferable to the backslash (\) in specifying file paths in Stata

* 2.2 Reading Stata datasets

use "raw-data\dmus1\dentists.dta",clear    // this dataset contains information from a survey of five dientists

list      // list all observations and variables in the dataset

use https://www.stata-press.com/data/dmus2/dentists.dta, clear   // read Stata datasets stored on the remote web servers

use name years using "raw-data\dmus1\dentists.dta",clear   // Load subset of Stata-format dataset

list

use if (years >= 10) using "raw-data\dmus1\dentists.dta", clear   // a subset--those dentists who have worked at least 10 years

use "raw-data\dmus1\dentists.dta" if (years >= 10), clear     // same as above

use name years if (years >= 10) using "raw-data\dmus1\dentists.dta",clear   // read just the variables name and years for those dentists who have worked at least 10 years

sysuse dir    // List example Stata datasets installed with Stata

sysuse auto.dta, clear   // Load example Stata dataset auto.dta

help dta contents   // Example datasets installed with Stata +  Stata 17 manual datasets require web access

webuse fullauto.dta, clear   

use https://www.stata-press.com/data/r17/fullauto.dta, clear   // equivalent to above command

* 2.3 Importing Excel spreadsheets

import excel "raw-data\dmus2\dentists.xls",firstrow clear   // import Excel spreadsheet dentists.xls, the first row contains variable names

list

import excel "raw-data\dmus2\dentists2.xls",firstrow clear   // dentists2.xls has multiple sheets, by default Stata imports the first sheet

list    // 2 vars, 4 obs

import excel "raw-data\dmus2\dentists2.xls",sheet("dentists") firstrow clear   // import data from the sheet named "dentists"

list   // 4 vars, 5 obs

import excel "raw-data\dmus2\dentists3.xls",firstrow clear   // this file has stray information stored along with the data

list   // 5 vars, 6 obs

import excel "raw-data\dmus2\dentists3.xls",cellrange(A1:D6) firstrow clear   // focus only on the data within A1:D6

list   // 4 vars, 5 obs

* 2.4 Importing SAS files

** 2.4.1 Importing SAS .sasbdta files

import sas "raw-data\dmus2\dentists.sas7bdat",clear

list   // 4 vars, 5 obs, no labels

import sas "raw-data\dmus2\dentlab.sas7bdat",bcat("raw-data\dmus2\formats.sas7bcat") clear    //import both the data and the formats at once

list   // to see the data were imported successfully

label list   // to see the value labels imported from the SAS formats file

label values fulltime FTLAB    // associate each variable with the correct value label

label values recom RECLAB     // same for recom

describe   // to confirm that the label values commands were successful

list   // fulltime and recom are displayed with their labeled values

** 2.4.2 Importing SAS XPORT Version 5 files

import sasxport5 "raw-data\dmus2\dentists.xpt",clear    // data only, no SAS formats → no value labels

list

import sasxport5 "raw-data\dmus2\dentlab.xpt",clear    // data + SAS format references → value labels imported

list

describe fulltime recom   // to see that the variables have format references

** 2.4.3 Importing SAS XPORT Version 8 files

import sasxport8 "raw-data\dmus2\dentists.v8xpt",clear

list 

* 2.5 Importing SPSS files

import spss "raw-data\dmus2\dentlab.sav",clear

list

import spss "raw-data\dmus2\dentlab.zsav",zsav clear     // in fact, there is no dentlab.zsav file in dmus2 folder, this is just for demonstration purpose

describe

label list

list, nolabel   // we can see the unlabeled values of fulltime and recom

import spss name years using "raw-data\dmus2\dentlab.sav",clear    // import the variables name and years only

list

import spss if (years >= 10) using "raw-data\dmus2\dentlab.sav",clear   // import observations where years >=10 only

list

import spss name years if (years >= 10) using "raw-data\dmus2\dentlab.sav",clear   //  import just the variables name and ears for those dentists who have worked at least 10 years
list

* 2.6 Importing dBase files

import dbase "raw-data\dmus2\dentlab.dbf",clear

list

import dbase "raw-data\dmus2\dentlab.dbf",clear caes(lower)   // convert variable names to lowercase

list

* 2.7 Importing raw data files

type "raw-data\dmus2\dentists1.txt"    // show a comma-separated raw data file dentists1.txt

type "raw-data\dmus2\dentists2.txt"   // show a tab-separated raw data file dentists2.txt

type "raw-data\dmus2\dentists5.txt"   // show a space-separated raw data file dentists5.txt 

type "raw-data\dmus2\dentists7.txt"   // show a fixed-format raw data file dentists7.txt

** 2.7.1 Importing comma-separated and tab-separated files

type "raw-data\dmus2\dentists1.txt"

import delimited "raw-data\dmus2\dentists1.txt",delimiters(",") clear     //encoding automatically selected: ISO-8859-1

list

import delimited "raw-data\dmus2\dentists1.txt",delimiters(comma) clear   // equivalent to above command

list

import delimited "raw-data\dmus2\dentists1.txt",delimiters(",") encoding(utf-8) clear   // you'd better specify the encoding as utf-8 especially when working with non-English characters

list

type "raw-data\dmus2\dentists2.txt"

import delimited "raw-data\dmus2\dentists2.txt",delimiters("\t") clear   // \t represents a tab character and encoding automatically selected: ISO-8859-1

list

import delimited "raw-data\dmus2\dentists2.txt",delimiters(tab) clear    // equivalent to above command

list

import delimited "raw-data\dmus2\dentists2.txt",delimiters("\t") encoding(utf-8) clear   // specify the encoding as utf-8

list

type "raw-data\dmus2\dentists3.txt"     // a comma-separated file with no variable names

import delimited "raw-data\dmus2\dentists3.txt",delimiters(",") encoding(utf-8) clear      // by default, Stata names the variables v1, v2, v3, and v4

list

import delimited name years fulltime recom using "raw-data\dmus2\dentists3.txt",delimiters(",") encoding(utf-8) clear    // rename the variables during import

list

type "raw-data\dmus2\dentists4.txt"   // a colon-separated file with no variable names

import delimited name years fulltime recom using "raw-data\dmus2\dentists4.txt",delimiters(":") encoding(utf-8) clear

list

import delimited name years fulltime recom using "raw-data\dmus2\dentists4.txt",delimiters(colon) encoding(utf-8) clear   // error: colon is not a valid delimiter shortcut, use ":" instead

/* 
   Only the following delimiter shortcuts are valid in import delimited:
   comma (,), tab (\t), space ( ), semicolon (;), and pipe (|).
   All other delimiters must be specified as quoted characters.
*/

** 2.7.2 Importing space-separated files

type "raw-data\dmus2\dentists5.txt"   

infile str17 name double years int(fulltime recom) using "raw-data\dmus2\dentists5.txt", clear   // use infile command to read this file specifying variable names and types

list

import delimited "raw-data\dmus2\dentists6.txt", delimiters(" ") encoding(utf-8) varnames(1) clear     // The infile command does not read files with variable names in the first row， but import delimited command can

list

infile a _skip(22) x _skip(2) using "raw-data\dmus2\abc.txt", clear   // example of using _skip() to skip unwanted columns

list

infile a _skip(22) x _skip(2) using "raw-data\dmus2\abc.txt" if (a <= 5), clear   // read only observations where a <= 5

list

type "raw-data\dmus2\cardio1.txt"    // a raw data file where we have an identification variable, a person's gender and age, five measures of blood pressure, and five measures of pulse

infile id age bp1 bp2 bp3 bp4 bp5 pu1 pu2 pu3 pu4 pu5 using "raw-data\dmus2\cardio1.txt", clear    // read all variables one by one

list

infile id age bp1-bp5 pu1-pu5 using "raw-data\dmus2\cardio1.txt", clear     // use a shortcut to read the five consecutive blood pressure and five consecutive pulse variables

list

** 2.7.3 Importing fixed-column files

type "raw-data\dmus2\dentists7.txt"   

infix str17 name 1-17 years 18-22 fulltime 23 recom 24 using"raw-data\dmus2\dentists7.txt", clear    // sepcify variable names and their column positions

list

infix str17 name 1-17 fulltime 23 using"raw-data\dmus2\dentists7.txt", clear   // read just the variables name and fulltime

list

infix years 18-22 fulltime 23 using"raw-data\dmus2\dentists7.txt" in 1/3 , clear    // read just the first three observations

list

infix years 18-22 fulltime 23 using"raw-data\dmus2\dentists7.txt" if (fulltime == 1), clear     // read only those dentists who aworked full time

list

type "raw-data\dmus2\dentists1.dct"    // an infix dictionary file

infix using "raw-data\dmus2\dentists1.dct", using("raw-data\dmus2\dentists7.txt") clear    // use the infix dictionary file to read the fixed-format raw data file

list

type "raw-data\dmus2\dentists2.dct"    // indicate the name of the raw data file within the infix dictionary file

infix using "raw-data\dmus2\dentists2.dct",clear    // error: the raw data file is not found because it is not in the working directory

infix using "raw-data\dmus2\dentists2.dct", using("raw-data\dmus2\dentists7.txt") clear    // now the command works

list

cd "D:/StataProjects/Data Management Using Stata/raw-data/dmus2"   // or you can change the working directory to where the raw data file is located

infix using "dentists2.dct",clear    // now the command works

list

type "dentists3.dct"   // an infile dictionary file

infile using "dentists3.dct",clear  

list

cd "D:\StataProjects\Data Management Using Stata\"

infile using "raw-data\dmus2\dentists3.dct", using("raw-data\dmus2\dentists7.txt") clear    // same as above and the The using("raw-data\dmus2\dentists7.txt") option in the infile command takes precedence over the using statement in the dictionary.

** 2.7.4 Importing fixed-column files with multiple lines of raw data per observation

type "raw-data\dmus2\dentists8.txt"     // This file contains 5 dentists with 2 lines of data per dentist for a total of 10 lines of data

type "raw-data\dmus2\dentists4.dct"     // an infix dictionary file

infix using "raw-data\dmus2\dentists4.dct", using("raw-data\dmus2\dentists8.txt") clear

list

type "raw-data\dmus2\dentists5.dct"    // an infile dictionary file

infile using "raw-data\dmus2\dentists5.dct", using("raw-data\dmus2\dentists8.txt") clear

list

* 2.8 Common errors when readind and importing files

// The “no; dataset in memory has changed since last saved” error message

// The “you must start with an empty dataset” error message

* 2.9 Entering data directly into the Stata Data Editor

use "studentsurvey.dta",clear

list,sep(0)

describe