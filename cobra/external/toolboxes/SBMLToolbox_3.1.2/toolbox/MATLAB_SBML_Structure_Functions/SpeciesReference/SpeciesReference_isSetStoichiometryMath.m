function value = SpeciesReference_isSetStoichiometryMath(SBMLSpeciesReference)
%
%   SpeciesReference_isSetStoichiometryMath 
%             takes an SBMLSpeciesReference structure 
%
%             and returns 
%               1 if the stoichiometryMath has been set 
%               0 otherwise
%
%       value = SpeciesReference_isSetStoichiometryMath(SBMLSpeciesReference)

%  Filename    :   SpeciesReference_isSetStoichiometryMath.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id: SpeciesReference_isSetStoichiometryMath.m 7155 2008-06-26 20:24:00Z mhucka $
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
if (~isstruct(SBMLSpeciesReference))
    error(sprintf('%s', ...
      'argument must be an SBML SpeciesReference structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLSpeciesReference);

if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'SpeciesReference_isSetStoichiometryMath(SBMLSpeciesReference)', 'argument must be an SBML speciesreference structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'SpeciesReference_isSetStoichiometryMath(SBMLSpeciesReference)', 'no stoichiometryMath field in a level 1 model'));    
end;

value = ~isempty(SBMLSpeciesReference.stoichiometryMath);
