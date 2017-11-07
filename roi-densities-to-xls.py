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

start_time = time.time()
metadata = pd.read_excel('data/adult tests analysis-14.xlsx', 1)
elapsed_time = time.time() - start_time
print(elapsed_time)
metadata.tail()

#count the cells within
#a certain ROI of
#a certain slice
#a certain slide
#a certain hemisphere
#a certain genotype


#get primary counting
countR = input[input['Hemisphere']=='right'].groupby('Label').count()
countL = input[input['Hemisphere']=='left'].groupby('Label').count()

# take just one column
countRight = countR['Area']
countLeft = countL['Area']

#add discrimination column to the df
indexesRight = pd.DataFrame({'Label':list(countRight.index)})
indexesLeft = pd.DataFrame({'Label':list(countLeft.index)})

#drop indexes
countRight = countRight.reset_index(drop=True)
countLeft = countLeft.reset_index(drop=True)

#merge indexes and the initial count table
resultRight = pd.concat([indexesRight, countRight], axis = 1)
resultLeft = pd.concat([indexesLeft, countLeft], axis = 1)

#discriminate 2hemispheres before the merge
resultRight['Hemisphere']='right'
resultLeft['Hemisphere']='left'

resultBoth = pd.concat([resultRight, resultLeft])
resultBoth=resultBoth.rename(columns = {'Area':'SomaNumber'})

resultBoth = resultBoth.reset_index(drop=True)
print('initial preparation complete at')
print(time.strftime("%H:%M:%S"))

resultBoth['ROI']=''
resultBoth['Key']=''



for iRR in range(0,len(resultBoth)):
    resultBoth['ROI'][iRR] = resultBoth['Label'][iRR][-2:]
    resultBoth['Key'][iRR] = resultBoth['Label'][iRR][7:45]+'_slices-'+resultBoth['Label'][iRR][-9:-7]

metadata['Key']=''

for iM in range(0,len(metadata)):
    metadata['Key'][iM] = metadata['Filename'][iM]+'_slices-'+str(metadata['Slices'][iM])[:-2]

mergedBoth = pd.merge(left=resultBoth, right=metadata, left_on=[resultBoth.Key, resultBoth.Hemisphere], right_on=[metadata.Key, metadata.Hemisphere], how='inner')

m1m2ROI = ['01','02','03','04','05','06','07','08','09','10']
accROI = ['11','12','13']

mergedBoth['SomaDensity'] = ''

for iMB in range(0,len(mergedBoth)):
    if mergedBoth['ROI'][iMB] in (m1m2ROI):
        mergedBoth['SomaDensity'][iMB] = 1000000000*mergedBoth['SomaNumber'][iMB]/(mergedBoth['z-depth'][iMB]*np.pi*mergedBoth['Rm1m2, um'][iMB]*mergedBoth['Rm1m2, um'][iMB]/4)
    if mergedBoth['ROI'][iMB] in (accROI):
        mergedBoth['SomaDensity'][iMB] = 1000000000*mergedBoth['SomaNumber'][iMB]/(mergedBoth['z-depth'][iMB]*np.pi*mergedBoth['Racc, um'][iMB]*mergedBoth['Rm1m2, um'][iMB]/4)


resultBoth.to_excel('output/resultBoth.xls', sheet_name='Sheet1')
metadata.to_excel('output/metadata.xls', sheet_name='Sheet1')
mergedBoth.to_excel('output/mergedBoth.xls', sheet_name='Sheet1')

print('file write complete at')
print(time.strftime("%H:%M:%S"))