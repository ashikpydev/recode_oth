# recode_oth

**Author:** Ashikur Rahman  
**GitHub:** [ashikpydev](https://github.com/ashikpydev)  
**Last Updated:** 2025-09-01  

---

## Overview

`recode_oth` is a Stata package designed to clean survey data by merging open-ended "_oth" responses into a main categorical variable. It:

- Adds new codes for frequently mentioned responses (≥10% of total "_oth" responses).  
- Merges responses that already exist in the main variable’s value labels.  
- Preserves remaining "_oth" responses for further review.  

This is particularly useful for surveys with “Other (specify)” questions, allowing seamless integration of new or existing responses into the main dataset.

---

## Features

- Automatic creation of value labels if missing.  
- Frequency threshold for adding new codes.  
- Informative output with merged and new codes.  
- Compatible with previous packages like `recode_nrep` and `recode_rep`.

---

## Installation

net install recode_oth, from("https://raw.githubusercontent.com/ashikpydev/recode_oth/main/") replace

help recode_oth

## Example:

. recode_oth s3_1 s3_1_oth

* Example output:
* ✅ New code added: Fishing = 100 (34.9% of _oth)
* 🔄 Merged existing code: Unemployed -> 1
* Summary of changes
# recode_oth
