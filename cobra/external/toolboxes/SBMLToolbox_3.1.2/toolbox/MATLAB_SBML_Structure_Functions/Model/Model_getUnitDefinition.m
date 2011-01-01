function unitDefinition = Model_getUnitDefinition(SBMLModel, number)
%
%   Model_getUnitDefinition 
%             takes  1) an SBMLModel structure 
%             and    2) a number n
%
%             and returns 
%               the nth unit definition structure defined within the model
%
%       unitDefinition = Model_getUnitDefinition(SBMLModel, number)

%  Filename    :   Model_getUnitDefinition.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id: Model_getUnitDefinition.m 7155 2008-06-26 20:24:00Z mhucka $
%  $Source v $
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright 2005-2007 California Institute of Technology.
% Copyright 2002-2005 California Institute of Technology and
%                     Japan Science and Technology Corporation.
% 
% This library is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
% and also available online as http://sbml.org/software/sbmltoolbox/license.html
%----------------------------------------------------------------------- -->



% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getUnitDefinition(SBMLModel, number)', 'first argument must be an SBML model structure'));
elseif ((number < 1) || (~isIntegralNumber(number)))
    error(sprintf('%s\n%s', 'Model_getUnitDefinition(SBMLModel, number)', 'second argument must be a positive integer'));
end;

if (number > length(SBMLModel.unitDefinition))
    unitDefinition = [];
else
    unitDefinition = SBMLModel.unitDefinition(number);
end;
