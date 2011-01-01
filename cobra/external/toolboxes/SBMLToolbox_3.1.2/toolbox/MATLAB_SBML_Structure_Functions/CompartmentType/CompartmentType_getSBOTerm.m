function sboTerm = CompartmentType_getSBOTerm(SBMLCompartmentType)
%
%   CompartmentType_getSBOTerm 
%             takes an SBMLCompartmentType structure 
%
%             and returns 
%               the sboTerm of the CompartmentType as an integer
%
%       sboTerm = CompartmentType_getSBOTerm(SBMLCompartmentType)

%  Filename    :   CompartmentType_getSBOTerm.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id: CompartmentType_getSBOTerm.m 7155 2008-06-26 20:24:00Z mhucka $
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
if (~isstruct(SBMLCompartmentType))
    error(sprintf('%s\n%s', ...
      'CompartmentType_getSBOTerm(SBMLCompartmentType)', ...
      'argument must be an SBML CompartmentType structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLCompartmentType);

if (~isSBML_CompartmentType(SBMLCompartmentType, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', ...
      'CompartmentType_getSBOTerm(SBMLCompartmentType)', ...
      'argument must be an SBML CompartmentType structure'));
elseif (sbmlLevel ~= 2 || sbmlVersion == 1)
    error(sprintf('%s\n%s', ...
      'CompartmentType_getSBOTerm(SBMLCompartmentType)', ...
      'sboTerm field only in level 2 version 2/3 model'));    
end;

sboTerm = SBMLCompartmentType.sboTerm;
