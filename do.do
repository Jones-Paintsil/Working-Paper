clear all
cd "C:\Users\KOJO NYARKOH\OneDrive\Desktop\Ken"

use final_sample.dta, clear
svyset [pw=wt], psu(v001) strata(v022)

/*gen physical_emotional=ippv12m+emo_12m
recode physical_emotional (0=0) (1/2=1)
fre physical_emotional
replace account=. if country==4
replace  ippv12m=. if country==4
replace emo_12m =. if country==4
replace physical_emotional=. if country==4

reg physical_emotional account Women_empowerment_index age_res edu_years work_cur poly occupation3 occupation4 age_p edu_year_p p_occupation3 p_occupation4  middle riher riherest loc2 i.country, clust(v001) 
gen esample=e(sample)
keep if esample==1
save final_sample, replace */

s
*			* * * Analysis
*					OLS

foreach var in "ippv12m" "emo_12m"  "physical_emotional" {
reg `var' account Women_empowerment_index age_res edu_years work_cur poly occupation3 occupation4 age_p edu_year_p p_occupation3 p_occupation4  middle riher riherest loc2 i.country, clust(v001) 

outreg2 using OLS_.xls, dec(4) ctitle(`var') keep(account Women_empowerment_index age_res edu_years work_cur poly occupation3 occupation4 age_p edu_year_p p_occupation3 p_occupation4  middle riher riherest loc2)
}



*** Rural-Urban
foreach var in "ippv12m" "emo_12m"  "physical_emotional" {
foreach num of numlist  0 1 {
reg `var' account Women_empowerment_index age_res edu_years work_cur poly occupation3 occupation4 age_p edu_year_p p_occupation3 p_occupation4  middle riher riherest i.country if loc2==`num', clust(v001) 
outreg2 using OLS_.xls, dec(4) ctitle(`var') keep(account Women_empowerment_index age_res edu_years work_cur poly occupation3 occupation4 age_p edu_year_p p_occupation3 p_occupation4  middle riher riherest loc2)
}
}

** Post estimation

*			Logistic
foreach var in "ippv12m" "emo_12m"  "physical_emotional" {

logistic `var' account Women_empowerment_index age_res edu_years work_cur poly occupation3 occupation4 age_p edu_year_p p_occupation3 p_occupation4  middle riher riherest loc2 i.country, clust(v001)

outreg2 using post_.xls, eform dec(4) ctitle(`var') keep(account Women_empowerment_index age_res edu_years work_cur poly occupation3 occupation4 age_p edu_year_p p_occupation3 p_occupation4  middle riher riherest loc2 )
}

*			Logistic

foreach var in "ippv12m" "emo_12m"  "physical_emotional" {
foreach num of numlist  0 1 {

logistic `var' account Women_empowerment_index age_res edu_years work_cur poly occupation3 occupation4 age_p edu_year_p p_occupation3 p_occupation4  middle riher riherest i.country if loc2==`num', clust(v001)

outreg2 using post_.xls, eform dec(4) ctitle(`var') keep(account Women_empowerment_index age_res edu_years work_cur poly occupation3 occupation4 age_p edu_year_p p_occupation3 p_occupation4  middle riher riherest loc2 )
}
}


* Descriptive
asdoc tab1 physical_emotional  ippv12m emo_12m account work_cur poly occupation3 occupation4 p_occupation3 p_occupation4  middle riher riherest loc2

asdoc su Women_empowerment_index age_res edu_years age_p edu_year_p

estpost ttest physical_emotional  ippv12m emo_12m Women_empowerment_index age_res edu_years work_cur poly occupation3 occupation4 age_p edu_year_p p_occupation3 p_occupation4  middle riher riherest loc2, by(account)

esttab using Table2.rtf, cells("mu_1(fmt(3)) mu_2 b p") wide star(0.1 * 0.05 ** 0.01 ***) label replace stats(N)

su ippv12m emo_12m physical_emotional account
tabstat ippv12m emo_12m physical_emotional account,by(country)
tabstat ippv12m emo_12m physical_emotional account if urban==1,by(country)
cor account ippv12m emo_12m physical_emotional

su ippv12m emo_12m physical_emotional if account==0
su ippv12m emo_12m physical_emotional if account==1

* Statistics
tabstat ippv12m emo_12m physical_emotional, by(country)

*Graph
* physical emotional abuse account
twoway scatter (physical account), mlabel(country)  || lfit (physical account),  clstyle(p2) 

twoway scatter (emotional account), mlabel(country)  || lfit (emotional account),  clstyle(p2) 

twoway scatter (abuse account), mlabel(country)  || lfit (abuse account),  clstyle(p2) 

** Graph
slideplot hbar abuse  account ,neg(abuse) pos(account)   by(country loc) ylabel(-1(0.5)1)

