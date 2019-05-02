Homework for Lecture 6: R Functions (4/25)
================
Ezequiel Quevedo
4/21/2019

## Improving analysis code by writing functions

#### Can you improve this analysis code?

``` r
library(bio3d)
s1 <- read.pdb("4AKE")  # kinase with drug
s2 <- read.pdb("1AKE")  # kinase no drug
s3 <- read.pdb("1E4Y")  # kinase with drug
s1.chainA <- trim.pdb(s1, chain="A", elety="CA")
s2.chainA <- trim.pdb(s2, chain="A", elety="CA")
s3.chainA <- trim.pdb(s1, chain="A", elety="CA")
s1.b <- s1.chainA$atom$b
s2.b <- s2.chainA$atom$b
s3.b <- s3.chainA$atom$b
plotb3(s1.b, sse=s1.chainA, typ="l", ylab="Bfactor")
plotb3(s2.b, sse=s2.chainA, typ="l", ylab="Bfactor")
plotb3(s3.b, sse=s3.chainA, typ="l", ylab="Bfactor")
```

#### Answer:

``` r
library(bio3d)

# assign kinase identifiers to kinases vector, k
# assign kinase with drug logical, d. info is not used, but not lost
kinases <- list(kin = c("4AKE", "1AKE", "1E4Y"), 
                drug = c(TRUE, FALSE, TRUE)) 

# generalize the common features of the original code into a new function, bfactor
bfactor <- function(s) {
  for (i in s[[1]]) { # for loop iterates through each value in s[1], our kinase IDs
    si <- read.pdb(i) # read-in PDB data for s[1], and assign to si
    si.chainA <- trim.pdb(si, chain = "A", elety = "CA") 
    si.b <- si.chainA$atom$b
    plotb3(si.b, sse = si.chainA, typ = "l", ylab = "Bfactor")
  }
}
```

#### This is how we call our new function, and what it prints:

``` r
# pass kinase identifiers by reference #
bfactor(kinases)
```

    ##   Note: Accessing on-line PDB file

![](hw_due_4-25_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

    ##   Note: Accessing on-line PDB file
    ##    PDB has ALT records, taking A only, rm.alt=TRUE

![](hw_due_4-25_files/figure-gfm/unnamed-chunk-3-2.png)<!-- -->

    ##   Note: Accessing on-line PDB file

![](hw_due_4-25_files/figure-gfm/unnamed-chunk-3-3.png)<!-- -->

#### This is what the original function prints out, once s3 trim.pdb argument is corrected:

``` r
library(bio3d)
s1 <- read.pdb("4AKE")  # kinase with drug
```

    ##   Note: Accessing on-line PDB file

    ## Warning in get.pdb(file, path = tempdir(), verbose = FALSE): /var/folders/
    ## s0/p4fngctn6yzck2941qx2s8qm0000gn/T//RtmpUKYQcf/4AKE.pdb exists. Skipping
    ## download

``` r
s2 <- read.pdb("1AKE")  # kinase no drug
```

    ##   Note: Accessing on-line PDB file

    ## Warning in get.pdb(file, path = tempdir(), verbose = FALSE): /var/folders/
    ## s0/p4fngctn6yzck2941qx2s8qm0000gn/T//RtmpUKYQcf/1AKE.pdb exists. Skipping
    ## download

    ##    PDB has ALT records, taking A only, rm.alt=TRUE

``` r
s3 <- read.pdb("1E4Y")  # kinase with drug
```

    ##   Note: Accessing on-line PDB file

    ## Warning in get.pdb(file, path = tempdir(), verbose = FALSE): /var/folders/
    ## s0/p4fngctn6yzck2941qx2s8qm0000gn/T//RtmpUKYQcf/1E4Y.pdb exists. Skipping
    ## download

``` r
s1.chainA <- trim.pdb(s1, chain="A", elety="CA")
s2.chainA <- trim.pdb(s2, chain="A", elety="CA")
s3.chainA <- trim.pdb(s3, chain="A", elety="CA") # s3 corrected from s1
s1.b <- s1.chainA$atom$b
s2.b <- s2.chainA$atom$b
s3.b <- s3.chainA$atom$b
plotb3(s1.b, sse=s1.chainA, typ="l", ylab="Bfactor")
```

![](hw_due_4-25_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

``` r
plotb3(s2.b, sse=s2.chainA, typ="l", ylab="Bfactor")
```

![](hw_due_4-25_files/figure-gfm/unnamed-chunk-4-2.png)<!-- -->

``` r
plotb3(s3.b, sse=s3.chainA, typ="l", ylab="Bfactor")
```

![](hw_due_4-25_files/figure-gfm/unnamed-chunk-4-3.png)<!-- -->
