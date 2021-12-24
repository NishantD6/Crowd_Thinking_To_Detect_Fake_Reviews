clear all
import delimited "/Users/Home/Desktop/Term 3/Metrics II/Presentations/FINAL_PPT/econometrics_to_stata_2.csv"


rename avg_score_per~y aspd
rename reviewer_reco~n recommendation
rename review_num_wo~s  numWords

// reg aspd modded##modtime, robust

// outreg2 using myreg.doc, replace ctitle(Model 1)
 
 
 
// reg aspd modded##modtime title nhelpful numWords recommendation date_posted, rob

// DID Estimation Results
diff aspd, t(modded) p(modtime) robust
outreg2 using E2_Fin_PPT1.doc, replace ctitle(Model 1) label


gen did = modtime*modded // generating did parameter

encode title, generate(title_coded)
encode date_posted, generate(date_coded)

xtset title_coded 


xtreg aspd modded modtime did , robust
outreg2 using E2_Fin_PPT.doc, replace ctitle(Model 1) label


xtreg aspd modded modtime did nhelpful nfunny hours_played numWords, robust

outreg2 using E2_Fin_PPT.doc, append ctitle(Model 2) label

reg aspd modded modtime did nhelpful nfunny hours_played i.title_coded , robust
outreg2 using E2_Fin_PPT.doc, keep(aspd modded modtime did nhelpful nfunny hours_played numWords) append ctitle(Model 3) label
