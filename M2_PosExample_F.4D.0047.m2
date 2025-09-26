
----This is Macaulay2 code to demonstrate our code for this project

----First we load Jay Yang's code to apply the HHL resolution of the diagonal:

load "hhl (4) (5).m2"

-----and load the "NormalToricVarieties" package:

needsPackage "NormalToricVarieties" 

--Next, we enter a smooth projective toric Fano 4-fold from the polymake database by using the "Facets" matrix from the polymake database for F.4D.0047:

M = matrix{{1, 1, -1, 0, 1}, {1, 0, 0, 0, 1}, {1, 0, 0, -1, 0}, {1, -1, 0, 0, 0}, {1, 0, -1, 1, 1}, {1, 0, -1, 0, 0}, {1, 0, 1, 0, 0}, {1, 0, -1, 0, 1}, {1,0,0,0,-1}}

----The first column of the "Facets" matrix from polymake corresponds to one side of a set of inequalities of being all 1's. So we'll want columns indexed 1-4 (apart from the first column) to input the other side of the inequalities into M2:

MNew = submatrix(M, , {1,2,3,4})

---To translate between conventions in polymake and M2, we multiply by -1:

A = -1*MNew

---and now use the first column as the other side of the inequalities defining the toric polytope P corresponding to F.4D.0047:

v = M_0

----We're now ready to create the toric polytope P, and the associated toric variety:

P = polyhedronFromHData(A, matrix v)
X = normalToricVariety(P)

--Next, we check its dimension, make sure its well defined, smooth, Fano, and projective:

dim X
isWellDefined X
isSmooth X
isFano X
isProjective X

---We also check the class group
classGroup(X)

----and collect the rays of the fan, as well as its maximal cones:

rays X
max X

---For the resolution of diagonal, we'll want to consider the product Y = X**X

Y = X**X

----and to apply the diagonal map:

phi = diagonalToricMap(X)

----We are now ready to apply the HHL resolution of the diagonal, which yields a chain complex as a particular output line.

makeHHLResolution(Y, matrix phi)

---For this example, the output of the makeHHLResolution(--,--) came as line 19, so that is what we'll use (you may need to adjust accordingly, to change o19 to the relevant output line number below):

L = for i from 0 to 4 list(-1*degrees o19#i)

----L is now a list which is recording both a description of a line bundle on the product, and the homological degree from the chain complex. We are just interested in which line bundles appear, rather than their homological degree within this chain complex:

L = flatten L

---Now remember that the above output describes line bundles on the product. To have line bundles on just one factor, we want to take (rank of Cl(X)) - many first entries of each line bundle on X**X:

LBs = for i from 0 to length L-1 list( for j from 0 to rank classGroup(X) - 1 list(L#i#j))

---To avoid repeats in our list:

LBs = unique LBs

---We check how many line bundles appear in our collection: 

length LBs

---and again list the classGroup(X) to have output nearer our computations:

classGroup(X)

-----To write down all Hom's between line bundles which appear, we use the following "quiver" function:
--- Recall that Hom_{D^b(X)}( O(D), O(E)) = H^*(X, O(E-D)) for line bundles O(D), O(E). 

quiver = for i from 0 to length LBs-1 list( for j from 0 to length LBs-1 list( for k from -5 to 5 list(HH^k(X, OO_X(LBs#j#0-LBs#i#0, LBs#j#1-LBs#i#1, LBs#j#2-LBs#i#2, LBs#j#3-LBs#i#3, LBs#j#4-LBs#i#4))))

---To check whether all Hom's live in homological degree 0, we use the following "strong" function:

strong = for i from 0 to length LBs-1 list( for j from 0 to length LBs-1 list( for k from -5 to 5 do(if quiver#i#j#k!=0 then print(k,i,j))))

---This shows us where all non-zero Hom's appear.
--- It now remains to find an ordering of these line bundles for which the collection is exceptional
----We therefore attempt to re-order the line bundles in LBs so that all non-zero Hom's go in one direction: 
--- In order to re-order our line bundles, we therefore first ask where there are non-zero entries in quiver#i#j#k with j>i:


ReOrder = for i from 0 to length LBs-1 list( for j from 0 to length LBs-1 list( for k from -5 to 5 do(if (quiver#i#j#k!=0 and j>i) then print(k,i,j))))

---We therefore define our re-ordered list as:

ReOrderList = {0, 4, 5, 8, 1, 2, 3, 10, 11, 6 ,9 ,13 ,7 ,17, 18, 16, 12 ,14, 15, 19}

---And create our new re-ordered list of line bundles:

LBsNew = for i from 0 to length LBs-1 list LBs#(ReOrderList#i)

---Double-check to make sure we entered all of them:

length LBsNew

--- Now, we re-run quiver and strong with LBsNew:
quiver = for i from 0 to length LBsNew-1 list( for j from 0 to length LBsNew -1 list( for k from -5 to 5 list(HH^k(X, OO_X(LBsNew#j#0-LBsNew#i#0, LBsNew#j#1-LBsNew#i#1, LBsNew#j#2-LBsNew#i#2, LBsNew#j#3-LBsNew#i#3, LBsNew#j#4-LBsNew#i#4))))


--So that the new output of "strong" from the adjusted quiver is:

strong = for i from 0 to length LBsNew-1 list( for j from 0 to length LBsNew-1 list( for k from -5 to 5 do(if quiver#i#j#k!=0 then print(k,i,j))))

----We now have that this corresponds to an exceptional ordering, since all Hom's go in one direction
----We can check this by re-applying "ReOrder" and seeing that the output gives all Hom's in one direction.  
ExceptionalityCheck = for i from 0 to length LBs-1 list( for j from 0 to length LBs-1 list( for k from -5 to 5 do(if (quiver#i#j#k!=0 and j>i) then print(k,i,j))))
--- Note that since we currently have all Hom's to the left, we'd then reverse the ordering of LBsNew to get an exceptional collection.