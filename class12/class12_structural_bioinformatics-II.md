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

# read in ligand only
lig <- atom.select(hiv, "ligand", value = TRUE)
```

> Use the trim.pdb() function to make protein-only and ligand only
> objects called prot and lig that you can then write out to new PDB
> format files in your RStudio project directory.

``` r
trim.pdb(prot, file = "1hsg_protein.pdb")
```

    ## 
    ##  Call:  trim.pdb(pdb = prot, file = "1hsg_protein.pdb")
    ## 
    ##    Total Models#: 1
    ##      Total Atoms#: 1514,  XYZs#: 4542  Chains#: 2  (values: A B)
    ## 
    ##      Protein Atoms#: 1514  (residues/Calpha atoms#: 198)
    ##      Nucleic acid Atoms#: 0  (residues/phosphate atoms#: 0)
    ## 
    ##      Non-protein/nucleic Atoms#: 0  (residues: 0)
    ##      Non-protein/nucleic resid values: [ none ]
    ## 
    ##    Protein sequence:
    ##       PQITLWQRPLVTIKIGGQLKEALLDTGADDTVLEEMSLPGRWKPKMIGGIGGFIKVRQYD
    ##       QILIEICGHKAIGTVLVGPTPVNIIGRNLLTQIGCTLNFPQITLWQRPLVTIKIGGQLKE
    ##       ALLDTGADDTVLEEMSLPGRWKPKMIGGIGGFIKVRQYDQILIEICGHKAIGTVLVGPTP
    ##       VNIIGRNLLTQIGCTLNF
    ## 
    ## + attr: atom, helix, sheet, seqres, xyz,
    ##         calpha, call

``` r
trim.pdb(lig, file = "1hsg_ligand.pdb")
```

    ## 
    ##  Call:  trim.pdb(pdb = lig, file = "1hsg_ligand.pdb")
    ## 
    ##    Total Models#: 1
    ##      Total Atoms#: 45,  XYZs#: 135  Chains#: 1  (values: B)
    ## 
    ##      Protein Atoms#: 0  (residues/Calpha atoms#: 0)
    ##      Nucleic acid Atoms#: 0  (residues/phosphate atoms#: 0)
    ## 
    ##      Non-protein/nucleic Atoms#: 45  (residues: 1)
    ##      Non-protein/nucleic resid values: [ MK1 (1) ]
    ## 
    ## + attr: atom, helix, sheet, seqres, xyz,
    ##         calpha, call

## 1.3 Using AutoDockTools to setup protein docking input

> Docking algorithms require each atom to have a charge and an atom type
> that describes its properties. However, typical PDB structures don’t
> contain this information. We therefore have to ‘prep’ the protein and
> ligand files to include these values along with their atomic
> coordinates. All this will be done in a tool called AutoDock Tools
> (ADT for short).
