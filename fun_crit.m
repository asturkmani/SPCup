function criterion = fun_crit(XTRAIN,ytrain,XTEST,ytest)



% Ensemble = fitensemble(TBL,ResponseVarName,Method,NLearn,Learners) 

% train:
% Ensemble = fitensemble(XTRAIN,ytrain,'bag',50,'Tree','type','classification');%, 'KFold', 10);
Ensemble = fitensemble(XTRAIN,ytrain,'AdaBoostM2',20,'Tree');

% test:
% L = resubLoss(Ensemble)  %predict the train entries
pred_class = predict(Ensemble,XTEST);


% evaluate:
acc = sum(ytest == pred_class) / size(ytest,1);
criterion = 1 - acc;

