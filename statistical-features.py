# libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import time

start_time = time.time()
input = pd.read_excel('data/2016-03-09_cells_merged_hemispheres.xlsx', 0)
elapsed_time = time.time() - start_time
print(elapsed_time)

%matplotlib inline
import warnings
warnings.filterwarnings('ignore')
plt.style.use('ggplot')

#genotype filtering
list_WT = ['f-f_cre-neg','f-p_cre-neg','p-p_cre-neg','p-p_cre-pos']
list_CKO = ['f-f_cre-pos']
list_HTZ = ['f-p_cre-pos']

pattern_HTZ = '|'.join(list_HTZ)
pattern_WT = '|'.join(list_WT)
pattern_CKO = '|'.join(list_CKO)

CKO = input[input['Label'].str.contains(pattern_CKO)]
print('CKO')
print('\n=====================================')
print(CKO['Area'].describe(percentiles=[.05, .25, .75, .95]))
print('\n=====================================')

WT = input[input['Label'].str.contains(pattern_WT)]
print('WT')
print('\n=====================================')
print(WT['Area'].describe(percentiles=[.05, .25, .75, .95]))
print('\n=====================================')

HTZ = input[input['Label'].str.contains(pattern_HTZ)]
print('HTZ')
print('\n=====================================')
print(HTZ['Area'].describe(percentiles=[.05, .25, .75, .95]))

print('\n=====================================')

#Area
plt.figure(figsize=(12, 8));

halpha = 0.4
hbins = 51

CKO['Area'].plot(kind='hist', stacked=True, bins=hbins, alpha=halpha,normed=True)
WT['Area'].plot(kind='hist', stacked=True, bins=hbins, alpha=halpha,normed=True)
HTZ['Area'].plot(kind='hist', stacked=True, bins=hbins, alpha=halpha,normed=True)

plt.legend(['CKO','WT','HTZ'])
plt.title('Area')

#Perim.
plt.figure(figsize=(12, 8));

halpha = 0.6
hbins = 30

CKO['Perim.'].plot(kind='hist', stacked=True, bins=hbins, alpha=halpha,normed=True)
WT['Perim.'].plot(kind='hist', stacked=True, bins=hbins, alpha=halpha,normed=True)
HTZ['Perim.'].plot(kind='hist', stacked=True, bins=hbins, alpha=halpha,normed=True)
plt.legend(['CKO','WT','HTZ'])
plt.title('Perim.')

#AR
plt.figure(figsize=(12, 8));

halpha = 0.6
hbins = 80

CKO['AR'].plot(kind='hist', stacked=True, bins=hbins, alpha=halpha,normed=True)
WT['AR'].plot(kind='hist', stacked=True, bins=hbins, alpha=halpha,normed=True)
HTZ['AR'].plot(kind='hist', stacked=True, bins=hbins, alpha=halpha,normed=True)
plt.legend(['CKO','WT','HTZ'])
plt.title('AR')

#Roundness
plt.figure(figsize=(12, 8));

halpha = 0.6
hbins = 20

CKO['Round'].plot(kind='hist', stacked=True, bins=hbins, alpha=halpha,normed=True)
WT['Round'].plot(kind='hist', stacked=True, bins=hbins, alpha=halpha,normed=True)
HTZ['Round'].plot(kind='hist', stacked=True, bins=hbins, alpha=halpha,normed=True)
plt.legend(['CKO','WT','HTZ'])
plt.title('Roundness')