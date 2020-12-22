// Colombian Coops
// 24/04/18
// Regressions 2, lagged

clear all
set more off

cd "/Users/vinceth/MEGAsync/UB ECONOMICS/Year2_17-18/_Thesis/Data/_Master"

use master_panel

log using reg2, replace

// Displ = L.Coops_all

xtreg displr_tot L.coopr_tot
xtreg displr_tot L.coopr_empl
xtreg displr_tot L.coopr_asso


// Displ = L.Coops_all, fe

xtreg displr_tot L.coopr_tot, fe
xtreg displr_tot L.coopr_empl, fe
xtreg displr_tot L.coopr_asso, fe


// Displ = L.Coops_all + L.Violence, fe

xtreg displr_tot L.coopr_tot L.viol_my, fe
xtreg displr_tot L.coopr_empl L.viol_my, fe
xtreg displr_tot L.coopr_asso L.viol_my, fe

// Displ = L.Coops_all*L.Violence , fe

xtreg displr_tot c.L.coopr_tot##c.L.viol_my , fe
xtreg displr_tot c.L.coopr_empl##c.L.viol_my , fe
xtreg displr_tot c.L.coopr_asso##c.L.viol_my , fe


// Displ = L.Coops_all + L.Controls, fe

global ctr1l L.ctr_indrural L.ctr_areaoficialkm2 L.ctr_altura L.ctr_discapital ///
	L.ctr_pib_precapita_cons L.ctr_aptitud

xtreg displr_tot L.coopr_tot $ctr1l , fe
xtreg displr_tot L.coopr_empl $ctr1l , fe
xtreg displr_tot L.coopr_asso $ctr1l , fe

// Displ = L.Coops_all*L.Violence + L.Controls, fe

xtreg displr_tot c.L.coopr_tot##c.L.viol_my $ctr1l , fe
xtreg displr_tot c.L.coopr_empl##c.L.viol_my $ctr1l , fe
xtreg displr_tot c.L.coopr_asso##c.L.viol_my $ctr1l , fe

log close
