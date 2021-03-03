from pathlib import Path

# Based on Collin's orginal scripts the input files would be 1) the GTF file
# and 2 the genome name used to specify the genome in chromHmm
# assume scripts have been placed into scripts directory

# just notices the scripts directory also has the files
# make make_TES and make_TSS. Are these more recent versions?
# I am not currently sure if they are doing the same thing

genome_name = Path(config['genome']).stem
coords_dir = str(Path(chrom_hmm_dir).joinpath('COORDS'))
anchor_dir = str(Path(chrom_hmm_dir).joinpath('ANCHORFILES'))

rule make_coords_exon_file:
    input:
        gtf_file  # placeholder for now, would be the path to gtf file specific to target genome
    output:
        lambda: Path(coords_dir).joinpath(genome_name).joinpath(f'Exon.{genome_name}.txt.gz')
    shell:'''
    mkdir -p 
    grep '\sexon\s' {input} | cut -f1,4,5 | sort -k1,1 -k2,2n | uniq | gzip > {output}
    '''

rule make_coords_gene_file:
    input:
        gtf_file
    output:
        lambda: Path(coords_dir).joinpath(genome_name).joinpath(f'Gene.{genome_name}.txt.gz')
    shell:'''
    grep '\sgene\s' {input} | cut -f1,4,5 | sort -k1,1 -k2,2n | uniq | gzip > {output}
    '''

rule make_promotor_bed_file:
    input:
        gtf_file
    output:
        lambda: Path(coords_dir).joinpath(genome_name).joinpath(f'Promotor.{genome_name}.txt.gz')
    shell:''' 
    grep '\sgene\s' {input} | python ../Scripts/Create_Promoter_Bed.py | sort -k1,1 -k2,2n | uniq | gzip > {output}
    '''

rule make_coord_tss_file:
    input:
        gtf_file
    output:
        lambda: Path(coords_dir).joinpath(genome_name).joinpath(f'TSS.{genome_name}.txt.gz')
    shell:'''
    grep '\sgene\s' {input} | python ../Scripts/get_TSS.py | sort -k1,1 -k2,2n | uniq | gzip > {output}
    '''

rule make_coord_tes_file:
    input:
        gtf_file
    output:
        lambda: Path(coords_dir).joinpath(genome_name).joinpath(f'TES.{genome_name}.txt.gz')
    shell:'''
    grep '\sgene\s' {input} | python ../Scripts/get_TES.py | sort -k1,1 -k2,2n | uniq | gzip > {output}
    '''
    # need to move TSS and TES scripts to Scripts folder from Additional_Scripts

rule make_anchor_tss_file:
    input:
        gtf_file
    output:
        lambda: Path(anchor_dir).joinpath(genome_name).joinpath(f'TSS.{genome_name}.txt.gz')
    shell:'''
    grep '\sgene\s' {input} | python ../Scripts/get_TSS.py | sort -k1,1 -k2,2n | uniq | gzip > {output}
    '''

rule make_anchor_tes_file:
    input:
        gtf_file
    output:
        tes_file=lambda: Path(anchor_dir).joinpath(genome_name).joinpath(f'TES.{genome_name}.txt.gz'),
        done_signal = touch('chromHmm_setup.done')  # this was last part of Colin's script touch a file so can signal it has completed
    shell:'''
    grep '\sgene\s' {input} | python ../Scripts/get_TES.py | sort -k1,1 -k2,2n | uniq | gzip > {output}
    '''


      


