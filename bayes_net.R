library(bnlearn)
#http://hameddaily.blogspot.ae/2015/02/bayesian-network-in-r-introduction.html
#https://www.r-bloggers.com/bayesian-network-in-r-introduction/
data(coronary)
bn_df <- data.frame(coronary)
res <- hc(bn_df)
plot(res)
#Therefore, we need to modify the derived structure. Let’s remove the link between M.Work and Family
res$arcs <- res$arcs[-which((res$arcs[,'from'] == "M..Work" & res$arcs[,'to'] == "Family")),]
fittedbn <- bn.fit(res, data = bn_df)
print(fittedbn$Proteins)
cpquery(fittedbn, event = (Proteins=="<3"), evidence = ( Smoking=="no") )
cpquery(fittedbn, event = (Proteins=="<3"), evidence = ( Smoking=="no" & Pressure==">140" ) )
cpquery(fittedbn, event = (Pressure==">140"), evidence = ( Proteins=="<3" ) )
