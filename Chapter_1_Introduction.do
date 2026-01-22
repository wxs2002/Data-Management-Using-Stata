* ================================
* Project : Learning Data Management Using Stata (Michael N. Mitchell)
* Chapter : 1 Introduction
* File : Chapter_1_Introduction.do
* Author : Xiaoshu Wang
* Date : 2026-01-19
* ================================

clear all

set more off

* 1.1 Using this book

cd "D:\StataProjects\Data Management Using Stata"   // set working directory on your own computer

net from https://www.stata-press.com/data/dmus2    // specify the remote source directory for net commands

cd "D:\StataProjects\Data Management Using Stata\raw-data\dmus1"

net get dmus1         // download raw data dmus1

cd "D:\StataProjects\Data Management Using Stata\raw-data\dmus2"

net get dmus2         // download raw data dmus2

net install dmus1     // download any commands used in this book

use "raw-data\dmus1\wws.dta",clear   // working women's survey data

* 1.2 Overview of this book

* 1.3 Listing observations in this book
 
 list idcode age hours wage in 1/5    // list a subset of observations use the in specification

 list idcode married marriedyrs nevermarried in 1/5    // output will abbreviate variable names since they are too long

 list idcode married marriedyrs nevermarried in 1/5,abb(20)   // abb(20) = abbreviate(20) indicates the minimum number of characters

 list idcode ccity hours uniondues married marriedyrs nevermarried in 1/3,abb(20)   // listing is so long that it will wrap on the page

 list idcode ccity hours uniondues married marriedyrs nevermarried in 1/3,abb(20) noobs   // noobs = no observations number,suppress the display of observation numbers

use "raw-data\dmus1\tv1.dta",clear   // 10 observations about the TV-watching habits of four children

list   // see the entire dataset

list,sep(0)   // sep(0) = separator(0) omits the display of these separator

list,sep(1)   // a separator line is displayed after each observation

list,sepby(kidid)  // sepby(kidid) = separator by (kidid) requests a separator be included between each level of kidid

help internet   // find out some resources on internet,like Facebook,Twitter,Youtube Channel etc.

* 1.4 More online resources

help videos   // access Stata tutorial videos recorded by StataCorp