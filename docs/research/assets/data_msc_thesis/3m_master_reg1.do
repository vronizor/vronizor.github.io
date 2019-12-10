// Colombian Coops
// 24/04/18
// Regressions 1, same period

clear all
set more off


cd "/Users/vinceth/MEGAsync/UB ECONOMICS/Year2_17-18/_Thesis/Data/_Master"

use master_panel

log using reg1, replace

// Displ = Coops_all

xtreg displr_tot coopr_tot
xtreg displr_tot coopr_empl
xtreg displr_tot coopr_asso


// Displ = Coops_all, fe

xtreg displr_tot coopr_tot, fe
xtreg displr_tot coopr_empl, fe
xtreg displr_tot coopr_asso, fe


// Displ = Coops_all + Violence, fe

xtreg displr_tot coopr_tot viol_my, fe
xtreg displr_tot coopr_empl viol_my, fe
xtreg displr_tot coopr_asso viol_my, fe

// Displ = Coops_all*Violence , fe

xtreg displr_tot c.coopr_tot##c.viol_my , fe
xtreg displr_tot c.coopr_empl##c.viol_my , fe
xtreg displr_tot c.coopr_asso##c.viol_my , fe


// Displ = Coops_all + Controls, fe

global ctr1 ctr_indrural ctr_areaoficialkm2 ctr_altura ctr_discapital ///
	ctr_pib_precapita_cons ctr_aptitud

xtreg displr_tot coopr_tot $ctr1 , fe
xtreg displr_tot coopr_empl $ctr1 , fe
xtreg displr_tot coopr_asso $ctr1 , fe

// Displ = Coops_all*Violence + Controls, fe

xtreg displr_tot c.coopr_tot##c.viol_my $ctr1 , fe
xtreg displr_tot c.coopr_empl##c.viol_my $ctr1 , fe
xtreg displr_tot c.coopr_asso##c.viol_my $ctr1 , fe



log close

