clear params;

params.filters{1} = 'nosurf';
params.filters{2} = '_200_1000';
params.filters{3} = 'HighSchool';
params.filters{4} = '_pp01_';
params.row_filters{1} = '_noinit_';
params.row_filters{2} = '_rp_';
params.row_filters{3} = '_mu_';
params.row_filters{4} = '_both_';
params.col_filters{1} = 'Dim01';
params.col_filters{2} = 'Dim02';
params.col_filters{3} = 'Dim03';
params.col_filters{4} = 'Dim04';
params.col_filters{5} = 'Dim05';
params.col_filters{6} = 'Dim06';
params.col_filters{7} = 'Dim07';
params.col_filters{8} = 'Dim08';
params.col_filters{9} = 'Dim09';
params.col_filters{10} ='Dim10';

CollatePerformanceStats(params)