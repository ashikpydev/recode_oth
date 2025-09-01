*! Author: Ashiqur Rahman Rony
*! Email: ashiqurrahman.stat@gmail.com
*! Organization: Development Research Initiative (dRi)


capture program drop recode_oth
program define recode_oth
    version 17.0
    syntax varlist(min=2 max=2)

    local mainvar `1'
    local othvar  `2'

    *-----------------------------
    * Step 0: Ensure value label exists
    local valuelabel : value label `mainvar'
    if "`valuelabel'" == "" {
        label define `mainvar'_lbl
        label values `mainvar' `mainvar'_lbl
        local valuelabel `mainvar'_lbl
    }

    *-----------------------------
    * Step 1: Count total _oth observations
    quietly count if `othvar' != ""
    local total_oth = r(N)

    *-----------------------------
    * Step 2: Loop through unique _oth responses
    levelsof `othvar', local(othlevels)
    local nnew = 0
    local nmerge = 0
    quietly summarize `mainvar', meanonly
    local maxcode = r(max)

    di as text "-----------------------------------------"
    di as text "Cleaning `mainvar` using `_oth` responses..."
    di as text "-----------------------------------------"

    foreach txt of local othlevels {
        local txtclean = strtrim("`txt'")
        if "`txtclean'" != "" {
            * Check if text already exists in value labels
            local existing_code = .
            foreach i of numlist 1/`maxcode' {
                local lab : label `valuelabel' `i'
                if "`lab'" == "`txtclean'" local existing_code = `i'
            }

            if missing(`existing_code') {
                * Frequency of this _oth response
                quietly count if `othvar' == "`txtclean'"
                local freq = r(N)
                local pct = 100*`freq'/`total_oth'

                if `pct' >= 10 {
                    * New code, meets threshold
                    local maxcode = `maxcode' + 1
                    label define `valuelabel' `maxcode' "`txtclean'", add
                    replace `mainvar' = `maxcode' if `othvar' == "`txtclean'"
                    local nnew = `nnew' + 1
                    replace `othvar' = "" if `othvar' == "`txtclean'"
                    di as result "✅ New code added: `txtclean' = `maxcode' (`=string(`pct', "%4.1f")'% of _oth)"
                }
                * else leave _oth value for review
            }
            else {
                * Existing code — always merge
                replace `mainvar' = `existing_code' if `othvar' == "`txtclean'"
                local nmerge = `nmerge' + 1
                replace `othvar' = "" if `othvar' == "`txtclean'"
                di as result "🔄 Merged existing code: `txtclean' -> `existing_code'"
            }
        }
    }

    label values `mainvar' `valuelabel'

    di as text "-----------------------------------------"
    di as text "Summary:"
    di as result "New codes merged: `nnew'"
    di as result "Existing codes merged: `nmerge'"
    di as text "Remaining `_oth` responses below threshold are preserved for review."
    di as text "Cleaning of `mainvar` complete."
    di as txt "        Created by: Ashiqur Rahman Rony | ashiqurrahman.stat@gmail.com"
    di as text "-----------------------------------------"
end