clear all

cd "C:\Users\KOJO NYARKOH\OneDrive\Desktop\inclusion_per_dv\Ken\Map"



use Africa_db.dta, clear 

* Merging with shape files
rename new_ID new_id
merge m:1  new_id using data.dta


*keep if _m==3
drop _m
save africa_dbs, replace


s
* insurance utilisation  waz insurance
use africa_dbs, clear
spmap abuse using "africa_coord.dta", id(new_id) fcolor(Reds)  clmethod() clnumber(5)  name(H, replace) legend(title("Domestic violence", size(*0.5))  position(5)) label( data("africa_dbs.dta") xcoord(x_cen_) ycoord(y_cen_) label(country) color(white) size(*0.5)) 

*title("Account Ownership and Domestic violence", size(*0.8))
** Abuse
spmap account using "africa_coord.dta", fcolor(Blues)  clmethod() clnumber(5) id(new_id) legend(title("Account ownership", size(*0.5)) position(8)) point(data("africa_dbs.dta") xcoord(x_cen_) ycoord(y_cen_) proportional(abuse) fcolor(red) size(*1.5) legenda(on) leglabel(Abuse)) label(data("africa_dbs.dta") xcoord(x_cen_) ycoord(y_cen_) label(country) color(white) size(*0.7))

* Physical
spmap account using "africa_coord.dta", fcolor(Blues)  clmethod() clnumber(5) id(new_id) title("Account Ownership and Physical violence", size(*0.8)) legend(title("Account ownership", size(*0.5)) position(8)) point(data("africa_dbs.dta") xcoord(x_cen_) ycoord(y_cen_) proportional(physical) fcolor(red) size(*1.5) legenda(on) leglabel(PV)) label(data("africa_dbs.dta") xcoord(x_cen_) ycoord(y_cen_) label(country) color(white) size(*0.7))

*Emotional violence 
spmap account using "africa_coord.dta", fcolor(Blues)  clmethod() clnumber(5) id(new_id) title("Account Ownership and Emotional violence", size(*0.8)) legend(title("Account ownership", size(*0.5)) position(8)) point(data("africa_dbs.dta") xcoord(x_cen_) ycoord(y_cen_) proportional(emotional) fcolor(red) size(*1.5) legenda(on) leglabel(EV)) label(data("africa_dbs.dta") xcoord(x_cen_) ycoord(y_cen_) label(country) color(white) size(*0.7))
      