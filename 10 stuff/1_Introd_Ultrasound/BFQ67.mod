* Filename:  BFQ67_SPICE.PRM
* BFQ67 SPICE MODEL
* PHILIPS SEMICONDUCTORS
* Date : September 1995
*
* PACKAGE : SOT23 DIE MODEL : BFQ65
* 1: COLLECTOR; 2: BASE; 3: EMITTER;
*.SUBCKT BFQ67 1 2 3
*Q1 6 5 7 7 BFQ65
* SOT23 parasitic model
*               Lb  4 5 .4n 
*               Le  7 8 .83n
*               L1  2 4 .35n
*               L2  1 6 .17n
*               L3  3 8 .35n
*              Ccb  4 6 71f
*              Cbe  4 8 2f
*              Cce  6 8 71f
*
* PHILIPS SEMICONDUCTORS                                     Version:   1.0
* Filename:    BFQ65.PRM                                     Date: Feb 1992
*
*.MODEL  BFQ65   NPN
.MODEL  BFQ67   NPN
+              IS = 5.56440E-016
+              BF = 2.70000E+002
+              NF = 9.94874E-001
+             VAF = 4.80334E+001
+             IKF = 9.18182E-001
+             ISE = 1.04797E-014
+              NE = 1.47947E+000
+              BR = 1.42108E+002
+              NR = 9.94125E-001
+             VAR = 2.55564E+000
+             IKR = 9.63277E+000
+             ISC = 4.38252E-016
+              NC = 1.08948E+000
+              RB = 1.00000E+001
+             IRB = 1.00000E-006
+             RBM = 1.00000E+001
+              RE = 6.55965E-001
+              RC = 2.00000E+000
+              EG = 1.11000E+000
+             XTI = 3.00000E+000
+             CJE = 1.13769E-012
+             VJE = 6.00000E-001
+             MJE = 2.49462E-001
+              TF = 1.19796E-011
+             XTF = 2.59987E+001
+             VTF = 1.22309E+000
+             ITF = 1.97376E-001
+             PTF = 1.00348E+001
+             CJC = 5.15977E-013
+             VJC = 1.55871E-001
.ENDS