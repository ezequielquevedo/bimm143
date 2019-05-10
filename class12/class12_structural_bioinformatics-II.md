Class 12: Structural Bioinformatics II
================

## 1.1 Obtaining and inspecting our input structure

> Load the Bio3D package and use the get.pdb() function to download the
> “1hsg” PDB entry into your RStudio Project directory:

``` r
library(bio3d)

pdbid <- get.pdb("1HSG")
```

    ## Warning in get.pdb("1HSG"): ./1HSG.pdb exists. Skipping download

``` r
hiv <- read.pdb(pdbid)

# summary of our read-in
hiv
```

    ## 
    ##  Call:  read.pdb(file = pdbid)
    ## 
    ##    Total Models#: 1
    ##      Total Atoms#: 1686,  XYZs#: 5058  Chains#: 2  (values: A B)
    ## 
    ##      Protein Atoms#: 1514  (residues/Calpha atoms#: 198)
    ##      Nucleic acid Atoms#: 0  (residues/phosphate atoms#: 0)
    ## 
    ##      Non-protein/nucleic Atoms#: 172  (residues: 128)
    ##      Non-protein/nucleic resid values: [ HOH (127), MK1 (1) ]
    ## 
    ##    Protein sequence:
    ##       PQITLWQRPLVTIKIGGQLKEALLDTGADDTVLEEMSLPGRWKPKMIGGIGGFIKVRQYD
    ##       QILIEICGHKAIGTVLVGPTPVNIIGRNLLTQIGCTLNFPQITLWQRPLVTIKIGGQLKE
    ##       ALLDTGADDTVLEEMSLPGRWKPKMIGGIGGFIKVRQYDQILIEICGHKAIGTVLVGPTP
    ##       VNIIGRNLLTQIGCTLNF
    ## 
    ## + attr: atom, xyz, seqres, helix, sheet,
    ##         calpha, remark, call

# Q1

> What is the name of the two non protein resid values in this
> structure? What does resid correspond to and how would you get a
> listing of all residue values in this structure?

The two non-protein resids are HOH (water) and MK1 (indinavir).

\==========

``` r
# read in protein only
prot <- atom.select(hiv, "protein", value = TRUE)
write.pdb(prot, file = "1hsg_protein.pdb")

# read in ligand only
lig <- atom.select(hiv, "ligand", value = TRUE)
write.pdb(lig, file = "1hsg_ligand.pdb")
```

> Use the trim.pdb() function to make protein-only and ligand only
> objects called prot and lig that you can then write out to new PDB
> format files in your RStudio project directory.

``` r
# trim.pdb(prot, file = "1hsg_protein.pdb")
# trim.pdb(lig, file = "1hsg_ligand.pdb")
```

## 1.3 Using AutoDockTools to setup protein docking input

> Docking algorithms require each atom to have a charge and an atom type
> that describes its properties. However, typical PDB structures don’t
> contain this information. We therefore have to ‘prep’ the protein and
> ligand files to include these values along with their atomic
> coordinates. All this will be done in a tool called AutoDock Tools
> (ADT for short).

# Q2

> Can you locate the binding site visually? Note that crystal structures
> normally lack hydrogen atoms, why?

The binding site appears to be a vacant space inside the structure,
which lacks hydrogen atoms because they’re smaller than the x-ray
crystallography resolution.

# Q3

> Q3: Look at the charges. Does it make sense (e.g. based on your
> knowledge of the physiochemical properties of amino
acids)?

## Process the **all.pdbtq** file to a PDB format that can be read by VMD (use the Bio3D package)

``` r
library(bio3d)
res <- read.pdb("all.pdbqt", multi=TRUE)
write.pdb(res, "results.pdb")
```

## Normal Mode analysis for flexibility prediction

``` r
pdb <- read.pdb("1HEL")
```

    ##   Note: Accessing on-line PDB file

``` r
modes <- nma(pdb)
```

    ##  Building Hessian...     Done in 0.021 seconds.
    ##  Diagonalizing Hessian...    Done in 0.084 seconds.

``` r
plot(modes, sse=pdb)
```

![](class12_structural_bioinformatics-II_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

``` r
# Visualize NMA results
mktrj(modes, mode=7, file="nma_7.pdb")
```