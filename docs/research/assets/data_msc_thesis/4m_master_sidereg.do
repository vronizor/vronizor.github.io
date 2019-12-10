// Colombian Coops
// 24/04/18
// Side-regressions, conflict affecting cooperatives

clear all
set more off

cd "/Users/vinceth/MEGAsync/UB ECONOMICS/Year2_17-18/_Thesis/Data/_Master"

use master_panel


//// Coops = Violence, fe ––> 13 yrs, full municip

xtreg coopr_tot viol_my, fe

/*
------------------------------------------------------
   coopr_tot |      Coef.   Std. Err.      t    P>|t| 
-------------+----------------------------------------
     viol_my |   .0020661    .000588     3.51   0.000
*/
* –––> more conflict, more coops :: weird

//// Violence = Coops , f

xtreg viol_my coopr_tot, fe

/*
------------------------------------------------------
     viol_my |      Coef.   Std. Err.      t    P>|t| 
-------------+----------------------------------------
   coopr_tot |   .4442691   .1264301     3.51   0.000 
*/
* –––> more coops, more violence
