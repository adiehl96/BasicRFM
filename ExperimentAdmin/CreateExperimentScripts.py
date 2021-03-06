'''
Created on Jul 25, 2012

Create testing .m files

@author: James Lloyd
'''

import csv, os, sys

def produce_line (parameter):
    return 'params.' + parameter + ';'

def main ():
    #specs_file_name = 'ExperimentSpecifications.csv'
    #specs_file_name = 'sushi_100_10.csv'
    #specs_file_name = 'Sandpit.csv'
    specs_file_name = 'lfm_cs_ff.csv'
    try:
        spec_file = open(specs_file_name, 'r')
    except:
        print 'Could not open location data file'
        return
    else:
        file_reader = csv.reader (spec_file, delimiter = ',')
        if len(sys.argv) > 1:
            batches = int(sys.argv[1])
            start_batch = 0
            end_batch = batches;
            if len(sys.argv) > 2:
                # Only produce a specific batch
                start_batch = int(sys.argv[2])
                end_batch = int(sys.argv[2])
        else:
            batches = 0
            start_batch = 0
            end_batch = 0
        for row in file_reader:
            # Currently does not produce a file if there is already saved output
            if (len(row) > 1) and (not os.path.isfile('../SavedExperiments/' + row[0] + '.mat')):
                for batch in range(start_batch, end_batch + 1):
                    print 'Writing file ' + row[0] + ' Batch = ' +  str(batch)
                    if batches == 0:
                        script_file_name = '../TestingScripts/' + row[0] + '.m'
                    else:
                        script_file_name = '../TestingScripts/B_%02d_%s.m' % (batch, row[0])
                    script_file = open(script_file_name, 'w')
                    script_file.write ('clear all;\ncd ..\ngeneric_startup;\n\n')
                    script_file.write ("params.SaveFilename = 'SavedExperiments/" + row[0] + ".mat';\n")
                    for parameter in row[1:]:
                        script_file.write (produce_line(parameter) + '\n')
                    
                    if batches > 0:
                        script_file.write ('params.SplitExperiments = true;\n')
                        script_file.write ('params.Batch = %d;\n' % batch)
                        script_file.write ('params.Batches = %d;\n' % batches)
                        
                    script_file.write ('\nRFMExperiment(params);\n\nquit()\n')
                    
                    script_file.close()
                    if batches == 0:
                        shell_file = open('../TestingScripts/' + row[0] + '.sh', 'w')
                        shell_file.write ('/usr/local/apps/matlab/matlabR2011b/bin/matlab -nosplash -nojvm -nodisplay -singleCompThread -r ' + row[0] +'\n')
                    else:
                        shell_file = open('../TestingScripts/B_%02d_%s.sh' % (batch, row[0]), 'w')
                        shell_file.write ('/usr/local/apps/matlab/matlabR2011b/bin/matlab -nosplash -nojvm -nodisplay -singleCompThread -r B_%02d_%s\n' % (batch, row[0]))
                    shell_file.close()
        spec_file.close()

if __name__ == '__main__':
    main()
    print 'Goodbye, World!'
