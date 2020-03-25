# Test Project
## Introduction

This document describes a small test project designed to illustrate
your proficiency with technologies currently in use at Springbig. It
must be implemented using Ruby on Rails and either MySql or
Postgres. Some JavaScript is allowed, as are appropriate gems.

## Assignment
 - Develop the test project in accordance with the specifications provided
   below.
 - Make sure to provide appropriate automated tests with good coverage.
 - Host the project on Heroku or equivalent.
 - Push all of the source code to Github or Bitbucket and share with
   Springbig.
 - Successfully demonstrate all project functions to Springbig.
 - Walk through the code with Springbig, explaining it and answering
   questions about it.
 - Extra credit: Demonstrate any additional functionality that you may have
   added.

## Specifications

- The test project consists of two web pages (Input and Output) and
  asynchronous back-end processing.
  - **Input web page**
    - The Input page serves to upload a CSV file from the local file system.
    - The Input page contains three elements:
      - Input field that allows an “identifier” to be entered. The
        identifier is an arbitrary alphanumeric string of length > 1 that is
        entered by the user (e.g. “Input1234”).
      - “Browse” button that provides access to the local file system in
        order to select the input to be uploaded.
      - “Submit” button that initiates the upload of the selected file.
    - The “Submit” button initiates error checking that verifies the format
      and presence of the Identifier and asks the user for correction, if
      needed.
    - After this validation succeeds, the CSV file is uploaded for
      processing by the asynchronous back-end task with no further
      validation at submit time.
  - **Asynchronous Back-end Process**
	- The back-end process processes CSV files uploaded to the system,
	  subject to the input file format rules.
	- Once basic validations are completed, the process stores each
	  correctly formatted record in the database.
	- Any record that does not conform to the format rules is not processed
	  and the respective error is recorded for later display.

  - **Output Web Page**
	- The output web page reads the database and displays processed data as
	  follows.
	- For each of the Identifiers entered by the user, it lists with
	  appropriate labels:
	  - Identifier value (e.g. “Input1234”).
	  - Each correctly processed data row in the format: row number of the
		original CSV file (0-origin based), phone number as (999) 999-9999,
		email address, first name, last name.
	  - After listing the correctly processed rows, all errors are listed in
		the format: row number, as above, followed by a detailed, human
		readable error such as “Invalid phone number”, etc. Part of this
		exercise is for the developer to produce similar descriptions for
		all possible errors, as per the provided format.

## Other Notes
 - The operation of the system is asynchronous, allowing multiple users to
   simultaneously upload their respective input files via the Input page or
   display the database contents via the Output page.
 - It is possible to upload the same CSV file multiple times without
   duplicating any data or recorded errors. If corrections were made to the
   input file format after the initial upload, the expectation is that
   corrected records will be appropriately written to the database and each
   corrected record will result in at least one less error message.
 - If the input file contains no errors or if all errors were corrected and
   the final correct version uploaded, the Output page should list all the
   records in the input file and no error records.

## Input File Format and Rules
 - The input CSV file contains 4 columns.
 - The first row of the CSV file contains headers (“first”, “last”, “phone”
   and “email”) which may be in any order.
 - The remaining data rows, arbitrary in number but > 0, contain respective
   data elements in the order specified in the header row.
 - Phone numbers may contain characters 0-9,-,.(,). Punctuation need not
   adhere to a particular format or match, e.g. “123.456-8888” and
   “87644.45523” are both legal.
 - Phone numbers must contain exactly 10 digits. Assuming 0-origin
   indexing, positions 0 and 3 may not contain characters ‘0’ or ‘1’.
 - Email addresses must be standard and valid.
 - First and Last Names must be alpha only and at least 2 characters long
 - Neither first name or last name are required, however, the last name
   cannot be specified if first name is not present.


_Last Update: Jan 30, 2019_
