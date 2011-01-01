function [unit, SBMLModel] = Model_createUnit(SBMLModel)
%
%   Model_createUnit 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the unit structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created unit
%
%       NOTE: the units is added to the last unit definition created
%
%       [unit, SBMLModel] = Model_createUnit(SBMLModel)

%  Filename    :   Model_createUnit.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id: Model_createUnit.m 7155 2008-06-26 20:24:00Z mhucka $
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
    error(sprintf('%s\n%s', 'Model_createUnit(SBMLModel)', 'first argument must be an SBML model structure'));
end;

unit = Unit_create(SBMLModel.SBML_level, SBMLModel.SBML_version);

if (length(SBMLModel.unitDefinition) == 0)
    unit = [];
    warning('Failed to create unit');
else
    SBMLModel.unitDefinition(end) = UnitDefinition_addUnit(SBMLModel.unitDefinition(end), unit);
end;

