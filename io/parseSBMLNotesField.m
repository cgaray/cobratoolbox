function [genes, rule, subSystem, grRule, formula, confidenceScore, ...
        citation, ecNumber, charge, rxnGeneMat] = ...
        parseSBMLNotesField(notesField)

    % parseSBMLNotesField Parse the notes field of an SBML file to extract
    % gene-rxn associations and other annotation
    %
    % [genes, rule, subSystem, grRule, formula, confidenceScore, ...
    %        citation, comment, ecNumber, charge] = ...
    %        parseSBMLNotesField(notesField)

    % Markus Herrgard 8/7/06
    % Ines Thiele 1/27/10 - Added new fields
    % Ben Heavner 18 June 2013 - add cell array functionality and
    % rxnGeneMat as optional output
    %


    if isempty(regexp(notesField,'html:p', 'once'))
        tag = 'p';
    else
        tag = 'html:p';
    end

    subSystem = '';
    grRule = '';
    genes = {};
    rule = '';
    formula = '';
    confidenceScore = '';
    citation = '';
    ecNumber = '';
    %comment = ''; % removed b/c not returned by legacy code
    charge = [];
    rxnGeneMat = []; % added as optional return 

    if ischar(notesField) %if a string, use MH's code
        [~,fieldList] = regexp(notesField,['<' tag '>.*?</' tag '>'], ...
            'tokens', 'match');

        for i = 1:length(fieldList)
            fieldTmp = regexp(fieldList{i},['<' tag '>(.*)</' tag '>'], ...
                'tokens');
            fieldStr = fieldTmp{1}{1};
            if (regexp(fieldStr,'GENE_ASSOCIATION'))
                gprStr = regexprep(strrep(fieldStr, ...
                    'GENE_ASSOCIATION:',''), '^(\s)+','');
                grRule = gprStr;
                [genes,rule] = parseBoolean(gprStr);
            elseif (regexp(fieldStr,'GENE ASSOCIATION'))
                gprStr = regexprep(strrep(fieldStr, ...
                    'GENE ASSOCIATION:',''), '^(\s)+','');
                grRule = gprStr;
                [genes,rule] = parseBoolean(gprStr);
            elseif (regexp(fieldStr,'SUBSYSTEM'))
                subSystem = regexprep(strrep(fieldStr,'SUBSYSTEM:',''), ...
                    '^(\s)+','');
                subSystem = strrep(subSystem,'S_','');
                subSystem = regexprep(subSystem,'_+',' ');
                if (isempty(subSystem))
                    subSystem = 'Exchange';
                end
            elseif (regexp(fieldStr,'EC Number'))
                ecNumber = regexprep(strrep(fieldStr,'EC Number:',''), ...
                    '^(\s)+','');
            elseif (regexp(fieldStr,'FORMULA'))
                formula = regexprep(strrep(fieldStr,'FORMULA:',''), ...
                    '^(\s)+','');
            elseif (regexp(fieldStr,'CHARGE'))
                charge = str2num(regexprep(strrep(fieldStr, ...
                    'CHARGE:',''), '^(\s)+',''));
            elseif (regexp(fieldStr,'AUTHORS'))
                if isempty(citation)
                    citation = strcat(...
                        regexprep(strrep(fieldStr,'AUTHORS:',''), ...
                        '^(\s)+',''));
                else
                    citation = strcat(...
                        citation, ';', ...
                        regexprep(strrep(fieldStr,'AUTHORS:',''), ...
                        '^(\s)+',''));
                end
            elseif Comment == 1 && isempty(regexp(fieldStr,'genes:', ...
                    'once'))
                Comment = 0;
                comment = fieldStr;
            elseif (regexp(fieldStr,'Confidence'))
                confidenceScore = regexprep(strrep(fieldStr, ...
                    'Confidence Level:', ''), '^(\s)+', '');
                Comment = 1;
            end
        end

    elseif iscell(notesField) % if a cell array, use BH code

        NotesKeys = { ...
            'GENE_ASSOCIATION' ...
            'GENE ASSOCIATION' ...
            'SUBSYSTEM' ...
            'EC Number' ...
            'AUTHORS' ...
            'Confidence Level' ...
            'FORMULA' ...
            'CHARGE' ...
            };

        grRule = regexp(notesField, ...
            ['<' tag '>' NotesKeys{1} ':.*?</' tag '>'], 'match');
        key = NotesKeys{1};

        if sum(cellfun('isempty',grRule))
            grRule = regexp(notesField, ...
                ['<' tag '>' NotesKeys{2} ':.*?</' tag '>'], 'match');
            key = NotesKeys{2};
        end

        % strip HTML open tag and key text
        grRule = cellfun(@(x) regexprep(x, ['<' tag '>' key ': '], ...
            ''), grRule, 'UniformOutput', 0); 
        
        % strip tag close tags
        grRule = cellfun(@(x) regexprep(x, ['</\' tag '>'], ''), ...
            grRule, 'UniformOutput', 0); 

        [genes, rule, rxnGeneMat] = parseBoolean(grRule);
        
        subsystem = regexp(notesField, ...
            ['<' tag '>' NotesKeys{3} ':.*?</' tag '>'], 'match');
        
        % strip HTML open tag and key text
        subsystem = cellfun(@(x) ...
            regexprep(x, ['<' tag '>' NotesKeys{3} ': '], ''), ...
            subsystem, 'UniformOutput', 0);
        
        % strip tag close tags
        subsystem = cellfun(@(x) regexprep(x, ['</\' tag '>'],''), ...
            subsystem, 'UniformOutput', 0); 

%         subSystem = strrep(subSystem,'S_','');
%         subSystem = regexprep(subSystem,'_+',' ');
%         if (isempty(subSystem))
%             subSystem = 'Exchange';
%         end
 
        
        ec_string = regexp(notesField, ...
            ['<' tag '>' NotesKeys{4} ':.*?</' tag '>'] , 'match');
        
        % strip HTML open tag and key text
        ec_string = cellfun(@(x) regexprep(x, ...
            ['<' tag '>' NotesKeys{4} ': '], ''), ec_string, ...
            'UniformOutput', 0);
        
        % strip tag close tags
        ec_string = cellfun(@(x) regexprep(x, ['</\' tag '>'], ''), ...
            ec_string, 'UniformOutput', 0); 

        authors = regexp(notesField, ...
            ['<' tag '>' NotesKeys{5} ':.*?</' tag '>'] , 'match');
        
        % strip HTML open tag and key text
        authors = cellfun(@(x) regexprep(x, ...
            ['<' tag '>' NotesKeys{5} ': '], ''), authors, ...
            'UniformOutput', 0);
        
        % strip tag close tags
        authors = cellfun(@(x) regexprep(x, ['</\' tag '>'],''), ...
            authors, 'UniformOutput', 0); 

        confidence = regexp(notesField, ...
            ['<' tag '>' NotesKeys{6} ':.*?</' tag '>'] , 'match');
        
        % strip HTML open tag and key text
        confidence = cellfun(@(x) regexprep(x, ...
            ['<' tag '>' NotesKeys{6} ': '], ''), confidence, ...
            'UniformOutput', 0);
        
        % strip tag close tags
        confidence = cellfun(@(x) regexprep(x, ['</\' tag '>'], ''), ...
            confidence, 'UniformOutput', 0); 
        
        formula = regexp(notesField, ...
            ['<' tag '>' NotesKeys{7} ':.*?</' tag '>'] , 'match');
        
        % strip HTML open tag and key text
        formula = cellfun(@(x) regexprep(x, ...
            ['<' tag '>' NotesKeys{7} ': '], ''), formula, ...
            'UniformOutput', 0);
        
        % strip tag close tags
        formula = cellfun(@(x) regexprep(x, ['</\' tag '>'], ''), ...
            formula, 'UniformOutput', 0); 
        
        charge = regexp(notesField, ...
            ['<' tag '>' NotesKeys{8} ':.*?</' tag '>'] , 'match');
        
        % strip HTML open tag and key text
        charge = cellfun(@(x) regexprep(x, ...
            ['<' tag '>' NotesKeys{8} ': '], ''), charge, ...
            'UniformOutput', 0);
        
        % strip tag close tags
        charge = cellfun(@(x) regexprep(x, ['</\' tag '>'], ''), ...
            charge, 'UniformOutput', 0);
    end
    else
        errorstr = [...
            'The str variable passed to parseBoolean must be a string or ' ...
            'cell array.'];
        error(errorstr)
    end

end