function SBMLTrigger = Trigger_setMath(SBMLTrigger, math)
%
%   Trigger_setMath 
%             takes  1) an SBMLTrigger structure 
%             and    2) an string representing the math to be set
%
%             and returns 
%               the compartment with the math set
%
%       SBMLTrigger = Trigger_setMath(SBMLTrigger, math)

%  Filename    :   Trigger_setMath.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id: Trigger_setMath.m 7155 2008-06-26 20:24:00Z mhucka $
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
if (~isstruct(SBMLTrigger))
    error(sprintf('%s\n%s', ...
      'Trigger_getMath(SBMLTrigger)', ...
      'argument must be an SBML Trigger structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLTrigger);

if (~isSBML_Trigger(SBMLTrigger, sbmlLevel, sbmlVersion))
  error(sprintf('%s\n%s', ...
    'Trigger_setMath(SBMLTrigger, math)', ...
    'first argument must be an SBML Trigger structure'));
elseif (~ischar(math))
    error(sprintf('%s\n%s', ...
      'Trigger_setMath(SBMLTrigger, math)', ...
      'second argument must be a string representing the math'));
elseif (sbmlLevel ~= 2 || sbmlVersion ~= 3)
    error(sprintf('%s\n%s', ...
      'Trigger_setMath(SBMLTrigger, math)',  ...
      'math field only in level 2 version 3 model'));    
end;

SBMLTrigger.math = math;
