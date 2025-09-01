*------------------------------------------------------------
* recode_oth — Merge "_oth" open-ended responses into main variable
* Author: Ashikur Rahman
* Last updated: 2025-09-01
*------------------------------------------------------------

TITLE
    recode_oth — Merge "_oth" responses into main variable with threshold

SYNOPSIS
    recode_oth mainvar othvar

DESCRIPTION
    `recode_oth` merges open-ended "_oth" responses back into the main variable.
    Only responses that meet a frequency threshold (≥10% of total _oth responses)
    are assigned new codes. Responses matching existing value labels are merged
    automatically. Remaining responses below the threshold are preserved in the
    `_oth` variable for review.

    This is useful when cleaning survey data where "Other (specify)" text entries
    need to be incorporated into categorical variables.

REMARKS
    * If `mainvar` has no value label, one will be created automatically.
    * Existing value labels are respected; no duplicates are created.
    * Frequencies below the threshold remain in the `_oth` variable.

EXAMPLES
    * Basic usage
        . recode_oth s3_1 s3_1_oth

    * After running, new codes are added automatically if threshold is met
      and existing codes are merged with informative output.

SEE ALSO
    recode_nrep, recode_rep

AUTHOR
    Ashiqur Rahman Rony
    Email: ashiqurrahman.stat@gmail.com
    GitHub: https://github.com/ashikpydev
