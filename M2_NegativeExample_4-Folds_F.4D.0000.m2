----This file will carry out the same steps as "M2_PosExample_F.4D.0047.m2" through the creation of "quiver" and "strong," so we proceed as in 
---- "M2_PosExample_F.4D.0047.m2", with the exception that we use here the "Facets" polytope from polymake for F.4D.0000, and the output
---- line for "MakeHHLResolution(--,--) is now on output line 20. Also, this example has rank of the class group Cl(X) = 3. See "M2_PosExample_F.4D.0047.m2"
---- for line-by-line commenting up to the creation of "quiver" and "strong".

load "hhl (4).m2"
M = matrix {{1, 0, -1, 1, 0}, {1, 0, -1, 0, 0}, {1, 0, 0, 0, -1}, {1, -1, 0, 0, 0}, {1, 0, 0, -1, 0}, {1, 0, 0, 1, 0}, {1, 1, 1, -3, 1}}
MNew = submatrix(M, , {1,2,3,4})
A = -1*MNew
v = M_0
needsPackage "NormalToricVarieties"
P = polyhedronFromHData(A, matrix v)
X = normalToricVariety(P)
dim X
isWellDefined X
isSmooth X
isFano X
classGroup(X)
rays X
max X
fromWDivToCl(X)
Y = X**X
phi = diagonalToricMap(X)
makeHHLResolution(Y, matrix phi)
---Note the change for defining L from "M2_PosExample_F.4D.0047.m2" by using output line 20 here:
L = for i from 0 to 4 list(-1*degrees o20#i)
L = flatten L
LBs = for i from 0 to length L-1 list( for j from 0 to rank classGroup(X) - 1 list(L#i#j))
LBs = unique LBs
length LBs


---We are now ready to create quiver, remembering that the rank of Cl(X) is 3:

quiver = for i from 0 to length LBs-1 list( for j from 0 to length LBs-1 list( for k from -5 to 5 list(HH^k(X, OO_X(LBs#j#0-LBs#i#0, LBs#j#1-LBs#i#1, LBs#j#2-LBs#i#2)))))

---From which we can also create "strong", to list the homological degree of all Hom's between the line bundles in "LBs"

strong = for i from 0 to length LBs-1 list( for j from 0 to length LBs-1 list( for k from -5 to 5 do(if quiver#i#j#k!=0 then print(k,i,j))))


---In the output of "strong", we see that there are Hom's which are graded in non-zero homological degree.
---We also see immediately that line bundles LBs#0 and LBs#10 have non-zero Hom's in both directions. This indicates the presence of a directed cycle in the quiver
--- describing the endomorphism algebra of G = \bigoplus_{i=1}^r E_i (and, therefore, all homomorphisms between the line bundles in "LBs"). The presence of a directed
---- cycle in this directed graph is now an obstruction to the possibility of an ordering of the line bundles in "LBs" for which all Hom's go in one direction. That is,
--- there does not exist an ordering of the line bundles in "LBs" for which this collection is exceptional. 


 