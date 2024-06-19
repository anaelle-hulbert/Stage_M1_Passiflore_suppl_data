##### Script python pour renomer les sequence fasta #####

### test re.search ###
#import re

#nom_seq = ">GU266608.1 Passiflora suberosa voucher VPI:Hinkle 373 maturase K (matK) gene, complete cds; chloroplast"
#regex = r'^>([A-Z]+\d+)[\.]\d\s([A-Z][a-z]+)\s([a-z]+)\s.*$'

#match_seq = re.search(regex,nom_seq)

#if match_seq : 
# print ("YES")
# acc_number = match_seq.group(1)
# name_genus = match_seq.group(2)
# name_specie= match_seq.group(3)
# print (acc_number)
# print (name_genus)
# print (name_specie)
#else :
# print("No")


### renomer les sequence ###

import re

#matK
seq_matK_passiflora_base = open('/home/anahulbert/Documents/stage_passiflore/sequence_gene/sequence_propre/seq_matK_passiflora_unaligned.fasta', 'r')

seq_matK_passiflora_rename = open('/home/anahulbert/Documents/stage_passiflore/sequence_gene/sequence_propre/seq_matK_passiflora_unaligned_rename.fasta', 'w')

for line in seq_matK_passiflora_base : 
    regex = r'^>([A-Z]+\d+)[\.]\d\s([A-Z][a-z]+)\s([a-z]+)\s.*$'
    match_seq = re.search(regex,line)
    regex_unverif = r'^>([A-Z]+\d+)[\.]\d\s[A-Z]+[\:]\s([A-Z][a-z]+)\s([a-z]+)\s.*$'
    match_seq_unverif = re.search(regex_unverif,line)
    if match_seq : 
       #print ("YES")
       acc_number = match_seq.group(1)
       name_genus = match_seq.group(2)
       name_specie= match_seq.group(3)
       nom_seq_final = []
       nom_seq_final.append(">" + str(name_genus) + "_" + str(name_specie) + "_" + str(acc_number) + " \n")
       #print (nom_seq_final)
       seq_matK_passiflora_rename.writelines(nom_seq_final)
    elif match_seq_unverif :
       acc_number_unverif = match_seq_unverif.group(1)
       name_genus_unverif = match_seq_unverif.group(2)
       name_specie_unverif= match_seq_unverif.group(3)
       nom_seq_final_unverif = []
       nom_seq_final_unverif.append(">" + str(name_genus_unverif) + "_" + str(name_specie_unverif) + "_" + str(acc_number_unverif) + " \n")
       print (nom_seq_final_unverif)
       seq_matK_passiflora_rename.writelines(nom_seq_final_unverif)
    else :
       seq_matK_passiflora_rename.writelines(line)
       #print(line)

#rbcl
seq_rbcl_passiflora_base = open('/home/anahulbert/Documents/stage_passiflore/sequence_gene/sequence_propre/seq_rbcl_passiflora_unaligned.fasta', 'r')

seq_rbcl_passiflora_rename = open('/home/anahulbert/Documents/stage_passiflore/sequence_gene/sequence_propre/seq_rbcl_passiflora_unaligned_rename.fasta', 'w')

for line in seq_rbcl_passiflora_base : 
    regex = r'^>([A-Z]+\d+)[\.]\d\s([A-Z][a-z]+)\s([a-z]+)\s.*$'
    match_seq = re.search(regex,line)
    regex_unverif = r'^>([A-Z]+\d+)[\.]\d\s[A-Z]+[\:]\s([A-Z][a-z]+)\s([a-z]+)\s.*$'
    match_seq_unverif = re.search(regex_unverif,line)
    if match_seq : 
       #print ("YES")
       acc_number = match_seq.group(1)
       name_genus = match_seq.group(2)
       name_specie= match_seq.group(3)
       nom_seq_final = []
       nom_seq_final.append(">" + str(name_genus) + "_" + str(name_specie) + "_" + str(acc_number) + " \n")
       #print (nom_seq_final)
       seq_rbcl_passiflora_rename.writelines(nom_seq_final)
    elif match_seq_unverif :
       acc_number_unverif = match_seq_unverif.group(1)
       name_genus_unverif = match_seq_unverif.group(2)
       name_specie_unverif= match_seq_unverif.group(3)
       nom_seq_final_unverif = []
       nom_seq_final_unverif.append(">" + str(name_genus_unverif) + "_" + str(name_specie_unverif) + "_" + str(acc_number_unverif) + " \n")
       print (nom_seq_final_unverif)
       seq_rbcl_passiflora_rename.writelines(nom_seq_final_unverif)
    else :
       seq_rbcl_passiflora_rename.writelines(line)
       #print(line)

#trnL
seq_trnL_passiflora_base = open('/home/anahulbert/Documents/stage_passiflore/sequence_gene/sequence_propre/seq_trnL_passiflora_unaligned.fasta', 'r')

seq_trnL_passiflora_rename = open('/home/anahulbert/Documents/stage_passiflore/sequence_gene/sequence_propre/seq_trnL_passiflora_unaligned_rename.fasta', 'w')

for line in seq_trnL_passiflora_base : 
    regex = r'^>([A-Z]+\d+)[\.]\d\s([A-Z][a-z]+)\s([a-z]+)\s.*$'
    match_seq = re.search(regex,line)
    regex_unverif = r'^>([A-Z]+\d+)[\.]\d\s[A-Z]+[\:]\s([A-Z][a-z]+)\s([a-z]+)\s.*$'
    match_seq_unverif = re.search(regex_unverif,line)
    if match_seq : 
       #print ("YES")
       acc_number = match_seq.group(1)
       name_genus = match_seq.group(2)
       name_specie= match_seq.group(3)
       nom_seq_final = []
       nom_seq_final.append(">" + str(name_genus) + "_" + str(name_specie) + "_" + str(acc_number) + " \n")
       #print (nom_seq_final)
       seq_trnL_passiflora_rename.writelines(nom_seq_final)
    elif match_seq_unverif :
       acc_number_unverif = match_seq_unverif.group(1)
       name_genus_unverif = match_seq_unverif.group(2)
       name_specie_unverif= match_seq_unverif.group(3)
       nom_seq_final_unverif = []
       nom_seq_final_unverif.append(">" + str(name_genus_unverif) + "_" + str(name_specie_unverif) + "_" + str(acc_number_unverif) + " \n")
       print (nom_seq_final_unverif)
       seq_trnL_passiflora_rename.writelines(nom_seq_final_unverif)
    else :
       seq_trnL_passiflora_rename.writelines(line)
       #print(line)


#trnH
seq_trnH_passiflora_base = open('/home/anahulbert/Documents/stage_passiflore/sequence_gene/sequence_propre/seq_trnH_passiflora_unaligned.fasta', 'r')

seq_trnH_passiflora_rename = open('/home/anahulbert/Documents/stage_passiflore/sequence_gene/sequence_propre/seq_trnH_passiflora_unaligned_rename.fasta', 'w')

for line in seq_trnH_passiflora_base : 
    regex = r'^>([A-Z]+\d+)[\.]\d\s([A-Z][a-z]+)\s([a-z]+)\s.*$'
    match_seq = re.search(regex,line)
    regex_unverif = r'^>([A-Z]+\d+)[\.]\d\s[A-Z]+[\:]\s([A-Z][a-z]+)\s([a-z]+)\s.*$'
    match_seq_unverif = re.search(regex_unverif,line)
    if match_seq : 
       #print ("YES")
       acc_number = match_seq.group(1)
       name_genus = match_seq.group(2)
       name_specie= match_seq.group(3)
       nom_seq_final = []
       nom_seq_final.append(">" + str(name_genus) + "_" + str(name_specie) + "_" + str(acc_number) + " \n")
       #print (nom_seq_final)
       seq_trnH_passiflora_rename.writelines(nom_seq_final)
    elif match_seq_unverif :
       acc_number_unverif = match_seq_unverif.group(1)
       name_genus_unverif = match_seq_unverif.group(2)
       name_specie_unverif= match_seq_unverif.group(3)
       nom_seq_final_unverif = []
       nom_seq_final_unverif.append(">" + str(name_genus_unverif) + "_" + str(name_specie_unverif) + "_" + str(acc_number_unverif) + " \n")
       print (nom_seq_final_unverif)
       seq_trnH_passiflora_rename.writelines(nom_seq_final_unverif)
    else :
       seq_trnH_passiflora_rename.writelines(line)
       #print(line)

#ndhF
seq_ndhF_passiflora_base = open('/home/anahulbert/Documents/stage_passiflore/sequence_gene/sequence_propre/seq_ndhF_passiflora_unaligned.fasta', 'r')

seq_ndhF_passiflora_rename = open('/home/anahulbert/Documents/stage_passiflore/sequence_gene/sequence_propre/seq_ndhF_passiflora_unaligned_rename.fasta', 'w')

for line in seq_ndhF_passiflora_base : 
    regex = r'^>([A-Z]+\d+)[\.]\d\s([A-Z][a-z]+)\s([a-z]+)\s.*$'
    match_seq = re.search(regex,line)
    regex_unverif = r'^>([A-Z]+\d+)[\.]\d\s[A-Z]+[\:]\s([A-Z][a-z]+)\s([a-z]+)\s.*$'
    match_seq_unverif = re.search(regex_unverif,line)
    if match_seq : 
       #print ("YES")
       acc_number = match_seq.group(1)
       name_genus = match_seq.group(2)
       name_specie= match_seq.group(3)
       nom_seq_final = []
       nom_seq_final.append(">" + str(name_genus) + "_" + str(name_specie) + "_" + str(acc_number) + " \n")
       #print (nom_seq_final)
       seq_ndhF_passiflora_rename.writelines(nom_seq_final)
    elif match_seq_unverif :
       acc_number_unverif = match_seq_unverif.group(1)
       name_genus_unverif = match_seq_unverif.group(2)
       name_specie_unverif= match_seq_unverif.group(3)
       nom_seq_final_unverif = []
       nom_seq_final_unverif.append(">" + str(name_genus_unverif) + "_" + str(name_specie_unverif) + "_" + str(acc_number_unverif) + " \n")
       print (nom_seq_final_unverif)
       seq_ndhF_passiflora_rename.writelines(nom_seq_final_unverif)
    else :
       seq_ndhF_passiflora_rename.writelines(line)
       #print(line)


#rps4
seq_rps4_passiflora_base = open('/home/anahulbert/Documents/stage_passiflore/sequence_gene/sequence_propre/seq_rps4_passiflora_unaligned.fasta', 'r')

seq_rps4_passiflora_rename = open('/home/anahulbert/Documents/stage_passiflore/sequence_gene/sequence_propre/seq_rps4_passiflora_unaligned_rename.fasta', 'w')

for line in seq_rps4_passiflora_base : 
    regex = r'^>([A-Z]+\d+)[\.]\d\s([A-Z][a-z]+)\s([a-z]+)\s.*$'
    match_seq = re.search(regex,line)
    regex_unverif = r'^>([A-Z]+\d+)[\.]\d\s[A-Z]+[\:]\s([A-Z][a-z]+)\s([a-z]+)\s.*$'
    match_seq_unverif = re.search(regex_unverif,line)
    if match_seq : 
       #print ("YES")
       acc_number = match_seq.group(1)
       name_genus = match_seq.group(2)
       name_specie= match_seq.group(3)
       nom_seq_final = []
       nom_seq_final.append(">" + str(name_genus) + "_" + str(name_specie) + "_" + str(acc_number) + " \n")
       #print (nom_seq_final)
       seq_rps4_passiflora_rename.writelines(nom_seq_final)
    elif match_seq_unverif :
       acc_number_unverif = match_seq_unverif.group(1)
       name_genus_unverif = match_seq_unverif.group(2)
       name_specie_unverif= match_seq_unverif.group(3)
       nom_seq_final_unverif = []
       nom_seq_final_unverif.append(">" + str(name_genus_unverif) + "_" + str(name_specie_unverif) + "_" + str(acc_number_unverif) + " \n")
       print (nom_seq_final_unverif)
       seq_rps4_passiflora_rename.writelines(nom_seq_final_unverif)
    else :
       seq_rps4_passiflora_rename.writelines(line)
       #print(line)















