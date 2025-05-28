# Notes

let's check the collective wisdom: what do you think: do we travel more (say weekly km) because of home office or less? (mark on whiteboard)

short definition/explanation of what telework is

evolution of telework, the pandemic as catalyst (a la bloom) and some graph from the first paper: very quickly, results of the first paper (expected normalization after the pandemic - no significant preference differences across telework population regarding mode shares => telework being the lasting legacy of the pandemic)

understanding transport demand is very complex (maybe from utility maximizing perspective?): why do people travel, how do they travel, where do they travl, what route do they choose, how do they respond to external conditions (e.g., network conditions) => on weekdays, we sleep and work. and we usually don't travel while sleeping. our everyday life is organized around work. and if this dimension changes it is easy to imagine that our daily travel and time-use patterns change profoundly.

understanding telework is multi-facetted with many dimensions being impacted and could be investigated (examples)
also question of short (daily decision), medium (my analysis) and long-term (e.g., relocation decisions)

in this thesis we try to answer quite a simple question (medium term view): Does telework lead to more or less transport demand and quantify this effect. understand descriptively how telework impacts transport demand (conclusion: mainly a commuter phenomenon)

try to correct and illustrate shortcomings in the current literature potentially explaining why the results are that mixed and trying popularize an old method (dating back to the seminal work by heckman) to account for self-selection and estimate treatment effects (instead of group comparisons)

boxplot => no effect or even increase: Explain why this might be the case: self-selection, selection on observables and unobservables

key equations and explanation of OVB

OPSR core and what it does under the hood, some implementation details (demo - run the script). why is it better than other implementations?

analysis paper: descriptives + treatment effects plot and table, then compare to not accounting for error correlation

also scratches the question how telework can be managed and whether employers can (dis-) incentivize telework. while the analysis might suffer itself from endogeneity bias it hints that nuding employees to deviate from their baseline telework preferences is very difficult. and it is quite understandable why this might be the case: vtts of foregone commute already quite substantial...

now these results might be very specific for Switzerland. however, the OPSR package allows it to estimate such models for many different countries (e.g., based on census data): all we need is a telework intensity measure and some continuous outcome operationalizing transport demand (e.g., weekly kilometers traveled based on some travel diary)

limitations: 
panel vs. cross-sectional => leveraging the panel structure (e.g., comparing a person's daily km on home office days, vs. non-home office days. but also here caution: telework on bad days, travel less on bad days => telework proxies the impact of weather conditions on distance traveled, yet again, not accounting for such channels could lead to OVB; we would need to understand how people decide when and why to telework) => I have to agree: recently, we celebrated a colleagues birthday (it was a Tuesday) and the next day I was doing quote "home office"...
modeling processes simultaneously, accounting for error correlation, estimating a multivariate error distribution => example: telework arrangement choice (MNL), error + telework frequency choice (OP), error => error correlation? copula modeling! unified framework for R
LOL

Conclude with: Checking the collective wisdom (point to mark on whiteboard)
Telework is mainly a commuting phenomenon (explain) with little impact on overall time-allocation and activity patterns (trip origin home) with a quite substantial potential to reduce VMD and thus helps reducing its climate impact - it should be encouraged!
