# CMC-Fourfolds
Computation of output of Hanlon-Hicks-Lazarev resolution of the diagonal for 124 smooth projective toric Fano fourfolds 


"CMC_Summer_Project__Bondal_s_Numerical_Criterion (1).pdf"
This contains the output of the Sage computation of checking whether Bondal's numerical criterion coincides with the success of the Hanlon-Hicks-Lazarev resolution of the diagonal for smooth projective toric Fano fourfolds, using the polymake database classification of smooth projective toric Fano varieties via smooth reflexive lattice polytopes. Computations to reproduce these results given in "SageNumer4folds...html"

"GitHub_Fourfolds_Repository.pdf" Contains the output of the check in Macaulay2 on the success of the Hanlon-Hicks-Lazarev resolution of the diagonal to yield a full strong exceptional collection of line bundles for each of the 124 smooth projective toric Fano fourfolds. 

"SageNumer4folds.sagews...html": Sage check of whether Bondal's numerical criterion coincides with success of Hanlon-Hicks-Lazarev resolution of the diagonal. Commented inline, but essentially uses a for loop to check the intersection product describing Bondal's numerical criterion. 

"Macaulay2code for Hanlon-Hicks-Lazarev resolution by Jay Yang" Takes as input a smooth projective toric variety in Macaulay2 (along with a toric morphism; we use the diagonal map for all cases here), and outputs a Hanlon-Hicks-Lazarev resolution of the diagonal. A negative example (i.e., for which the Hanlon-Hicks-Lazarev resolution of the diagonal does not yield a full strong exceptional collection of line bundles) given in M2_NegativeExamples_4-folds...". Bondal's numerical criterion for F.4D.0000 checked in Sage in "Sage_BondalsNumericalCriterion_0000.0047.sagews.html"



"M2_NegativeExample_4-Folds..." M2 output using Jay Yang's code for Hanlon-Hicks-Lazarev resolution of the diagonal for F.4D.0000, for which line bundles LBs#0 and LBs#10, for instance, have non-zero Hom's in both directions. The presence of a directed cycle in the quiver describing the endomorphisms between line bundles in the collection of line bundles which appear on one side of the H-H-L resolution implies that there does not exist an ordering for which this collection is exceptional. 







